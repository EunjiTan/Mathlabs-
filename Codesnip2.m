% --- Annual Report Reshape Script ---
clc;
clear;
% 12 months of sales data in a single row vector
monthly_sales = [10, 12, 15, 18, 17, 20, 22, 21, 19, 25, 28, 30];
disp('Original Monthly Sales (1x12 Vector):');
disp(monthly_sales);
% Reshape the data into a 4x3 matrix (4 quarters, 3 months each)
quarterly_sales = reshape(monthly_sales, 4, 3);
disp('Reshaped Quarterly Sales (4x3 Matrix):');
disp(quarterly_sales);
