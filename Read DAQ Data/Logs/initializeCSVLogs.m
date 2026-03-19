function initializeCSVLogs(session, baseFilename)

    nChannels = numel(session.Channels);

    for i = 1:nChannels
        filename = baseFilename + "_Ch" + i + ".csv";

        headers = {"Time_s", "Voltage", "Pressure"};

        writecell(headers, filename);
    end

    disp("CSV files initialized correctly.");
end