close all
clear all
clc

%% PITCH

P0_data = readmatrix("PressureLog_20260630_161605_Ch1_P0Y0_TR10P_TR11Y_T0.csv");
P3_data = readmatrix("PressureLog_20260630_162410_Ch1_P3Y0_TR10P_TR11Y_T0.csv");
P6_data = readmatrix("PressureLog_20260630_162910_Ch1_P6Y0_TR10P_TR11Y_T0.csv");
P9_data = readmatrix("PressureLog_20260630_163345_Ch1_P9Y0_TR10P_TR11Y_T0.csv");
PN3_data = readmatrix("PressureLog_20260630_163759_Ch1_P-3Y0_TR10P_TR11Y_T0.csv");
PN6_data = readmatrix("PressureLog_20260630_164144_Ch1_P-6Y0_TR10P_TR11Y_T0.csv");
PN9_data = readmatrix("PressureLog_20260630_164634_Ch1_P-9Y0_TR10P_TR11Y_T0.csv");

dP_P0 = mean(P0_data(:,3));
dP_P3 = mean(P3_data(:,3));
dP_P6 = mean(P6_data(:,3));
dP_P9 = mean(P9_data(:,3));
dP_PN3 = mean(PN3_data(:,3));
dP_PN6 = mean(PN6_data(:,3));
dP_PN9 = mean(PN9_data(:,3));

alpha_P = [0, 3, 6, 9, -3, -6, -9];
deltaP_P= [dP_P0, dP_P3, dP_P6, dP_P9, dP_PN3, dP_PN6, dP_PN9];

%% Yaw 30 deg and pitch variac 50%

P0_Y30 = readmatrix("PressureLog_20260708_141122_Ch1_V2_VARIAC_50P_P_SN10_Y_SN11_P00Y30.csv");
P6_Y30 = readmatrix("PressureLog_20260708_141513_Ch1_V2_VARIAC_50P_P_SN10_Y_SN11_P06Y30.csv");
P12_Y30 = readmatrix("PressureLog_20260708_144040_Ch1_V2_VARIAC_50P_P_SN10_Y_SN11_P12Y30.csv");
P18_Y30 = readmatrix("PressureLog_20260708_145344_Ch1_V2_VARIAC_50P_P_SN10_Y_SN11_P18Y30.csv");
PN6_Y30 = readmatrix("PressureLog_20260708_150946_Ch1_V2_VARIAC_50P_P_SN10_Y_SN11_P-6Y30.csv");
PN12_Y30 = readmatrix("PressureLog_20260708_152141_Ch1_V2_VARIAC_50P_P_SN10_Y_SN11_P-12Y30.csv");
PN18_Y30 = readmatrix("PressureLog_20260708_152522_Ch1_V2_VARIAC_50P_P_SN10_Y_SN11_P-18Y30.csv");

dP_P0_Y30 = mean(P0_Y30(:,3));
dP_P6_Y30 = mean(P6_Y30(:,3));
dP_P12_Y30 = mean(P12_Y30(:,3));
dP_P18_Y30 = mean(P18_Y30(:,3));
dP_PN6_Y30 = mean(PN6_Y30(:,3));
dP_PN12_Y30 = mean(PN12_Y30(:,3));
dP_PN18_Y30 = mean(PN18_Y30(:,3));

alpha_P_YAW30 = [0, 6, 12, 18, -6, -12, -18];
deltaP_P_YAW30 = [dP_P0_Y30, dP_P6_Y30, dP_P12_Y30, dP_P18_Y30, dP_PN6_Y30, dP_PN12_Y30, dP_PN18_Y30];

% figure(1)
% scatter(alpha_P, deltaP_P, 40, 'filled')
% grid on
% xlabel('\alpha (deg)')
% ylabel('\Delta P (Pa)')
% title('Pitch Direction (\alpha) vs \Delta P')

% Linear fit for DeltaP45 vs Alpha
p_alpha = polyfit(alpha_P, deltaP_P, 1);
alpha_fit = linspace(min(alpha_P), max(alpha_P), 100);
dP_P_fit = polyval(p_alpha, alpha_fit);

% Linear fit for DeltaP45 vs Alpha - 50 pc velocity
p_alpha_50 = polyfit(alpha_P_YAW30, deltaP_P_YAW30, 1);
alpha_fit_50 = linspace(min(alpha_P_YAW30), max(alpha_P_YAW30), 100);
dP_P_fit_50 = polyval(p_alpha_50, alpha_fit_50);

% 
% figure(2)
% scatter(alpha_P, deltaP_P, 40, 'filled')
% hold on
% plot(alpha_fit, dP_P_fit, 'r', 'LineWidth', 2)
% grid on
% slope = p_alpha(1);
% intercept = p_alpha(2);
% eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);
% text(1.5, 8.0, eqnString, 'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');
% xlabel('\alpha (deg)')
% ylabel('\Delta P (Pa)')
% title('Pitch Direction (\alpha) vs \Delta P')
% legend('Data', 'Linear Fit')

velocity =26;
non_dimensionalize_by_dynamic_pressure = 0.5*1.2*velocity^2;

vel50pc = 22;
non_dimensionalize_by_dynamic_pressure_50pc = 0.5*1.2*vel50pc^2;


nd_Alpha_Pressure = (deltaP_P./non_dimensionalize_by_dynamic_pressure);
nd_Alpha_Pressure_50 = (deltaP_P_YAW30./non_dimensionalize_by_dynamic_pressure_50pc);

nd_p_alpha = polyfit(alpha_P, nd_Alpha_Pressure, 1);
nd_alpha_fit = linspace(min(alpha_P), max(alpha_P), 100);
nd_alphapressure_fit = polyval(nd_p_alpha, nd_alpha_fit);

%50pc run
nd_p_alpha_Y30 = polyfit(alpha_P_YAW30, nd_Alpha_Pressure_50, 1);
nd_alpha_fit_Y30 = linspace(min(alpha_P_YAW30), max(alpha_P_YAW30), 100);
nd_alphapressure_fit_Y30 = polyval(nd_p_alpha_Y30, nd_alpha_fit_Y30);

% figure(3)
% scatter(alpha_P, nd_Alpha_Pressure, 40, 'filled')
% hold on
% plot(nd_alpha_fit, nd_alphapressure_fit , 'r', 'LineWidth', 2)
% grid on
% slope = nd_p_alpha(1);
% intercept = nd_p_alpha(2);
% eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);
% xl = xlim;
% yl = ylim;
% text(xl(1)+0.6*diff(xl), yl(2)-0.55*diff(yl),eqnString, 'FontSize',12, 'FontWeight','bold');
% xlabel('\alpha (deg)')
% ylabel('$\frac{\Delta P}{\frac{1}{2} \rho v^2}$', Interpreter='latex', rotation=0, FontSize=16)
% title('Pitch Direction (\alpha) vs \Delta P')
% legend('Data', 'Linear Fit')

%% Plot pitch vs PCF

%% extract fig data
fig = openfig('pcf2.fig','invisible');

% Find all axes
ax = findobj(fig,'Type','axes');

% Find all line objects
lines = findobj(ax,'Type','line');

% Extract X and Y data
for i = 1:length(lines)
    X{i} = lines(i).XData;
    Y{i} = lines(i).YData;
end

%Close the figure
% close(fig)

%% Open the existing figure
clf
fig = openfig('pcf2.fig');

% Make it the current figure
figure(fig)
hold on


% Plot 
scatter(alpha_P, nd_Alpha_Pressure, 40, 'filled')
plot(nd_alpha_fit, nd_alphapressure_fit, 'LineWidth', 2,'Color',[1 0.5 0])
scatter(alpha_P_YAW30, nd_Alpha_Pressure_50, 40, 'filled')
plot(nd_alpha_fit_Y30, nd_alphapressure_fit_Y30, 'LineWidth', 2,'Color',[0 1 0])
grid on
% % aeroprobe eq
% slope = nd_p_alpha(1);
% intercept = nd_p_alpha(2);
% eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);
% xl = xlim;
% yl = ylim;
% text(xl(1)+0.2*diff(xl), yl(2)-0.45*diff(yl),eqnString, 'FontSize',12, 'FontWeight','bold');
% my eq
slope = nd_p_alpha(1);
intercept = nd_p_alpha(2);
eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);
slope2 = nd_p_alpha_Y30(1);
intercept2 = nd_p_alpha_Y30(2);
eqnString2 = sprintf('y = %.2fx + %.2f', slope2, intercept2);
xl = xlim;
yl = ylim;
text(xl(1)+0.2*diff(xl), yl(2)-0.4*diff(yl),eqnString, 'FontSize',12, 'FontWeight','bold');
text(xl(1)+0.46*diff(xl), yl(2)-0.7*diff(yl),eqnString2, 'FontSize',12, 'FontWeight','bold');
xlabel('\alpha (deg)')
ylabel('$\frac{\Delta P}{\frac{1}{2} \rho v^2}$', Interpreter='latex', rotation=0, FontSize=16)
title('Pitch Direction (\alpha) vs \Delta P')
legend('Aeroprobe Calibration Data', 'Aeroprobe Calibration Linear Fit', 'Experimental Data Y=0', ...
    'Experimental Data Y=0 Linear Fit','Experimental Data Y=30', 'Experimental Data Y=30 Linear Fit','Location', 'northwest');
grid on

% Create arrow
annotation(fig,'arrow',[0.521785714285714 0.493214285714286],...
    [0.381380952380952 0.435714285714286]);

% Create arrow
annotation(fig,'arrow',[0.63892857142857 0.603214285714284],...
    [0.545190476190479 0.593809523809526]);

% Create arrow
annotation(fig,'arrow',[0.506071428571429 0.544642857142857],...
    [0.586190476190476 0.582380952380952]);


% % Load the figure without displaying it
% fig = openfig('pcfalphand.fig','invisible');
% 
% % Find the axes
% ax = findobj(fig,'Type','axes');
% 
% % Find scatter objects
% sc = findobj(ax,'Type','Scatter');
% 
% % Find line objects (fit lines)
% ln = findobj(ax,'Type','Line');
% 
% % Extract scatter data
% for k = 1:length(sc)
%     Xscatter{k} = sc(k).XData;
%     Yscatter{k} = sc(k).YData;
% end
% 
% % Extract line data
% for k = 1:length(ln)
%     Xline{k} = ln(k).XData;
%     Yline{k} = ln(k).YData;
% end
% 
% % Close the figure
% close(fig)


%% Yaw

% deltaP_yaw = 
% 
% deltaP_pitch = 