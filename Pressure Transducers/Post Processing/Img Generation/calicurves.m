% Initialize
close all
clear all
clc
clf

% Read in calibration file
data = readmatrix('SN2.csv');

%% Plotting calibration file
only_angle_data = rmmissing(data); 

velocity = 20; %m/s

non_dimensionalize_by_dynamic_pressure = 0.5*1.2*velocity^2;

h2 = only_angle_data(:,4);
h3 = only_angle_data(:,5);
h4 = only_angle_data(:,6);
h5 = only_angle_data(:,7);

deltaP_23 = h2-h3;
PAdeltaP_23 = 133.3*deltaP_23;
deltaP_23 = PAdeltaP_23;
deltaP_45 = h4-h5;
PAdeltaP_45 = 133.3*deltaP_45;
deltaP_45 = PAdeltaP_45;

thetaradch = (only_angle_data(:,1));
phiradch = (only_angle_data(:,2));
theta = deg2rad(only_angle_data(:,1));
phi = deg2rad(only_angle_data(:,2));

% Compute alpha for all data
get_alpha = atan(tan(theta).*sin(phi));
alpha = rad2deg(get_alpha);
get_beta = asin(sin(theta).*cos(phi));
beta = rad2deg(get_beta);

nd_beta_Pressure = (deltaP_23./non_dimensionalize_by_dynamic_pressure);
nd_alpha_Pressure = (deltaP_45./non_dimensionalize_by_dynamic_pressure);

% making LOBF for the raw data
nd_p_beta = polyfit(beta, nd_beta_Pressure, 1);
nd_beta_fit = linspace(min(beta), max(beta), 100);
nd_betapressure_fit = polyval(nd_p_beta, nd_beta_fit);

nd_p_alpha = polyfit(alpha, nd_alpha_Pressure, 1);
nd_alpha_fit = linspace(min(alpha), max(alpha), 100);
nd_alphapressure_fit = polyval(nd_p_alpha, nd_alpha_fit);

%% Clamping cone angle and LOBF

mask = theta >= deg2rad(-30) & theta <= deg2rad(30);

theta_clamp = theta(mask);
phi_clamp = phi(mask);
h2_clamp = h2(mask);
h3_clamp = h3(mask);
h4_clamp = h4(mask);
h5_clamp = h5(mask);
deltaP_23_clamp = deltaP_23(mask);
deltaP_45_clamp = deltaP_45(mask);
nd_deltaP_23_clamp = deltaP_23_clamp/non_dimensionalize_by_dynamic_pressure;
nd_deltaP_45_clamp = deltaP_45_clamp/non_dimensionalize_by_dynamic_pressure;

get_beta_clamp = asin(sin(theta_clamp).*cos(phi_clamp));
beta_clamp = rad2deg(get_beta_clamp);

get_alpha_clamp =atan(tan(theta_clamp).*sin(phi_clamp));
alpha_clamp = rad2deg(get_alpha_clamp);

%lobf
nd_p_betaclamp = polyfit(beta_clamp, nd_deltaP_23_clamp, 1);
nd_betaclamp_fit = linspace(min(beta_clamp), max(beta_clamp), 100);
nd_betaclamp_pressure_fit = polyval(nd_p_betaclamp, nd_betaclamp_fit);

nd_p_alphaclamp = polyfit(alpha_clamp, nd_deltaP_45_clamp, 1);
nd_alphaclamp_fit = linspace(min(alpha_clamp), max(alpha_clamp), 100);
nd_alphaclamp_pressure_fit = polyval(nd_p_alphaclamp, nd_alphaclamp_fit);

%% 30 vel
velcalc_at30 = readmatrix("Results/PressureLog_20260716_171155_Ch2_SPEED30.csv");
pdynamic_at30 = mean(velcalc_at30(:,3));
velocity_at30 = (pdynamic_at30*2/1.225)^(1/2);
disp(velocity_at30)
non_dimensionalize_by_dynamic_pressure = 0.5*1.2*velocity_at30^2;

% yaw
YAW30_P0Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_135109_Ch2_SN10C1_PITCH_00_SN11C2_YAW_00.csv");
YAW30_P0Y15 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_151345_Ch2_SN10C1_PITCH_00_SN11C2_YAW_R15.csv");
YAW30_P0Y30 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_153750_Ch2_SN10C1_PITCH_00_SN11C2_YAW_R30.csv");
YAW30_P0YN15 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_155418_Ch2_SN10C1_PITCH_00_SN11C2_YAW_L150.csv");
YAW30_P0YN30 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_160751_Ch2_SN10C1_PITCH_00_SN11C2_YAW_L30.csv");

dP_YAW30_P0Y0 = (mean(YAW30_P0Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW30_P0Y15 = (mean(YAW30_P0Y15(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW30_P0Y30 = (mean(YAW30_P0Y30(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW30_P0YN15 = (mean(YAW30_P0YN15(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW30_P0YN30 = (mean(YAW30_P0YN30(:,3)))/non_dimensionalize_by_dynamic_pressure;

YAW30_beta = [0, -15, -30, 15, 30];
YAW30_deltaP= [dP_YAW30_P0Y0, dP_YAW30_P0Y15, dP_YAW30_P0Y30, dP_YAW30_P0YN15, dP_YAW30_P0YN30];

% pitch
PITCH30_P0Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_135109_Ch1_SN10C1_PITCH_00_SN11C2_YAW_00.csv");
PITCH30_P15Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_140531_Ch1_SN10C1_PITCH_15_SN11C2_YAW_00.csv");
PITCH30_P24Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_144346_Ch1_SN10C1_PITCH_24_SN11C2_YAW_00.csv");
PITCH30_PN15Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_144743_Ch1_SN10C1_PITCH_N15_SN11C2_YAW_00.csv");
PITCH30_PN24Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED30_20260729_150916_Ch1_SN10C1_PITCH_N24_SN11C2_YAW_00.csv");

dP_PITCH30_P0Y0 = (mean(PITCH30_P0Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH30_P15Y0 = (mean(PITCH30_P15Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH30_P24Y0  = (mean(PITCH30_P24Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH30_PN15Y0  = (mean(PITCH30_PN15Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH30_PN24Y0 = (mean(PITCH30_PN24Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;

PITCH30_alpha = [0, 15, 24, -15, -24];
PITCH30_deltaP= [dP_PITCH30_P0Y0, dP_PITCH30_P15Y0, dP_PITCH30_P24Y0, dP_PITCH30_PN15Y0 , dP_PITCH30_PN24Y0];

%% 75

velcalc_at75 = readmatrix("Results/PressureLog_20260716_172425_Ch2_SPEED75.csv");
pdynamic_at75 = mean(velcalc_at75(:,3));
velocity_at75 = (pdynamic_at75*2/1.225)^(1/2);
disp(velocity_at75)
non_dimensionalize_by_dynamic_pressure = 0.5*1.2*velocity_at75^2;

% yaw
YAW75_P0Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75_20260729_135513_Ch2_SN10C1_PITCH_00_SN11C2_YAW_00.csv");
YAW75_P0Y15 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75_20260729_151747_Ch2_SN10C1_PITCH_00_SN11C2_YAW_R15.csv");
YAW75_P0Y30 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75_20260729_153350_Ch2_SN10C1_PITCH_00_SN11C2_YAW_R30.csv");
YAW75_P0YN15 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75_20260729_155936_Ch2_SN10C1_PITCH_00_SN11C2_YAW_L15.csv");
YAW75_P0YN30 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75GOOD_20260729_161852_Ch2_SN10C1_PITCH_00_SN11C2_YAW_L30.csv");

dP_YAW75_P0Y0 = (mean(YAW75_P0Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW75_P0Y15 = (mean(YAW75_P0Y15(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW75_P0Y30 = (mean(YAW75_P0Y30(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW75_P0YN15 = (mean(YAW75_P0YN15(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW75_P0YN30 = (mean(YAW75_P0YN30(:,3)))/non_dimensionalize_by_dynamic_pressure;

YAW75_beta = [0, -15, -30, 15, 30];
YAW75_deltaP= [dP_YAW75_P0Y0, dP_YAW75_P0Y15, dP_YAW75_P0Y30, dP_YAW75_P0YN15, dP_YAW75_P0YN30];

% pitch
PITCH75_P0Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75_20260729_135513_Ch1_SN10C1_PITCH_00_SN11C2_YAW_00.csv");
PITCH75_P15Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75_20260729_140857_Ch1_SN10C1_PITCH_15_SN11C2_YAW_00.csv");
PITCH75_P24Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75_20260729_144005_Ch1_SN10C1_PITCH_24_SN11C2_YAW_00.csv");
PITCH75_PN15Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75_20260729_145951_Ch1_SN10C1_PITCH_N15_SN11C2_YAW_00.csv");
PITCH75_PN24Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED75_20260729_150256_Ch1_SN10C1_PITCH_N24_SN11C2_YAW_00.csv");

dP_PITCH75_P0Y0 = (mean(PITCH75_P0Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH75_P15Y0 = (mean(PITCH75_P15Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH75_P24Y0  = (mean(PITCH75_P24Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH75_PN15Y0  = (mean(PITCH75_PN15Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH75_PN24Y0 = (mean(PITCH75_PN24Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;

PITCH75_alpha = [0, 15, 24, -15, -24];
PITCH75_deltaP= [dP_PITCH75_P0Y0, dP_PITCH75_P15Y0, dP_PITCH75_P24Y0, dP_PITCH75_PN15Y0 , dP_PITCH75_PN24Y0];

%% 85

velcalc_at85 = readmatrix(("Results/PressureLog_20260716_172901_Ch2_SPEED85.csv"));
pdynamic_at85 = mean(velcalc_at85(:,3));
velocity_at85 = (pdynamic_at85*2/1.225)^(1/2);
disp(velocity_at85)
non_dimensionalize_by_dynamic_pressure = 0.5*1.2*velocity_at85^2;

% yaw
YAW85_P0Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85_20260729_135903_Ch2_SN10C1_PITCH_00_SN11C2_YAW_00.csv");
YAW85_P0Y15 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85_20260729_152046_Ch2_SN10C1_PITCH_00_SN11C2_YAW_R15.csv");
YAW85_P0Y30 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85_20260729_154156_Ch2_SN10C1_PITCH_00_SN11C2_YAW_R30.csv");
YAW85_P0YN15 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85_20260729_160248_Ch2_SN10C1_PITCH_00_SN11C2_YAW_L15.csv");
YAW85_P0YN30 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85GOOD_20260729_162245_Ch2_SN10C1_PITCH_00_SN11C2_YAW_L30.csv");

dP_YAW85_P0Y0 = (mean(YAW85_P0Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW85_P0Y15 = (mean(YAW85_P0Y15(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW85_P0Y30 = (mean(YAW85_P0Y30(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW85_P0YN15 = (mean(YAW85_P0YN15(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_YAW85_P0YN30 = (mean(YAW85_P0YN30(:,3)))/non_dimensionalize_by_dynamic_pressure;

YAW85_beta = [0, -15, -30, 15, 30];
YAW85_deltaP= [dP_YAW85_P0Y0, dP_YAW85_P0Y15, dP_YAW85_P0Y30, dP_YAW85_P0YN15, dP_YAW85_P0YN30];

% pitch
PITCH85_P0Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85_20260729_135903_Ch1_SN10C1_PITCH_00_SN11C2_YAW_00.csv");
PITCH85_P15Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85_20260729_141243_Ch1_SN10C1_PITCH_15_SN11C2_YAW_00.csv");
PITCH85_P24Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85_20260729_143709_Ch1_SN10C1_PITCH_24_SN11C2_YAW_00.csv");
PITCH85_PN15Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85_20260729_145208_Ch1_SN10C1_PITCH_N15_SN11C2_YAW_00.csv");
PITCH85_PN24Y0 = readmatrix("Results/A2_JULY29_PressureLog_SPEED85_20260729_150557_Ch1_SN10C1_PITCH_N24_SN11C2_YAW_00.csv");

dP_PITCH85_P0Y0 = (mean(PITCH85_P0Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH85_P15Y0 = (mean(PITCH85_P15Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH85_P24Y0  = (mean(PITCH85_P24Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH85_PN15Y0  = (mean(PITCH85_PN15Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;
dP_PITCH85_PN24Y0 = (mean(PITCH85_PN24Y0(:,3)))/non_dimensionalize_by_dynamic_pressure;

PITCH85_alpha = [0, 15, 24, -15, -24];
PITCH85_deltaP= [dP_PITCH85_P0Y0, dP_PITCH85_P15Y0, dP_PITCH85_P24Y0, dP_PITCH85_PN15Y0 , dP_PITCH85_PN24Y0];

%% beta graph

figure(1)

%initial data
scatter(beta, nd_beta_Pressure, 20)
hold on
plot(nd_beta_fit, nd_betapressure_fit, 'Color', '#000080', 'LineWidth', 2)
grid on
slope = nd_p_beta(1);
intercept = nd_p_beta(2);
eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);
xl = xlim;
yl = ylim;
text(0.8, 0.1, eqnString, 'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');

%clamp data
scatter(beta_clamp, nd_deltaP_23_clamp, 'Marker', '+')
plot(nd_betaclamp_fit, nd_betaclamp_pressure_fit, 'Color', '[1, 0.5, 0]', 'LineWidth', 2)
grid on
slope = nd_p_betaclamp(1);
intercept = nd_p_betaclamp(2);
eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);
xl = xlim;
yl = ylim;
text(0.8, -0.2, eqnString, 'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');

%YAW
scatter(YAW30_beta,YAW30_deltaP, 40, 'filled', 'MarkerFaceColor', 'g')
scatter(YAW75_beta,YAW75_deltaP, 40, 'filled', 'MarkerFaceColor', 'r')
scatter(YAW85_beta,YAW85_deltaP, 40, 'filled', 'MarkerFaceColor', 'c')


xlabel('\alpha (deg)')
ylabel('$\frac{\Delta P}{\frac{1}{2} \rho v^2}$', Interpreter='latex', rotation=0, FontSize=16)
title('Yaw Direction (\beta) vs \Delta P')
legend('Aeroprobe Calibration Data', 'Aeroprobe Calibration Data Linear Fit', ...
    'Cone Angle Clamp to +/- 30^\circ', 'Cone Angle Clamp to +/- 30^\circ Linear Fit', '30% Variac', '75% Variac',  '85% Variac', 'Location', 'southEast')

%% alpha
figure(2)

%initial data
scatter(alpha, nd_alpha_Pressure, 20)
hold on
plot(nd_alpha_fit, nd_alphapressure_fit, 'Color', '#000080', 'LineWidth', 2)
grid on
slope = nd_p_alpha(1);
intercept = nd_p_alpha(2);
eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);
xl = xlim;
yl = ylim;
text(0.1, 0.2, eqnString, 'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');

%clamp data
scatter(alpha_clamp, nd_deltaP_45_clamp, 'Marker', '+')
plot(nd_alphaclamp_fit, nd_alphaclamp_pressure_fit, 'Color', '[1, 0.5, 0]', 'LineWidth', 2)
grid on
slope = nd_p_alphaclamp(1);
intercept = nd_p_alphaclamp(2);
eqnString = sprintf('y = %.2fx + %.2f', slope, intercept);
xl = xlim;
yl = ylim;
text(0.1, 0.2, eqnString, 'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');

%YAW
scatter(PITCH30_alpha,PITCH30_deltaP, 40, 'filled', 'MarkerFaceColor', 'g')
scatter(PITCH75_alpha,PITCH75_deltaP, 40, 'filled', 'MarkerFaceColor', 'r')
scatter(PITCH85_alpha,PITCH85_deltaP, 40, 'filled', 'MarkerFaceColor', 'c')


xlabel('\alpha (deg)')
ylabel('$\frac{\Delta P}{\frac{1}{2} \rho v^2}$', Interpreter='latex', rotation=0, FontSize=16)
title('Yaw Direction (\beta) vs \Delta P')
legend('Aeroprobe Calibration Data', 'Aeroprobe Calibration Data Linear Fit', ...
    'Cone Angle Clamp to +/- 30^\circ', 'Cone Angle Clamp to +/- 30^\circ Linear Fit', '30% Variac', '75% Variac', '85% Variac', 'Location', 'northWest')


