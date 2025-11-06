%Updating elements and logical indexing
clc;
clear;
studentGrades = [
   101, 85, 90, 88;  % Student 101
   102, 76, 82, 79;  % Student 102
   103, 92, 95, 94;  % Student 103
   104, 78, 88, 85   % Student 104
];
% Display the initial gradebook to the user
disp('--- Welcome to the Grade Management System ---');
disp('Current Student Gradebook:');
disp('StudentID  Quiz1  Midterm  Final');
disp(studentGrades);
disp('-----------------------------------------');
studentID_to_update = input('Please enter the Student ID to update a grade for: ');
new_grade = input('Please enter the new grade: ');
assessment_column = input('Which assessment? (2 for Quiz1, 3 for Midterm, 4 for Final): ');
% Logical Indexing: The 'find' function
studentRow = find(studentGrades(:, 1) == studentID_to_update);
% using isempty
if isempty(studentRow)
   disp('Error: Student ID not found.');
else
   % If found, update the grade in the correct row and column.
   studentGrades(studentRow, assessment_column) = new_grade;
   disp('-----------------------------------------');
   disp('Update successful!');
   disp('New Student Gradebook:');
   disp('StudentID  Quiz1  Midterm  Final');
   disp(studentGrades);
end
