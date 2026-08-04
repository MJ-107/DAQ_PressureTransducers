close all
clear all
clc

%% 30 VARIAC

% PITCH ONLY

P0_data = readmatrix("PressureLog_20260715_143051_Ch1_JUL15V2_VARIAC30_P_SN10_00_Y_SN11_00.csv");
P3_data = readmatrix("PressureLog_20260715_143429_Ch1_JUL15V2_VARIAC30_P_SN10_P03_Y_SN11_00.csv");
P6_data = readmatrix("PressureLog_20260715_144349_Ch1_JUL15V2_VARIAC30_P_SN10_P06_Y_SN11_00.csv");
PN3_data = readmatrix("PressureLog_20260715_145916_Ch1_JUL15V2_VARIAC30_P_SN10_N03_Y_SN11_00.csv");
PN6_data = readmatrix("PressureLog_20260715_150835_Ch1_JUL15V2_VARIAC30_P_SN10_N06_Y_SN11_00.csv");

dP_P0 = mean(P0_data(:,3));
dP_P3 = mean(P3_data(:,3));
dP_P6 = mean(P6_data(:,3));
dP_PN3 = mean(PN3_data(:,3));
dP_PN6 = mean(PN6_data(:,3));

alpha_P = [0, 3, 6, -3, -6];
deltaP_P= [dP_P0, dP_P3, dP_P6, dP_PN3, dP_PN6];

% Yaw 30 deg and pitch variac

P0_Y30 = readmatrix("PressureLog_20260715_152047_Ch1_JUL15V2_VARIAC30_P_SN10_00_Y_SN11_30.csv");
P3_Y30 = readmatrix("PressureLog_20260715_153401_Ch1_JUL15V2_VARIAC30_P_SN10_P03_Y_SN11_30.csv");
P6_Y30 = readmatrix("PressureLog_20260715_154335_Ch1_JUL15V2_VARIAC30_P_SN10_P06_Y_SN11_30.csv");
PN3_Y30 = readmatrix("PressureLog_20260715_155528_Ch1_JUL15V2_VARIAC30_P_SN10_N03_Y_SN11_30.csv");
PN6_Y30 = readmatrix("PressureLog_20260715_160734_Ch1_JUL15V2_VARIAC30_P_SN10_N06_Y_SN11_30.csv");

dP_P0_Y30 = mean(P0_Y30(:,3));
dP_P3_Y30 = mean(P3_Y30(:,3));
dP_P6_Y30 = mean(P6_Y30(:,3));
dP_PN3_Y30 = mean(PN3_Y30(:,3));
dP_PN6_Y30 = mean(PN6_Y30(:,3));

alpha_P_YAW30 = [0, 3, 6, -3, -6];
deltaP_P_YAW30 = [dP_P0_Y30, dP_P3_Y30, dP_P6_Y30, dP_PN3_Y30, dP_PN6_Y30];

% 
p_alpha = polyfit(alpha_P, deltaP_P, 1);
alpha_fit = linspace(min(alpha_P), max(alpha_P), 100);
dP_P_fit = polyval(p_alpha, alpha_fit);

% Linear fit for DeltaP45 vs Alpha - 50 pc velocity
p_alpha_YAW30 = polyfit(alpha_P_YAW30, deltaP_P_YAW30, 1);
alpha_fit_YAW30 = linspace(min(alpha_P_YAW30), max(alpha_P_YAW30), 100);
dP_P_fit_YAW30 = polyval(p_alpha_YAW30, alpha_fit_YAW30);

velcalc = readmatrix("PressureLog_20260716_171155_Ch2_SPEED30.csv");
pdynamic = mean(velcalc(:,3));
velocity = (pdynamic*2/1.225)^(1/2);
disp(velocity)
non_dimensionalize_by_dynamic_pressure = 0.5*1.2*velocity^2;

nd_Alpha_Pressure = (deltaP_P./non_dimensionalize_by_dynamic_pressure);
nd_Alpha_Pressure_YAW30 = (deltaP_P_YAW30./non_dimensionalize_by_dynamic_pressure);

%dimensonal
% nd_Alpha_Pressure = (deltaP_P);
% nd_Alpha_Pressure_YAW30 = (deltaP_P_YAW30);

nd_p_alpha = polyfit(alpha_P, nd_Alpha_Pressure, 1);
nd_alpha_fit = linspace(min(alpha_P), max(alpha_P), 100);
nd_alphapressure_fit = polyval(nd_p_alpha, nd_alpha_fit);

nd_p_alpha_YAW30 = polyfit(alpha_P_YAW30, nd_Alpha_Pressure_YAW30, 1);
nd_alpha_fit_YAW30 = linspace(min(alpha_P_YAW30), max(alpha_P_YAW30), 100);
nd_alphapressure_fit_YAW30 = polyval(nd_p_alpha_YAW30, nd_alpha_fit_YAW30);

%% extract fig data
%fig = openfig('pcf2.fig','invisible');
%dimensional
%fig=openfig('calcurvedimensional.fig','invisible');
fig=openfig('ndsmallrange.fig','invisible');
% Find all axes
ax = findobj(fig,'Type','axes');

% Find all line objects
lines = findobj(ax,'Type','line');

% Extract X and Y data
for i = 1:length(lines)
    X{i} = lines(i).XData;
    Y{i} = lines(i).YData;
end

%% Open the existing figure
clf
%fig=openfig('calcurvedimensional.fig','invisible');
fig=openfig('ndsmallrange.fig','invisible');

% Make it the current figure
figure(fig)
hold on

% Plot 
scatter(alpha_P, nd_Alpha_Pressure, 40, 'filled', 'MarkerFaceColor', [1, 0.9, 0])
plot(nd_alpha_fit, nd_alphapressure_fit, 'LineWidth', 2, 'Color', 'y')

scatter(alpha_P_YAW30, nd_Alpha_Pressure_YAW30, 40, 'filled', 'MarkerFaceColor', 'g')
plot(nd_alpha_fit_YAW30, nd_alphapressure_fit_YAW30, 'LineWidth', 2, 'Color', 'g')
grid on

slope = nd_p_alpha(1);
intercept = nd_p_alpha(2);
eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);

slope2 = nd_p_alpha_YAW30(1);
intercept2 = nd_p_alpha_YAW30(2);
eqnString2 = sprintf('y = %.2fx + %.2f', slope2, intercept2);

xl = xlim;
yl = ylim;
text(xl(1)+0.25*diff(xl), yl(2)-0.1*diff(yl),eqnString, 'FontSize',12, 'FontWeight','bold');
text(xl(1)+0.25*diff(xl), yl(2)-0.15*diff(yl),eqnString2, 'FontSize',12, 'FontWeight','bold');

grid on


%% 75 VARIAC

% PITCH ONLY

P0_data = readmatrix("PressureLog_20260715_142225_Ch1_JUL15V2_VARIAC75_P_SN10_00_Y_SN11_00.csv");
P3_data = readmatrix("PressureLog_20260715_142225_Ch1_JUL15V2_VARIAC75_P_SN10_00_Y_SN11_00.csv");
P6_data = readmatrix("PressureLog_20260715_145010_Ch1_JUL15V2_VARIAC75_P_SN10_P06_Y_SN11_00.csv");
PN3_data = readmatrix("PressureLog_20260715_150223_Ch1_JUL15V2_VARIAC75_P_SN10_N03_Y_SN11_00.csv");
PN6_data = readmatrix("PressureLog_20260715_151111_Ch1_JUL15V2_VARIAC75_P_SN10_N06_Y_SN11_00.csv");

dP_P0 = mean(P0_data(:,3));
dP_P3 = mean(P3_data(:,3));
dP_P6 = mean(P6_data(:,3));
dP_PN3 = mean(PN3_data(:,3));
dP_PN6 = mean(PN6_data(:,3));

alpha_P = [0, 3, 6, -3, -6];
deltaP_P= [dP_P0, dP_P3, dP_P6, dP_PN3, dP_PN6];

% Yaw 30 deg and pitch variac

P0_Y30 = readmatrix("PressureLog_20260715_152352_Ch1_JUL15V2_VARIAC75_P_SN10_00_Y_SN11_30.csv");
P3_Y30 = readmatrix("PressureLog_20260715_153659_Ch1_JUL15V2_VARIAC75_P_SN10_P03_Y_SN11_30.csv");
P6_Y30 = readmatrix("PressureLog_20260715_154655_Ch1_JUL15V2_VARIAC75_P_SN10_P06_Y_SN11_30.csv");
PN3_Y30 = readmatrix("PressureLog_20260715_160115_Ch1_JUL15V2_VARIAC75_P_SN10_N03_Y_SN11_30.csv");
PN6_Y30 = readmatrix("PressureLog_20260715_161027_Ch1_JUL15V2_VARIAC75_P_SN10_N06_Y_SN11_30.csv");

dP_P0_Y30 = mean(P0_Y30(:,3));
dP_P3_Y30 = mean(P3_Y30(:,3));
dP_P6_Y30 = mean(P6_Y30(:,3));
dP_PN3_Y30 = mean(PN3_Y30(:,3));
dP_PN6_Y30 = mean(PN6_Y30(:,3));

alpha_P_YAW30 = [0, 3, 6, -3, -6];
deltaP_P_YAW30 = [dP_P0_Y30, dP_P3_Y30, dP_P6_Y30, dP_PN3_Y30, dP_PN6_Y30];

% 
p_alpha = polyfit(alpha_P, deltaP_P, 1);
alpha_fit = linspace(min(alpha_P), max(alpha_P), 100);
dP_P_fit = polyval(p_alpha, alpha_fit);

% Linear fit for DeltaP45 vs Alpha - 50 pc velocity
p_alpha_YAW30 = polyfit(alpha_P_YAW30, deltaP_P_YAW30, 1);
alpha_fit_YAW30 = linspace(min(alpha_P_YAW30), max(alpha_P_YAW30), 100);
dP_P_fit_YAW30 = polyval(p_alpha_YAW30, alpha_fit_YAW30);

velcalc = readmatrix("PressureLog_20260716_172425_Ch2_SPEED75.csv");
pdynamic = mean(velcalc(:,3));
velocity = (pdynamic*2/1.225)^(1/2);
disp(velocity)
non_dimensionalize_by_dynamic_pressure = 0.5*1.2*velocity^2;

nd_Alpha_Pressure = (deltaP_P./non_dimensionalize_by_dynamic_pressure);
nd_Alpha_Pressure_YAW30 = (deltaP_P_YAW30./non_dimensionalize_by_dynamic_pressure);

%dimensional
% nd_Alpha_Pressure = (deltaP_P);
% nd_Alpha_Pressure_YAW30 = (deltaP_P_YAW30);

nd_p_alpha = polyfit(alpha_P, nd_Alpha_Pressure, 1);
nd_alpha_fit = linspace(min(alpha_P), max(alpha_P), 100);
nd_alphapressure_fit = polyval(nd_p_alpha, nd_alpha_fit);

nd_p_alpha_YAW30 = polyfit(alpha_P_YAW30, nd_Alpha_Pressure_YAW30, 1);
nd_alpha_fit_YAW30 = linspace(min(alpha_P_YAW30), max(alpha_P_YAW30), 100);
nd_alphapressure_fit_YAW30 = polyval(nd_p_alpha_YAW30, nd_alpha_fit_YAW30);

%% black to Plot 
scatter(alpha_P, nd_Alpha_Pressure, 40, 'filled', 'MarkerFaceColor', [1, 0.5, 0])
plot(nd_alpha_fit, nd_alphapressure_fit, 'LineWidth', 2, 'Color', [1, 0.5, 0])

scatter(alpha_P_YAW30, nd_Alpha_Pressure_YAW30, 40, 'filled', 'MarkerFaceColor', [0.5, 0, 0.5])
plot(nd_alpha_fit_YAW30, nd_alphapressure_fit_YAW30, 'LineWidth', 2, 'Color', [0.5, 0, 0.5])

slope = nd_p_alpha(1);
intercept = nd_p_alpha(2);
eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);

slope2 = nd_p_alpha_YAW30(1);
intercept2 = nd_p_alpha_YAW30(2);
eqnString2 = sprintf('y = %.2fx + %.2f', slope2, intercept2);

xl = xlim;
yl = ylim;
text(xl(1)+0.25*diff(xl), yl(2)-0.2*diff(yl),eqnString, 'FontSize',12, 'FontWeight','bold');
text(xl(1)+0.25*diff(xl), yl(2)-0.25*diff(yl),eqnString2, 'FontSize',12, 'FontWeight','bold');

%% 85 VARIAC

% PITCH ONLY

P0_data = readmatrix("PressureLog_20260715_142751_Ch1_JUL15V2_VARIAC85_P_SN10_00_Y_SN11_00.csv");
P3_data = readmatrix("PressureLog_20260715_144013_Ch1_JUL15V2_VARIAC85_P_SN10_P03_Y_SN11_00.csv");
P6_data = readmatrix("PressureLog_20260715_145300_Ch1_JUL15V2_VARIAC85_P_SN10_P06_Y_SN11_00.csv");
PN3_data = readmatrix("PressureLog_20260715_150523_Ch1_JUL15V2_VARIAC85_P_SN10_N03_Y_SN11_00.csv");
PN6_data = readmatrix("PressureLog_20260715_151356_Ch1_JUL15V2_VARIAC85_P_SN10_N06_Y_SN11_00.csv");

dP_P0 = mean(P0_data(:,3));
dP_P3 = mean(P3_data(:,3));
dP_P6 = mean(P6_data(:,3));
dP_PN3 = mean(PN3_data(:,3));
dP_PN6 = mean(PN6_data(:,3));

alpha_P = [0, 3, 6, -3, -6];
deltaP_P= [dP_P0, dP_P3, dP_P6, dP_PN3, dP_PN6];

% Yaw 30 deg and pitch variac

P0_Y30 = readmatrix("PressureLog_20260715_152633_Ch1_JUL15V2_VARIAC85_P_SN10_00_Y_SN11_30.csv");
P3_Y30 = readmatrix("PressureLog_20260715_153934_Ch1_JUL15V2_VARIAC85_P_SN10_P03_Y_SN11_30.csv");
P6_Y30 = readmatrix("PressureLog_20260715_155126_Ch1_JUL15V2_VARIAC85_P_SN10_P06_Y_SN11_30.csv");
PN3_Y30 = readmatrix("PressureLog_20260715_160345_Ch1_JUL15V2_VARIAC85_P_SN10_N03_Y_SN11_30.csv");
PN6_Y30 = readmatrix("PressureLog_20260715_161311_Ch1_JUL15V2_VARIAC85_P_SN10_N06_Y_SN11_30.csv");

dP_P0_Y30 = mean(P0_Y30(:,3));
dP_P3_Y30 = mean(P3_Y30(:,3));
dP_P6_Y30 = mean(P6_Y30(:,3));
dP_PN3_Y30 = mean(PN3_Y30(:,3));
dP_PN6_Y30 = mean(PN6_Y30(:,3));

alpha_P_YAW30 = [0, 3, 6, -3, -6];
deltaP_P_YAW30 = [dP_P0_Y30, dP_P3_Y30, dP_P6_Y30, dP_PN3_Y30, dP_PN6_Y30];

% 
p_alpha = polyfit(alpha_P, deltaP_P, 1);
alpha_fit = linspace(min(alpha_P), max(alpha_P), 100);
dP_P_fit = polyval(p_alpha, alpha_fit);

% Linear fit for DeltaP45 vs Alpha - 50 pc velocity
p_alpha_YAW30 = polyfit(alpha_P_YAW30, deltaP_P_YAW30, 1);
alpha_fit_YAW30 = linspace(min(alpha_P_YAW30), max(alpha_P_YAW30), 100);
dP_P_fit_YAW30 = polyval(p_alpha_YAW30, alpha_fit_YAW30);

velcalc = readmatrix("PressureLog_20260716_172901_Ch2_SPEED85.csv");
pdynamic = mean(velcalc(:,3));
velocity = (pdynamic*2/1.225)^(1/2);
disp(velocity)
non_dimensionalize_by_dynamic_pressure = 0.5*1.2*velocity^2;

nd_Alpha_Pressure = (deltaP_P./non_dimensionalize_by_dynamic_pressure);
nd_Alpha_Pressure_YAW30 = (deltaP_P_YAW30./non_dimensionalize_by_dynamic_pressure);
% 
% dimensional
% nd_Alpha_Pressure = (deltaP_P);
% nd_Alpha_Pressure_YAW30 = (deltaP_P_YAW30);

nd_p_alpha = polyfit(alpha_P, nd_Alpha_Pressure, 1);
nd_alpha_fit = linspace(min(alpha_P), max(alpha_P), 100);
nd_alphapressure_fit = polyval(nd_p_alpha, nd_alpha_fit);

nd_p_alpha_YAW30 = polyfit(alpha_P_YAW30, nd_Alpha_Pressure_YAW30, 1);
nd_alpha_fit_YAW30 = linspace(min(alpha_P_YAW30), max(alpha_P_YAW30), 100);
nd_alphapressure_fit_YAW30 = polyval(nd_p_alpha_YAW30, nd_alpha_fit_YAW30);

%% black to Plot 
% Indigo
scatter(alpha_P, nd_Alpha_Pressure, 40, 'filled', ...
    'MarkerFaceColor', [0.29, 0.00, 0.51])
plot(nd_alpha_fit, nd_alphapressure_fit, ...
    'LineWidth', 2, 'Color', [0.29, 0.00, 0.51])


scatter(alpha_P_YAW30, nd_Alpha_Pressure_YAW30, 40, 'filled', ...
    'MarkerFaceColor', [0, 0.545, 0.545])
plot(nd_alpha_fit_YAW30, nd_alphapressure_fit_YAW30, ...
    'LineWidth', 2, 'Color', [0, 0.545, 0.545])

slope = nd_p_alpha(1);
intercept = nd_p_alpha(2);
eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);

slope2 = nd_p_alpha_YAW30(1);
intercept2 = nd_p_alpha_YAW30(2);
eqnString2 = sprintf('y = %.2fx + %.2f', slope2, intercept2);

xl = xlim;
yl = ylim;
text(xl(1)+0.25*diff(xl), yl(2)-0.3*diff(yl),eqnString, 'FontSize',12, 'FontWeight','bold');
text(xl(1)+0.25*diff(xl), yl(2)-0.35*diff(yl),eqnString2, 'FontSize',12, 'FontWeight','bold');

xlabel('\alpha (deg)')
ylabel('$\frac{\Delta P}{\frac{1}{2} \rho v^2}$', Interpreter='latex', rotation=0, FontSize=16)
%ylabel('${\Delta P} (Pa)$', Interpreter='latex', rotation=0, FontSize=16)
% title('Pitch Direction (\alpha) vs \Delta P')

legend('Aeroprobe Calibration Data', 'Aeroprobe Calibration Linear Fit', 'Aeroprobe Data Y=0-30', 'Aeroprobe Data Y=0-30 Linear Fit','Experimental Data Y=0, V=30%', ...
    'Experimental Data Y=0, V=30% Linear Fit', 'Experimental Data Y=30, V=30%', 'Experimental Data Linear Fit Y=30, V=30%','Experimental Data Y=0, V=75%', ...
    'Experimental Data Y=0, V=75% Linear Fit', 'Experimental Data Y=30, V=75%', 'Experimental Data Linear Fit Y=30, V=75%', 'Experimental Data Y=0, V=85%', ...
    'Experimental Data Y=0, V=85% Linear Fit', 'Experimental Data Y=30, V=85%', 'Experimental Data Linear Fit Y=30, V=85%','Location', 'northwest')
hold off


