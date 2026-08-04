close all
clear all
clc


toInterest = "PressureLog_20260624_095238_test0.csv";
P0Y0 = table2array(readtable(toInterest));
avgpressure_P0Y0 = mean(P0Y0(:,3));
time_P0Y0 = P0Y0(:,1);
P0Y0_vel = sqrt(2.*P0Y0(:,3)./1.118);

plotPressureTime(toInterest);

figure;
plot(time_P0Y0, P0Y0_vel, '-b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity over Time');
    grid on;

    

% PN15Y0 = readtable("PressureLog_20260623_165756_PN15Y0.csv");
% avgpressure_PN15Y0 = mean(PN15Y0(:,3));
% 
% PN30Y0 = readtable("PressureLog_20260623_170301_PN30Y0.csv");
% avgpressure_PN30Y0 = mean(PN30Y0(:,3));



