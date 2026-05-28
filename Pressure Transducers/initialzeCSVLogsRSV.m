function initialzeCSVLogsRSV(session, filename)

    channelNames = {session.Channels.ID};

    headers = ["Time_s", ...
               strcat(channelNames, "_Voltage")];

    writecell(cellstr(headers), filename);

    disp("CSV file out initialized.");
end
