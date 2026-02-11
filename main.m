
% Using DAQ USB 6008
%% Initialize
close all
clear all
clc

%% Check if DAQ(s) connected
vendor = "ni";

[isConnected, devices] = checkDAQCxn(vendor);

% Display results
if isConnected
    fprintf("DAQ detected! Found %d device(s):\n", height(devices));

    for i = 1:1:height(devices)
        fprintf("Device %d:\n", i);
        fprintf("Vendor: %s\n", devices.VendorID(i));
        fprintf("Model:  %s\n", devices.Model(i));
        fprintf("ID:     %s\n", devices.DeviceID(i));
    end

else
    fprintf("No DAQ devices detected for vendor '%s'.\n", vendor);
end

%% 