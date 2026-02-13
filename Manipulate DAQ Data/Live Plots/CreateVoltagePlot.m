function CreateVoltagePlot(session)
% DAQ Pressure Transducer
% Create and display live plot of voltage readings

%   Inputs:
%   session - From DAQ session

    arguments
        session
    end

    nChannels = numel(session.Channels);

    if nChannels == 0
        error("No input channels configured.");
    end

    % Create figure
    figure('Name','Live Analog Input Voltages');
    hold on
    grid on

    xlabel("Time (s)")
    ylabel("Voltage (V)")
    title("Live Analog Input Voltages")

    colors = lines(nChannels);
    h = gobjects(nChannels,1);
    legendNames = strings(nChannels,1);

    for i = 1:1:nChannels
        h(i) = animatedline('Color', colors(i,:), 'LineWidth', 1.2);
        legendNames(i) = session.Channels(i).ID;
    end

    legend(legendNames, "Interpreter", "none", "Location", "best")

    startTime = tic;

    disp("Streaming... Press Ctrl+C to stop")

    % Continuous update loop
    while isvalid(session)

        data = read(session, seconds(0.1));

        if isempty(data)
            continue
        end

        t = seconds(data.Time - data.Time(1)) + toc(startTime);

        for i = 1:nChannels
            addpoints(h(i), t, data{:,i});
        end

        drawnow limitrate

    end
end