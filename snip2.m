clc;
clear;
radius = 5;
circle_area = pi * radius^2;
fprintf('The area of a circle with radius %d is: %f\n', radius, circle_area);
complex_num_i = 3 + 4*i; % Uses i
complex_num_j = 3 + 4*j; % Uses j
fprintf('A complex number using i: %s\n', num2str(complex_num_i));
fprintf('A complex number using j: %s\n\n', num2str(complex_num_j));
fprintf(' Part 3: Functions on a Data Vector \n');
data_vector = [-9.7, -4, 0, 3.2, 8];
disp('Original data vector:');
disp(data_vector);
min_val = min(data_vector); % Uses min(t)
sqrt_of_abs_min = sqrt(abs(min_val)); % Uses sqrt(t) and abs(t)
fprintf('The square root of the absolute minimum value is: %f\n', sqrt_of_abs_min);
max_val = max(data_vector); % Uses max(t)
fprintf('The maximum value in the vector is: %f\n', max_val);
signs = sign(data_vector); % Uses sign(t)
disp('Sign of each element (-1 for neg, 0 for zero, 1 for pos):');
disp(signs);
fprintf('\n');
fprintf(' Part 4: Rounding and Remainder Functions \n');
test_num = 10.8;
divisor = 3;
