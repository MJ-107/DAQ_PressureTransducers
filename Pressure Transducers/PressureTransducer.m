%% General notes on expirimental set-up

% Using NI DAQ USB 6008

% Using x2 P17 configured to differential channels 1 and 2
% P17 SN 10 cxn to channel 1
% P17 SN 11 cxn to channel 2


%% Log voltage, pressure, and time

% Input calibration constants for every sensor in order of configured
% channel
m = [0.090913*1000, 0.090911*1000]; % slope of calibration curve %9.0902 (SN10)
b = [0.0003,0.0006]; % y-intercept of calibration curve %-0.0002
% 
% Desired block interval (seconds)
readInterval = 1/1000;  % 0.1 seconds
runDuration  = 60; % in seconds
% 
baseFilename = "A2_JULY29_PressureLog_SPEED85GOOD";
% G
angleMeasurement ="SN10C1_PITCH_00_SN11C2_YAW_L30";
% 
initializeCSVLogs(session, baseFilename)
%initialzeCSVLogsRSV(session, "PressureDAQ_Log.csv")
% 
timestamp = string(datetime('now','Format','yyyyMMdd_HHmmss'));
logVoltagePressureTime(session, m, b, readInterval, runDuration, ...
     devices, baseFilename, timestamp, angleMeasurement); 

%logVoltageRsv(session, readInterval, runDuration, devices, "PressureDAQ_Log.csv")

%filename = 'PressureLog_Ch1.csv';
%filename = 'PressureDAQ_Log.csv';

% T = table(t, V);
% 
% 


% filepath = fullfile(currentProject.RootFolder, filename);
% filepath = fullfile(pwd, filename);
% filepath = fullfile(proj.RootFolder, filename);

% filepath = fullfile(pwd, char(filename));

% writetable(T, filepath);

%plotPressureTime(filename);
%plotVoltageTime(filename);