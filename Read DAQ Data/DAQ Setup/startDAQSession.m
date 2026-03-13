function session = startDAQSession(devices, samplingRate)

%   Inputs:
%     devices - String specifying DAQ vendor
%     samplingRate - Input rate in Hz for DAQ sampling

%   Outputs:
%     session - DAQ obj

    arguments
        devices table
        samplingRate double
    end

    % Use first detected device
    deviceID = devices.DeviceID(1);

    try
        % Create DAQ object
        session = daq("ni");

        session.Rate = samplingRate; %in kHz

        fprintf("Pressure DAQ session started on %s\n", deviceID);

    catch ME
        error("Failed to start DAQ session: %s", ME.message);
    end

end
