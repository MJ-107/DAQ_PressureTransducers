function cal = convertVoltageToPressure(V, m, b)

% Linear scaling conversion
% Assume identical scaling for P17
    
%   V - Voltage vector
%   m - Slope (pressure per volt)
%   b - Offset (pressure at 0 V, y-intercept)

    arguments
        V double
        m double
        b double
    end

% For P17 linear calibration curve: 
    cal = m .* V + b;

end

