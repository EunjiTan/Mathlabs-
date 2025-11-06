% --- Attendee List Management Script ---
clc;
clear;
% Start with an empty list of attendees
attendee_list = [];
disp('Initial empty list:');
disp(attendee_list);
% Add attendees as they confirm
attendee_list = [attendee_list, 101]; % Add first attendee
attendee_list = [attendee_list, 102]; % Add second attendee
attendee_list = [attendee_list, 103]; % Add third attendee
disp('List after adding attendees:');
disp(attendee_list);
% The second person (ID 105) cancels. Let's remove them.
% The element to remove is at index 2.
attendee_list(2) = [];
disp('Final list after removing the second person:');
disp(attendee_list);
