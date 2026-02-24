%% General notes on expirimental set-up

% Using NI DAQ USB 6008

% Using x2 P17 configured to differential channels 1 and 2
% P17 SN 10 cxn to channel 1
% P17 SN 11 cxn to channel 2

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

%% Configure sensors to channels 

% Configure any new transdcuers to the Transducer Configs folder
% Allocate transducers to DAQ channels

session = P17(session, devices.DeviceID, {"ai0"}); % Up/down direction
session = P17(session, devices.DeviceID, {"ai1"}); % Left/right direction

%% Create live plot for voltage 
%CreateVoltagePlot(session);

%% Log voltage, pressure, and time

% Input calibration constants for every sensor in order of configured
% channel
m = [9.0902 9.0924]; % slope of calibration curve
b = [-0.0002 -0.0002]; % y-intercept of calibration curve

% Desired block interval (seconds)
readInterval = 1/1000;  % 0.1 seconds
runDuration  = 10; % 10 seconds

initializeCSVLogs(session,"PressureDAQ_Log.csv")
logVoltagePressureTime(session, m, b, readInterval, runDuration, "PressureDAQ_Log.csv"); 
