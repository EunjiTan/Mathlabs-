clear; clc;

% 1. USER INPUT
num = input('Enter a positive number: ');

% 2. UNIQUE MATH FUNCTION - sqrt()
square_root = sqrt(num);

% 3. CONTROL STRUCTURE - Selection (if-else)
if floor(square_root) == square_root
    % It's a perfect square
    fprintf('\n%g is a PERFECT SQUARE!\n', num);
    fprintf('The square root is: %g\n', square_root);
else
    % Not a perfect square
    fprintf('\n%g is NOT a perfect square.\n', num);
    fprintf('The square root is approximately: %.2f\n', square_root);
end
