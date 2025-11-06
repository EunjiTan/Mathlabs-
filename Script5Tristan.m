clc;
clear;
% Calculate areas of circles with different radii
radius = [1, 2, 3, 4, 5]; % row vector with different radius values
pi_value = pi; % MATLAB's built-in pi constant
% Calculate area for each radius using element-wise operation
% The dot (.) before the power symbol (^) makes it element-wise
area = pi_value * radius.^2;
% Display the results
disp('Radius vector:');
disp(radius);
disp('Calculated area vector:');
disp(area);