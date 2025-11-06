clear all;
clc;
close all; 

%% INPUT DATA - REPLACE WITH YOUR OBSERVED DATA
inter_arrival_times = [2, 3, 1, 5, 2, 4, 1, 3, 2]; 


service_times = [4, 3, 2, 5, 4, 3, 3, 4, 2, 3];
analyst_name = 'Tristan Plaus'; 

%% DISPLAY INPUT DATA
disp('========================================');
disp('   QUEUING SYSTEM SIMULATION');
disp('========================================');
disp(' ');
disp('INPUT DATA:');
disp('------------------------------------------');
fprintf('Number of Customers: %d\n', length(service_times));
disp(' ');
disp('Inter-Arrival Times (minutes):');
disp(inter_arrival_times);
disp(' ');
disp('Service Times (minutes):');
disp(service_times);
disp(' ');

%% INITIALIZE SIMULATION MATRIX
% Columns: [Customer#, Arrival, Service, Begin, Wait, End, TimeInSystem]
num_customers = length(service_times);
simulation_results = zeros(num_customers, 7);

for i = 1:num_customers
    simulation_results(i, 1) = i;
end

simulation_results(1, 2) = 0;

% Subsequent customers: arrival = previous_arrival + inter_arrival_time
for i = 2:num_customers
    simulation_results(i, 2) = simulation_results(i-1, 2) + inter_arrival_times(i-1);
end

simulation_results(:, 3) = service_times';

simulation_results(1, 4) = simulation_results(1, 2);

% For subsequent customers:
% Service begins = max(arrival_time, previous_customer_end_time)
for i = 2:num_customers
 
    prev_end_time = simulation_results(i-1, 6);
  
    current_arrival = simulation_results(i, 2);
    simulation_results(i, 4) = max(current_arrival, prev_end_time);
end


simulation_results(:, 5) = simulation_results(:, 4) - simulation_results(:, 2);

simulation_results(:, 6) = simulation_results(:, 4) + simulation_results(:, 3);

simulation_results(:, 7) = simulation_results(:, 6) - simulation_results(:, 2);

%% DISPLAY SIMULATION RESULTS TABLE
disp('========================================');
disp('   SIMULATION RESULTS');
disp('========================================');
disp(' ');
disp('Customer | Arrival | Service | Begin | Wait | End | Total');
disp('   #     |  Time   |  Time   | Time  | Time | Time| Time ');
disp('---------|---------|---------|-------|------|-----|-------');

for i = 1:num_customers
    fprintf('   %2d    |  %5.1f  |  %5.1f  | %5.1f | %4.1f | %5.1f| %5.1f\n', ...
        simulation_results(i,1), simulation_results(i,2), ...
        simulation_results(i,3), simulation_results(i,4), ...
        simulation_results(i,5), simulation_results(i,6), ...
        simulation_results(i,7));
end
disp(' ');

%% CALCULATE PERFORMANCE METRICS
avg_waiting_time = mean(simulation_results(:, 5));

% 2. Probability that a customer has to wait
customers_who_waited = sum(simulation_results(:, 5) > 0);
prob_customer_waits = customers_who_waited / num_customers;

% 3. Server Utilization
total_service_time = sum(simulation_results(:, 3));
total_simulation_time = max(simulation_results(:, 6)); 
server_utilization = total_service_time / total_simulation_time;

% 4. Maximum Waiting Time
max_waiting_time = max(simulation_results(:, 5));

% 5. Average Time in System
avg_time_in_system = mean(simulation_results(:, 7));

%% DISPLAY PERFORMANCE METRICS
disp('========================================');
disp('   PERFORMANCE METRICS');
disp('========================================');
disp(' ');
fprintf('Average Waiting Time:           %.2f minutes\n', avg_waiting_time);
fprintf('Probability Customer Waits:     %.2f%% (%d out of %d)\n', ...
    prob_customer_waits*100, customers_who_waited, num_customers);
fprintf('Server Utilization:             %.2f%%\n', server_utilization*100);
fprintf('Maximum Waiting Time:           %.2f minutes\n', max_waiting_time);
fprintf('Average Time in System:         %.2f minutes\n', avg_time_in_system);
disp(' ');

%% ADDITIONAL STATISTICS
disp('========================================');
disp('   ADDITIONAL STATISTICS');
disp('========================================');
disp(' ');
fprintf('Total Customers Served:         %d\n', num_customers);
fprintf('Total Simulation Time:          %.2f minutes\n', total_simulation_time);
fprintf('Total Service Time:             %.2f minutes\n', total_service_time);
fprintf('Total Waiting Time (All):       %.2f minutes\n', sum(simulation_results(:, 5)));
fprintf('Average Service Time:           %.2f minutes\n', mean(service_times));
fprintf('Average Inter-Arrival Time:     %.2f minutes\n', mean(inter_arrival_times));
disp(' ');

%% INTERPRETATION
disp('========================================');
disp('   SYSTEM INTERPRETATION');
disp('========================================');
disp(' ');

% Interpret server utilization
if server_utilization < 0.50
    disp('Server Utilization: LOW - Server has significant idle time.');
    disp('Recommendation: Current capacity is more than sufficient.');
elseif server_utilization < 0.75
    disp('Server Utilization: MODERATE - System is operating efficiently.');
    disp('Recommendation: Current setup is balanced.');
elseif server_utilization < 0.90
    disp('Server Utilization: HIGH - System is busy but manageable.');
    disp('Recommendation: Monitor during peak hours.');
else
    disp('Server Utilization: VERY HIGH - Server is overloaded.');
    disp('Recommendation: Consider adding another server or improving service time.');
end

disp(' ');

% Interpret waiting times
if avg_waiting_time < 2
    disp('Average Wait: EXCELLENT - Customers experience minimal wait time.');
elseif avg_waiting_time < 5
    disp('Average Wait: GOOD - Wait times are acceptable.');
elseif avg_waiting_time < 10
    disp('Average Wait: FAIR - Some customers may be dissatisfied.');
else
    disp('Average Wait: POOR - Long wait times may lead to customer loss.');
end

disp(' ');
disp('========================================');
disp('   END OF SIMULATION');
disp('========================================');
disp(' ');

disp('Generating graph...');
disp(' ');

% Extract data for plotting
customer_numbers = simulation_results(:, 1);
arrival_times = simulation_results(:, 2);
service_times_data = simulation_results(:, 3);
begin_times = simulation_results(:, 4);
waiting_times = simulation_results(:, 5);
end_times = simulation_results(:, 6);
time_in_system = simulation_results(:, 7);

%% CREATE SINGLE COMPREHENSIVE FIGURE
figure('Position', [100, 100, 1400, 700], 'Color', 'white');

%% SUBPLOT 1: Customer Timeline (Gantt Chart)
subplot(2,3,1);
hold on;
for i = 1:num_customers
    % Waiting time (red/orange)
    if waiting_times(i) > 0
        rectangle('Position', [arrival_times(i), i-0.4, waiting_times(i), 0.8], ...
            'FaceColor', [1, 0.6, 0.6], 'EdgeColor', [0.8, 0, 0], 'LineWidth', 1.5);
    end
    % Service time (green)
    rectangle('Position', [begin_times(i), i-0.4, service_times_data(i), 0.8], ...
        'FaceColor', [0.6, 1, 0.6], 'EdgeColor', [0, 0.6, 0], 'LineWidth', 1.5);
end
hold off;
xlabel('Time (minutes)', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Customer Number', 'FontSize', 10, 'FontWeight', 'bold');
title('Customer Timeline', 'FontSize', 11, 'FontWeight', 'bold');
legend('Waiting', 'Service', 'Location', 'best', 'FontSize', 9);
grid on;
ylim([0, num_customers+1]);
yticks(1:num_customers);

%% SUBPLOT 3: Time in System Breakdown (Stacked)
subplot(2,3,3);
bar(customer_numbers, [waiting_times, service_times_data], 'stacked');
xlabel('Customer Number', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Time (minutes)', 'FontSize', 10, 'FontWeight', 'bold');
title('Time in System (Waiting + Service)', 'FontSize', 11, 'FontWeight', 'bold');
legend('Wait', 'Service', 'Location', 'best', 'FontSize', 9);
grid on;

%% SUBPLOT 5: Performance Metrics Bar Chart
subplot(2,3,5);
metrics_names = {'Avg Wait', 'Max Wait', 'Avg Service', 'Avg Total'};
metrics_values = [avg_waiting_time, max_waiting_time, mean(service_times_data), avg_time_in_system];
colors = [0.2 0.5 0.8; 0.8 0.3 0.3; 0.4 0.7 0.4; 0.6 0.4 0.8];

b = bar(metrics_values);
b.FaceColor = 'flat';
for i = 1:length(metrics_values)
    b.CData(i,:) = colors(i,:);
end

set(gca, 'XTickLabel', metrics_names, 'FontSize', 9);
ylabel('Time (minutes)', 'FontSize', 10, 'FontWeight', 'bold');
title('Key Performance Metrics', 'FontSize', 11, 'FontWeight', 'bold');
grid on;

% Add values on bars
hold on;
for i = 1:length(metrics_values)
    text(i, metrics_values(i), sprintf('%.2f', metrics_values(i)), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
        'FontSize', 9, 'FontWeight', 'bold');
end
hold off;

sgtitle(sprintf('ZUS Coffe near UST QUEUING SYSTEM ANALYSIS  |  Analyzed by: %s', analyst_name), ...
    'FontSize', 16, 'FontWeight', 'bold', 'Color', [0.1, 0.1, 0.5]);

disp(' Graph generated successfully!');
disp(' ');
disp('========================================');
disp('   VISUALIZATION COMPLETED');
disp('========================================');