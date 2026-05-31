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

% in samples/s (Hz)
samplingRate = 1000; % Input desired sampling rate for DAQ 
session = startDAQSession(devices, samplingRate);

%% Configure sensors to channels 

% Configure any new transdcuers to the Transducer Configs folder
% Allocate transducers to DAQ channels

session = P17(session, devices.DeviceID, {"ai0"}); % Up/down direction
%session = P17(session, devices.DeviceID, {"ai1"}); % Left/right direction
%session = Omegadyne(session,devices.DeviceID,{"ai0"});

%% Create live plot for voltage 
%CreateVoltagePlot(session);