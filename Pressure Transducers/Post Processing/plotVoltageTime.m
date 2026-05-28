function plotVoltageTime(logfilename)

dataTable = table2array(readtable(logfilename));
time = dataTable(:,1);
voltage = dataTable(:,2);

figure;
plot(time, voltage, '-b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage vs Time');
grid on;

end