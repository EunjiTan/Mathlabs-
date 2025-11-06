clc;
clear;
time = 0:2:10; % row vector named time from 0 to 10 in steps of 2
initial_velocity = 5; % variable for initial_velocity
acceleration = 2; % variable for acceleration
% Calculate the distance for each element in the time vector
% The dot (.) before the power symbol (^) makes it an element-wise operation.
distance = initial_velocity * time + 0.5 * acceleration * time.^2;
% Display the final distance vector
disp('Time vector:');
disp(time);
disp('Calculated distance vector:');
disp(distance);
