clc;
clear;
x = -10:10; % vector x that goes from -10 to 10
y = x.^2; % vector y where each element is the square of x
figure; % script for new, empty figure window
% Using the plot() function to create a line graph
plot(x, y, 'r-o'); % Plot y vs x with a red solid line and circle markers
% Adding title and labels
title('Graph of y = x^2');
xlabel('x-axis');
ylabel('y-axis');
grid on; % Adds a grid to the plot for easier reading