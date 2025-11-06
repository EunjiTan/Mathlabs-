clear; clc;

% Create random matrix (randi generates random integers)
A = randi([1, 10], 5, 5);

% Display original matrix
fprintf('Original Matrix A:\n');
disp(A);

%% 1. Sum of the vector (matrix)
vector_sum = sum(A, 'all');  % sum all elements in the matrix
fprintf('Sum of all elements in the matrix: %d\n\n', vector_sum);

%% 2. Product of the vector (matrix)
vector_product = prod(A, 'all');  % product of all elements
fprintf('Product of all elements in the matrix: %.0f\n\n', vector_product);

%% 3. Square of the vector (element-wise)
A_squared = A.^2;  % Element-wise squaring
fprintf('Squared Matrix (A^2 - element-wise):\n');
disp(A_squared);

% Sum of squared elements
sum_squared = sum(A_squared, 'all');
fprintf('Sum of squared elements: %d\n\n', sum_squared);

%% 4. Absolute value of the vector
A_abs = abs(A);  % Absolute value (will be same as original since values are positive)
fprintf('Absolute Value Matrix |A|:\n');
disp(A_abs);

% Sum of absolute values
sum_absolute = sum(A_abs, 'all');
fprintf('Sum of absolute values: %d\n\n', sum_absolute);

%% Summary of Results
fprintf('=== SUMMARY OF RESULTS ===\n');
fprintf('Matrix Size: 5x5 (25 elements)\n');
fprintf('Value Range: 1 to 10\n\n');
fprintf(' Sum of all elements:           %d\n', vector_sum);
fprintf(' Product of all elements:       %.0f\n', vector_product);
fprintf(' Sum of squared elements:       %d\n', sum_squared);
fprintf(' Sum of absolute values:        %d\n\n', sum_absolute);

%% Additional Statistics
fprintf('=== ADDITIONAL STATISTICS ===\n');
fprintf('Mean value:                       %.2f\n', mean(A, 'all'));
fprintf('Standard deviation:               %.2f\n', std(A, 0, 'all'));
fprintf('Minimum value:                    %d\n', min(A, [], 'all'));
fprintf('Maximum value:                    %d\n', max(A, [], 'all'));
fprintf('Matrix determinant:               %.2f\n', det(A));
fprintf('Matrix rank:                      %d\n', rank(A));
