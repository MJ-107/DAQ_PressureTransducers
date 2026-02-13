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

%% Create live plots of voltage and pressure 

CreateVoltagePlot(session);

% Input calibration constants for every sensor in order of configured
% channel
m = [9.0902 9.0924]; % slope of calibration curve
b = [-0.0002 -0.0002]; % y-intercept of calibration curve

convertVoltageToPressure(session,m,b);

[P_log, V_log, t_log] = logVoltagePressureTime...
    (session, m, b, "PressureDAQ_Log.csv"); 