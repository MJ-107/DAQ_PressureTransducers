%% General notes on expirimental set-up

% Using NI DAQ USB 6008

% Using x2 P17 configured to differential channels 1 and 2
% P17 SN 10 cxn to channel 1
% P17 SN 11 cxn to channel 2


%% Log voltage, pressure, and time

% Input calibration constants for every sensor in order of configured
% channel
m = [0.11*1000]; % slope of calibration curve %9.0902 (SN10)
b = [0]; % y-intercept of calibration curve %-0.0002
% 
% Desired block interval (seconds)
readInterval = 1/1000;  % 0.1 seconds
runDuration  = 60; % in seconds
% 
baseFilename = "PressureLog";
% 
% %angleMeasurement ="P0_Y0";
% 
initializeCSVLogs(session, baseFilename)
%initialzeCSVLogsRSV(session, "PressureDAQ_Log.csv")
% 
logVoltagePressureTime(session, m, b, readInterval, runDuration, ...
     devices, baseFilename); 

%logVoltageRsv(session, readInterval, runDuration, devices, "PressureDAQ_Log.csv")

filename = 'PressureLog_Ch1.csv';
%filename = 'PressureDAQ_Log.csv';
plotPressureTime(filename);
plotVoltageTime(filename);
