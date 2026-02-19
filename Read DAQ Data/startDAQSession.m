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

        session.Rate = 1000; % 1 kHz sampling

        fprintf("Pressure DAQ session started on %s\n", deviceID);

    catch ME
        error("Failed to start DAQ session: %s", ME.message);
    end

end
