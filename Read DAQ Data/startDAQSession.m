function session = startDAQSession(devices)

%   Inputs:
%     devices - String specifying DAQ vendor

%   Outputs:
%     session - DAQ obj

    arguments
        devices table
    end

    % Use first detected device
    deviceID = devices.DeviceID(1);

    try
        % Create DAQ object
        session = daq("ni");

        % Channel 1 - Differential
        % For up/down direction
        ch1 = addinput(session, deviceID, "ai0", "Voltage");
        ch1.TerminalConfig = "Differential";
        ch1.Range = [-5 5]; % Range specified by Validyne for P17

        % % Channel 2 - Differential
        % % For left/right direction
        % % ch2 = addinput(session, deviceID, "ai1", "Voltage");
        % % ch2.TerminalConfig = "Differential";
        % % ch2.Range = [-5 5]; % Range specified by Validyne for P17

        session.Rate = 1000; % 1 kHz sampling

        fprintf("Pressure DAQ session started on %s\n", deviceID);

    catch ME
        error("Failed to start DAQ session: %s", ME.message);
    end

end
