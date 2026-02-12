
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
    disp("DAQ detected:")
    disp(devices)
else
    fprintf("No DAQ devices detected for vendor '%s'.\n", vendor);
end

%% Create DAQ Session

  s = daq.createSession('ni');
  %add analog channel  s.addAnalogInputChannel('ID',channel num, 'measurement type')
  s.addAnalogInputChannel('Dev1',3, 'Voltage')