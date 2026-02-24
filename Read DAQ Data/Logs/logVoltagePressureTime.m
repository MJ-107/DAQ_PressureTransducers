function logVoltagePressureTime(session, m, b, readInterval, runDuration, filename)

    arguments
        % Arguments w/o default
        session
        m double
        b double
        readInterval double
        runDuration double

        % Arguments w/ default
        filename string = "DAQ_Log.csv"
    end

    nChannels = numel(session.Channels);

    if length(m) ~= nChannels || length(b) ~= nChannels
        error("Calibration constants m and b must match number of channels.");
    end

    startTime = tic; % Start timer
    disp(['Streaming and logging for ' num2str(runDuration) ' seconds...'])
    fid = fopen(filename,"a+");
    
    % while isvalid(session)
    % 
    %     data = read(session, seconds(readInterval));
    %     if isempty(data)
    %         continue
    %     end

    start(session,"continuous"); % Start acquisition

        while toc(startTime) < runDuration
        data = read(session, seconds(readInterval));

        if isempty(data)
            continue
        end
    
        % Time
        t = seconds(data.Time) + toc(startTime);
        % Add elapsed time since last tic
        %t = seconds(data.Time - data.Time(1)) + toc(startTime);

        % Voltage
        V = data{:,1:nChannels};

        % Pressure using calibration function
        P = convertVoltageToPressure(V, m, b);

        %write to file 
        fprintf(fid,"%s , %f, %f, %f, %f \n",t(end),V(end,1), V(end,2),P(end,1),P(end,2));

        % Append to CSV initialized in main
        appendtoCSVLogs(filename, t, V, P);

    end
    
    stop(session);
    fclose(fid);
    disp("Finished logging.");
    
end