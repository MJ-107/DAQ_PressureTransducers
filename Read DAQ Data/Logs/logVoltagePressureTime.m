function logVoltagePressureTime(session, m, b, readInterval, runDuration, devices, baseFilename)

    arguments
        % Arguments w/o default
        session
        m double
        b double
        readInterval double
        runDuration double
        devices
        baseFilename string
        %angleMeasurement string

    end

    nChannels = numel(session.Channels);

    if length(m) ~= nChannels || length(b) ~= nChannels
        error("Calibration constants m and b must match number of channels.");
    end

    startTime = tic; % Start timer
    disp(['Streaming and logging for ' num2str(runDuration) ' seconds...'])
    
        for i=1:1:nChannels
            fid(i) = fopen((baseFilename + "_Ch" + i + ".csv"),"a+");
        end
  
    start(session,"continuous"); % Start acquisition

        while toc(startTime) < runDuration
        data = read(session, seconds(readInterval));

            if isempty(data)
                continue
            end
    
        % Time
        % Add elapsed time since last tic
        t = seconds(data.Time - data.Time(1)) + toc(startTime);

        % Voltage
        V = data{:,1:nChannels};

        % Pressure using calibration function
        P = convertVoltageToPressure(V, m, b);

        % write to file 
            for i = 1:nChannels
                fprintf(fid(i), "%f, %f, %f\n", t(end), V(end,i), P(end,i));
            end

        end
    
    stop(session);

        for i = 1:1:nChannels
            fclose(fid(i));
        end

    disp("Finished logging.");
    
end