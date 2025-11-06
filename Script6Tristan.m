clc;
clear;
% Calculate compound interest over different years
years = [1, 2, 3, 4, 5]; % row vector for number of years
principal = 1000; % initial amount invested
interest_rate = 0.05; % 5% annual interest rate
% Calculate final amount using compound interest formula
% A = P(1 + r)^t where P=principal, r=rate, t=time
% The dot (.) before the power makes it element-wise operation
final_amount = principal * (1 + interest_rate).^years;
% Display the results
disp('Years vector:');
disp(years);
disp('Final amount vector:');
disp(final_amount);