clc;
clear;
% Temperature conversion from Celsius to Fahrenheit
celsius = [0, 10, 20, 30, 40]; % row vector with temperatures in Celsius
conversion_factor = 9/5; % factor for Celsius to Fahrenheit conversion
offset = 32; % offset value for Fahrenheit
% Convert each temperature using element-wise operations
fahrenheit = conversion_factor * celsius + offset;
% Display the results
disp('Celsius temperatures:');
disp(celsius);
disp('Fahrenheit temperatures:');
disp(fahrenheit);