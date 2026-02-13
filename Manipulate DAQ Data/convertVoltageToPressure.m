function P = convertVoltageToPressure(V)

% Linear scaling conversion
% Assume identical scaling for P17
    
%   V - Voltage vector
%   m - Slope (pressure per volt)
%   b - Offset (pressure at 0 V, y-intercept)

% For P17 calibration curve: 
m = 9.09;
b = -0.0002;

    P = m .* V + b;

end

