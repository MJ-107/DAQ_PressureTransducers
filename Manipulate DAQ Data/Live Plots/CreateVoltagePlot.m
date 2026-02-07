% DAQ Pressure Transducer
% Create and display live plot of voltage readings

%   Inputs:
%     data - live numerical data from DAQ
%     channelNames - Input channels in use


function CreateVoltagePlot(data, channelNames)

    time = data.Time; % Get time vector
    numberOfChanels = numel(channelNames); % Get number of input chanels

    % Initialize figure
    figure
    hold on
    grid on

    % Cycle through input chanels and plot
    for i = 1:1:numberOfChanels
        plot(time, data.(channelNames{i}), "LineWidth", 1.2)
    end

    hold off

    % Add axis labels
    xlabel("Time (s)")
    ylabel("Voltage (V)")
    title("Live Analog Input Voltages")
    legend(channelNames, "Interpreter", "none", "Location", "best")
end
