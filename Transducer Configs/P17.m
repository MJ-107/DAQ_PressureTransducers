function session = P17(session, deviceID, channelList)

%   Inputs:
%     session - Existing DAQ session
%     devuceID - DAQ Device ID
%     channelList - List of desired channels to configure to this
%     transducer type

%   Outputs:
%     session - DAQ obj

    for i = 1:length(channelList)
        ch = addinput(session, deviceID, channelList{i}, "Voltage");
        ch.TerminalConfig = "Differential";
        ch.Range = [-5 5];  % Validyne P17 spec
    end

    fprintf("Added %d P17 channel(s)\n", length(channelList));
end

