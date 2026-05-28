function session = P17(session, deviceID, channelList)

%   Inputs:
%     session - Existing DAQ session
%     devuceID - DAQ Device ID
%     channelList - List of desired channels to configure to this
%     transducer type

%   Outputs:
%     session - DAQ obj

    for i = 1:length(channelList)
        % Add channel
        ch = addinput(session, deviceID, channelList{i}, "Voltage");
        % Read default voltage
        disp("Initial range:")
        disp(ch.Range)

        % Set V range
        ch.Range = [-5 5];
        % Ensure V range is sensor working range
        disp("Final range:")
        disp(ch.Range)
        ch.TerminalConfig = "Differential";
        pause(2); % Add pause so user can stop run if config unideal
    end

    fprintf("Added %d P17 channel(s)\n", length(channelList));
end

