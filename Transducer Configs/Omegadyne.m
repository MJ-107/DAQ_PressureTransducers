function session = Omegadyne(session, deviceID, channelList)

%   Inputs:
%     session - Existing DAQ session
%     devuceID - DAQ Device ID
%     channelList - List of desired channels to configure to this
%     transducer type

%   Outputs:
%     session - DAQ obj

    for i = 1:length(channelList)
        ch = addinput(session, deviceID, channelList{i}, "Voltage");
        ch.TerminalConfig = "Single Ended";
        ch.Range = [0 5];  % Omegadyne spec
    end

    fprintf("Added %d Omegadyne channel(s)\n", length(channelList));
end