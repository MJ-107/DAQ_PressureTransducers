function [isConnected, devices] = checkDAQCxn(vendor)

%   Inputs:
%     vendor - String specifying DAQ vendor, e.g., 'ni'
%              Default is 'ni' for National Instruments.
%   Outputs:
%     isConnected - True if at least one device is detected
%     devices - Array of detected DAQ devices

    arguments
        vendor string = "ni"  % National Instruments
    end

    try
        % Get list of connected DAQ devices
        devices = daqlist;
        
        % Filter devices by vendor
        if ~isempty(devices)
            devices = devices(devices.VendorID == vendor, :);
        end

        % Return true if device found
        isConnected = ~isempty(devices);

    catch ME
        % If DAQ toolbox or drivers missing, return false
        warning("Could not detect DAQ devices: %s", ME.message)
        devices = [];
        isConnected = false;
    end

end

