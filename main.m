% Using NI DAQ USB 6008

%% Initialize
close all
clear all
clc

%% Check if DAQ(s) connected
vendor = "ni";

[isConnected, devices] = checkDAQCxn(vendor);

% Display results

if isConnected
    disp("DAQ detected:")
    disp(devices)
else
    fprintf("No DAQ devices detected for vendor '%s'.\n", vendor);
end

%% Create DAQ Session

% Call function to start DAQ session
% Note that channel configuration appears in startDAQSession fcn
    session = startDAQSession(devices);

%% Create live plots of voltage and pressure 

CreateVoltagePlot(session);

