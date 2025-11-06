clc;
clear;
% Create a 2x3 seating chart with student IDs
seating_chart = [101, 102, 103;
                104, 105, 106];
disp('Original Seating Chart:');
disp(seating_chart);
% Refer to an element: Who is in row 2, column 3?
student_in_seat = seating_chart(2, 3);
fprintf('The student in row 2, column 3 has ID: %d\n\n', student_in_seat);
% Modify an element: A new student (ID 107) takes the seat in row 1, column 2
seating_chart(1, 2) = 107;
disp('Updated Seating Chart:');
disp(seating_chart);
