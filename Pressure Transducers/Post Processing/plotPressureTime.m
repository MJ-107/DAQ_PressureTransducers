function plotPressureTime(logfilename)

dataTable = table2array(readtable(logfilename));
time = dataTable(:,1);
pressure = dataTable(:,3);

figure;
plot(time, pressure, '-b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Pressure (Pa)');
title('Pressure vs Time');
grid on;

end