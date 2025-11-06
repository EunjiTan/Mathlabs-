clc;
clear;
% matrix
water_level_changes = [ 2.5,  3.1,  1.0;
                      -1.2,  0.5, -0.8;
                       5.0,  6.7,  4.2;
                       0.3,  0.1, -0.2;
                      -2.0, -1.5, -1.1;
                       1.8,  2.2,  1.9;
                      -0.5,  0.0,  0.4;
                       3.3,  4.1,  2.8];
disp('Original Water Level Changes (in cm):');
disp(water_level_changes);
fprintf('\n');
% numel
total_measurements = numel(water_level_changes);
fprintf('--- Question 1: How many measurements were taken? ---\n');
fprintf('The total number of measurements is: %d\n\n', total_measurements);
% abs
magnitude_of_changes = abs(water_level_changes);
fprintf('--- Question 2: What is the magnitude of each change? ---\n');
disp('Magnitude of Water Level Changes (in cm):');
disp(magnitude_of_changes);
