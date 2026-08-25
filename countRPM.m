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

addinput(session,"Dev1","port0/line0","Digital");

%% Measurement Parameters
PPR = 20;                 % Pulses per revolution
measurementTime = 10;     % seconds

disp("Counting pulses...")

%% Read Initial State
data = read(session);
previousState = logical(data.Variables);

pulseCount = 0;

%% Count Rising Edges
tic

while toc < measurementTime

    data = read(session);
    currentState = logical(data.Variables);

    % Rising edge detection
    if currentState && ~previousState
        pulseCount = pulseCount + 1;
    end

    previousState = currentState;

end


%% Configure sensors to channels 

% Configure any new transdcuers to the Transducer Configs folder
% Allocate transducers to DAQ channels

% session = P17(session, devices.DeviceID, {"ai0"}); % Up/down direction
% session = P17(session, devices.DeviceID, {"ai1"}); % Left/right direction
% session = 