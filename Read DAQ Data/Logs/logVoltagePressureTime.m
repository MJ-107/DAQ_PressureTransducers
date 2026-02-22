function logVoltagePressureTime(session, m, b, readInterval, filename)

    arguments
        % Arguments w/o default
        session
        m double
        b double
        readInterval double
        % Arguments w/ default
        filename string = "DAQ_Log.csv"
    end

    nChannels = numel(session.Channels);

    if length(m) ~= nChannels || length(b) ~= nChannels
        error("Calibration constants m and b must match number of channels.");
    end

    startTime = tic; % Start time
    disp('Streaming and logging to CSV... Press Ctrl+C to stop')
    fid = fopen(filename,"a+");
    % while isvalid(session)
    % 
    %     data = read(session, seconds(readInterval));
    %     if isempty(data)
    %         continue
    %     end

    start(session, "continuous");
    while session.Running
        

        % Time
        t = seconds(data.Time) + toc(startTime);
        % Add elapsed time since last tic
        %t = seconds(data.Time - data.Time(1)) + toc(startTime);

        % Voltage
        V = data{:,1:nChannels};

        % Pressure using calibration function
        P = convertVoltageToPressure(V, m, b);

        fprintf(fid,"%s , %f, %f, %f, %f \n",t,V(1), V(2),P(1),P(2));
        % Append to CSV initialized in main
        % appendtoCSVLogs(filename, t, V, P);

    end

    fclose(fid);
end