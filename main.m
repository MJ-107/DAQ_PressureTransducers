
% Using DAQ USB 6008
%% Initialize
close all
clear all
clc

%% Check DAQ cxn

% Specify DAQ vendor
vendor = "ni"; % National Instruments

% Check cxn
[isConnected, devices] = checkDAQCxn(vendor);

% Handle results and display for user
if isConnected % Cxn found
    fprintf("DAQ detected! Found %d device(s):\n", numel(devices));
    for i = 1:1:numel(devices)
        fprintf("  Device %d: %s (%s)\n", i, devices(i).Model, ...
            devices(i).ID);
    end

else % Cxn not found
    fprintf("No DAQ devices detected for vendor '%s'.\n", vendor);
    return
end