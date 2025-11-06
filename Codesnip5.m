clc;
clear;
% 3 students (rows), 4 quizzes (columns)
gradebook = [88, 92, 85, 95;  % Student 1
            76, 80, 82, 79;  % Student 2
            91, 95, 89, 93]; % Student 3
disp('Original Gradebook Matrix:');
disp(gradebook);

% Calculate the average score avg_per_quiz = mean(gradebook);
disp('Average score for each quiz:');
disp(avg_per_quiz);

% Calculate the total score for each STUDENT 
total_per_student = sum(gradebook, 2);
disp('Total score for each student:');
disp(total_per_student);
