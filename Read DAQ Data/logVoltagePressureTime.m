function [P_log, V_log, t_log] = logVoltagePressureTime(session, m, b, filename)

    arguments
        session
        m double
        b double
        filename string = "DAQ_Log.csv"
    end

    nChannels = numel(session.Channels);

    if length(m) ~= nChannels || length(b) ~= nChannels
        error("Calibration vectors m and b must match number of channels.");
    end

    % Initialize logs
    P_log = [];
    V_log = [];
    t_log = [];

    % Prepare CSV file with headers
    channelNames = {session.Channels.ID};
    headers = ["Time_s", strcat(channelNames, "_Voltage"), ...
        strcat(channelNames, "_Pressure")];
    writematrix(headers, filename);

    % Start streaming
    startTime = tic;
    disp('Streaming and logging to CSV... Press Ctrl+C to stop')

    while isvalid(session)

        % Read a short block of data
        data = read(session, seconds(0.1));
        if isempty(data)
            continue
        end

        % Time vector
        t = seconds(data.Time - data.Time(1)) + toc(startTime);

        % Voltages and pressures
        V = zeros(size(data,1), nChannels);
        P = zeros(size(data,1), nChannels);

        for i = 1:nChannels
            V(:,i) = data{:,i};
            P(:,i) = applyCalibration(V(:,i), m(i), b(i));
        end

        % Append to logs
        V_log = [V_log; V];
        P_log = [P_log; P];
        t_log = [t_log; t];

        % Write to CSV in append mode
        out = [t, V, P];
        writematrix(out, filename, 'WriteMode','append');
    end
end