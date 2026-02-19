function initializeCSVLogs(session, filename)

    channelNames = {session.Channels.ID};

    headers = ["Time_s", ...
               strcat(channelNames, "_Voltage"), ...
               strcat(channelNames, "_Pressure")];

    writecell(cellstr(headers), filename);

end