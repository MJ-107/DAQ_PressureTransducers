function logVoltagePressureTime(session, m, b, filename)

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

    % Initialize CSV file with headers
    initializeCSV(session, filename);

    startTime = tic;
    disp('Streaming and logging to CSV... Press Ctrl+C to stop')

    while isvalid(session)

        data = read(session, seconds(0.1));
        if isempty(data)
            continue
        end

        % Time vector
        t = seconds(data.Time - data.Time(1)) + toc(startTime);

        % Voltage
        V = data{:,1:nChannels};

        % Pressure using calibration function
        P = convertVoltageToPressure(V, m, b);

        % Append to CSV initialized in main
        appendToCSV(filename, t, V, P);

    end
end