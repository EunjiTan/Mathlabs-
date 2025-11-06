clear; clc; close all;

disp('====================================================================');
disp('   INTEGRATED PARK & PARKING MANAGEMENT SYSTEM');
disp('====================================================================');
disp(' ');

% Data Matrix: Park Facility Information (5x7)
% Columns: [ParkID, Playground_Cap, Sports_Cap, Pavilion_Cap, Trails_Cap, 
%           Parking_Cap, Hourly_Rate]
parkData = [
    1, 50, 30, 100, 80,  150, 2.5;   % Central Park
    2, 40, 25, 80,  60,  120, 2.0;   % Riverside Park
    3, 60, 35, 120, 100, 180, 3.0;   % Uptown Park
    4, 45, 28, 90,  70,  140, 2.5;   % Downtown Park
    5, 55, 32, 110, 85,  160, 2.5    % Community Park
];

% Data Matrix: Daily Operations Data (5x6)
% Columns: [Avg_Facility_Usage, Parking_Occupancy, Daily_Revenue, 
%           Violations, Maintenance_Cost, Efficiency_Score]
dailyOperations = zeros(5, 6);

% Vector: Park Names for reference
parkNames = {'Central Park', 'Riverside Park', 'Uptown Park', ...
             'Downtown Park', 'Community Park'};

% Vector: Maintenance threshold per park
maintenanceBudget = [18; 15; 22; 17; 19];

% Vector: Dynamic pricing multipliers for peak/off-peak hours
pricingMultipliers = [0.8, 1.0, 1.5]; 

% Matrix: Historical Usage Pattern (30x5)
% Simulating last 30 days of average daily visitors
historicalUsage = round(100 + 50*rand(30, 5));

disp('System initialized with park data and historical records.');
disp(' ');

disp('Simulating today''s operations...');
disp(' ');

% Simulate facility usage 
for park = 1:5
    facilityCapacities = parkData(park, 2:5);
    avgCapacity = mean(facilityCapacities);
    
    % Park usage 
    usageRate = 0.6 + 0.3*rand();
    dailyOperations(park, 1) = round(avgCapacity * usageRate);
    
    % Parking occupancy with facility usage
    parkingCapacity = parkData(park, 6);
    parkingRate = 0.5 + 0.4*(usageRate/0.9); 
    dailyOperations(park, 2) = round(parkingCapacity * parkingRate);
    
    % daily revenue 
    avgDuration = 3 + 2*rand(); 
    hourlyRate = parkData(park, 7);
    dailyOperations(park, 3) = dailyOperations(park, 2) * hourlyRate * avgDuration;
    
    % Generate violations 
    violationRate = 0.02 + 0.04*rand();
    dailyOperations(park, 4) = round(dailyOperations(park, 2) * violationRate);
    
    % Maintenance costs 
    baseCost = 50;
    usageCost = 0.8 * dailyOperations(park, 1);
    dailyOperations(park, 5) = baseCost + usageCost + 10*randn();
    
    % Efficiency score 
    dailyOperations(park, 6) = dailyOperations(park, 3) / dailyOperations(park, 5);
end

disp('Current day operations simulated successfully.');
disp(' ');


disp('====================================================================');
disp('   INTERACTIVE QUERY SYSTEM');
disp('====================================================================');
disp(' ');
disp('Available Parks:');
for i = 1:5
    fprintf('%d. %s\n', i, parkNames{i});
end
disp(' ');

% Get user input for park selection
parkChoice = input('Enter Park ID (1-5) to view detailed information: ');

% Validate user input
while parkChoice < 1 || parkChoice > 5 || isempty(parkChoice)
    disp('Invalid input! Please enter a number between 1 and 5.');
    parkChoice = input('Enter Park ID (1-5) to view detailed information: ');
end

disp(' ');
disp('--------------------------------------------------------------------');

% Access specific elements from the matrix
selectedParkName = parkNames{parkChoice};
playgroundCapacity = parkData(parkChoice, 2);
currentRevenue = dailyOperations(parkChoice, 3);

% Display data accessed through indexing
fprintf('SELECTED PARK: %s (ID: %d)\n', selectedParkName, parkChoice);
fprintf('Playground Capacity: %d people\n', playgroundCapacity);
fprintf('Current Daily Revenue: P%.2f\n', currentRevenue);
disp(' ');

% maintenance event 
disp('>> Simulating maintenance event...');
maintenanceIncrease = 150 + 50*rand();
fprintf('Additional maintenance cost: P%.2f\n', maintenanceIncrease);

% Modify the maintenance cost element in the matrix
dailyOperations(parkChoice, 5) = dailyOperations(parkChoice, 5) + maintenanceIncrease;

% Update efficiency score after modification
dailyOperations(parkChoice, 6) = dailyOperations(parkChoice, 3) / ...
                                 dailyOperations(parkChoice, 5);

fprintf('Updated maintenance cost: P%.2f\n', dailyOperations(parkChoice, 5));
fprintf('Updated efficiency score: %.3f\n', dailyOperations(parkChoice, 6));
disp(' ');

disp('====================================================================');
disp('   SYSTEM STATISTICAL ANALYSIS');
disp('====================================================================');
disp(' ');

% Total system metrics
totalRevenue = sum(dailyOperations(:, 3));
totalViolations = sum(dailyOperations(:, 4));
totalMaintenanceCost = sum(dailyOperations(:, 5));

disp('>> TOTAL SYSTEM METRICS:');
fprintf('   Total Daily Revenue: P%.2f\n', totalRevenue);
fprintf('   Total Violations: %d\n', totalViolations);
fprintf('   Total Maintenance Cost: P%.2f\n', totalMaintenanceCost);
disp(' ');

%Average performance
avgFacilityUsage = mean(dailyOperations(:, 1));
avgParkingOccupancy = mean(dailyOperations(:, 2));
avgEfficiency = mean(dailyOperations(:, 6));

disp('>> AVERAGE PERFORMANCE INDICATORS:');
fprintf('   Average Facility Usage: %.2f people\n', avgFacilityUsage);
fprintf('   Average Parking Occupancy: %.2f spaces\n', avgParkingOccupancy);
fprintf('   Average Efficiency Score: %.3f\n', avgEfficiency);
disp(' ');

% Best performing park
[maxRevenue, bestParkIdx] = max(dailyOperations(:, 3));
disp('>> BEST PERFORMING PARKS:');
fprintf('   Park: %s\n', parkNames{bestParkIdx});
fprintf('   Revenue: P%.2f\n', maxRevenue);
disp(' ');

% Park needing attention
[minEfficiency, worstParkIdx] = min(dailyOperations(:, 6));
disp('>> PARK REQUIRING ATTENTION:');
fprintf('   Park: %s\n', parkNames{worstParkIdx});
fprintf('   Efficiency Score: %.3f (Lowest)\n', minEfficiency);
disp(' ');

% Data structure size
totalDataPoints = numel(dailyOperations);
fprintf('>> DATABASE SIZE: %d operational data points tracked\n', totalDataPoints);
disp(' ');


disp('====================================================================');
disp('   INTELLIGENTS & ALERTS');
disp('====================================================================');
disp(' ');

% Logical Indexing 1: High violation zones
violationThreshold = 5;
highViolationParks = dailyOperations(:, 4) > violationThreshold;

disp('>> HIGH VIOLATION ZONES (>5 violations):');
if any(highViolationParks)
    highViolationIndices = find(highViolationParks);
    for i = 1:length(highViolationIndices)
        idx = highViolationIndices(i);
        fprintf('   ALERT: %s - %d violations\n', parkNames{idx}, ...
                dailyOperations(idx, 4));
    end
else
    disp('   No parks with excessive violations.');
end
disp(' ');

%High efficiency parks 
highEfficiencyParks = dailyOperations(:, 6) > avgEfficiency;

disp('>> HIGH EFFICIENCY PARKS (above average):');
if any(highEfficiencyParks)
    highEffIndices = find(highEfficiencyParks);
    for i = 1:length(highEffIndices)
        idx = highEffIndices(i);
        fprintf('   STAR: %s - Efficiency Score: %.3f\n', parkNames{idx}, ...
                dailyOperations(idx, 6));
    end
else
    disp('   No parks above average efficiency.');
end
disp(' ');

% Parks over maintenance budget 
projectedAnnualMaint = dailyOperations(:, 5) * 365 / 1000; 
overBudgetParks = projectedAnnualMaint > maintenanceBudget;

disp('>> BUDGET ALERT - Parks exceeding annual maintenance budget:');
if any(overBudgetParks)
    overBudgetIndices = find(overBudgetParks);
    for i = 1:length(overBudgetIndices)
        idx = overBudgetIndices(i);
        fprintf('   WARNING: %s\n', parkNames{idx});
        fprintf('      Budget: P%.2fK | Projected: P%.2fK | Overage: P%.2fK\n', ...
                maintenanceBudget(idx), projectedAnnualMaint(idx), ...
                projectedAnnualMaint(idx) - maintenanceBudget(idx));
    end
else
    disp('   All parks within budget.');
end
disp(' ');


disp('====================================================================');
disp('   DYNAMIC PRICING OPTIMIZATION');
disp('====================================================================');
disp(' ');

% optimal pricing based on demand
for park = 1:5
    parkingCap = parkData(park, 6);
    currentOccupancy = dailyOperations(park, 2);
    occupancyRate = currentOccupancy / parkingCap;
    
    baseRate = parkData(park, 7);
    
    if occupancyRate > 0.80
        recommendedRate = baseRate * pricingMultipliers(3); 
        priceCategory = 'PEAK';
    elseif occupancyRate < 0.60
        recommendedRate = baseRate * pricingMultipliers(1); 
        priceCategory = 'OFF-PEAK';
    else
        recommendedRate = baseRate * pricingMultipliers(2); 
        priceCategory = 'NORMAL';
    end
    
    fprintf('%s:\n', parkNames{park});
    fprintf('   Occupancy: %.1f%% | Current Rate: P%.2f/hr\n', ...
            occupancyRate*100, baseRate);
    fprintf('   Recommended: P%.2f/hr (%s pricing)\n', recommendedRate, priceCategory);
    
    % Calculate projected revenue increase
    if occupancyRate > 0.80
        % Peak pricing may reduce demand slightly but increase revenue
        projectedIncrease = 0.85 * recommendedRate / baseRate;
    else
        % Off-peak pricing attracts more customers
        projectedIncrease = 1.15 * recommendedRate / baseRate;
    end
    
    fprintf('   Revenue Impact: %.1f%% change\n', (projectedIncrease-1)*100);
    disp(' ');
end

disp('====================================================================');
disp('   PREDICTIVE MAINTENANCE SCHEDULING');
disp('====================================================================');
disp(' ');

% Analyze historical usage trends to predict maintenance needs
disp('>> 30-Day Usage Trend Analysis:');
for park = 1:5
    % Calculate trend from historical data
    parkHistory = historicalUsage(:, park);
    
    % Linear regression to find trend
    days = (1:30)';
    trendCoeff = polyfit(days, parkHistory, 1);
    trendSlope = trendCoeff(1);
    
    % Predict next 7 days
    futureDays = (31:37)';
    predictedUsage = polyval(trendCoeff, futureDays);
    avgPredicted = mean(predictedUsage);
    
    % Maintenance priority based on usage and current cost
    maintenancePriority = (trendSlope * 10) + (dailyOperations(park, 5) / 100);
    
    fprintf('%s:\n', parkNames{park});
    fprintf('   Usage Trend: %.2f visitors/day change\n', trendSlope);
    fprintf('   Predicted Avg (Next 7 days): %.0f visitors\n', avgPredicted);
    fprintf('   Maintenance Priority Score: %.2f\n', maintenancePriority);
    
    if maintenancePriority > 3
        fprintf('   RECOMMENDATION: Schedule maintenance within 3 days\n');
    elseif maintenancePriority > 2
        fprintf('   RECOMMENDATION: Schedule maintenance within 7 days\n');
    else
        fprintf('   RECOMMENDATION: Routine maintenance schedule OK\n');
    end
    disp(' ');
end

disp('====================================================================');
disp('   REVENUE OPTIMIZATION STRATEGIES');
disp('====================================================================');
disp(' ');

% Create optimization matrix
optimizationMatrix = zeros(5, 4);

for park = 1:5
    currentRev = dailyOperations(park, 3);
    parkingCap = parkData(park, 6);
    hourlyRate = parkData(park, 7);
    currentOccupancy = dailyOperations(park, 2);
    
    % Calculate potential revenue 
    potentialOccupancy = parkingCap * 0.85;
    optimalRate = hourlyRate * 1.2; 
    avgDuration = 4; 
    potentialRev = potentialOccupancy * optimalRate * avgDuration;
    
    optimizationMatrix(park, 1) = park;
    optimizationMatrix(park, 2) = currentRev;
    optimizationMatrix(park, 3) = potentialRev;
    optimizationMatrix(park, 4) = potentialRev - currentRev;
end

% Display optimization opportunities
disp('>> REVENUE GAP ANALYSIS:');
fprintf('%-20s %12s %15s %15s\n', 'Park', 'Current(P)', 'Potential(P)', 'Gap(P)');
disp(repmat('-', 1, 70));
for park = 1:5
    fprintf('%-20s %12.2f %15.2f %15.2f\n', parkNames{park}, ...
            optimizationMatrix(park, 2), optimizationMatrix(park, 3), ...
            optimizationMatrix(park, 4));
end

totalCurrentRev = sum(optimizationMatrix(:, 2));
totalPotentialRev = sum(optimizationMatrix(:, 3));
totalGap = sum(optimizationMatrix(:, 4));

disp(repmat('-', 1, 70));
fprintf('%-20s %12.2f %15.2f %15.2f\n', 'SYSTEM TOTAL', ...
        totalCurrentRev, totalPotentialRev, totalGap);
disp(' ');

% Find park with highest optimization potential
[maxGap, maxGapPark] = max(optimizationMatrix(:, 4));
fprintf('>> HIGHEST OPTIMIZATION OPPORTUNITY: %s\n', parkNames{maxGapPark});
fprintf('   Potential Revenue Increase: $%.2f/day ($%.2f/year)\n', ...
        maxGap, maxGap*365);
disp(' ');

disp('====================================================================');
disp('   PARKING ENFORCEMENT OPTIMIZATION');
disp('====================================================================');
disp(' ');

% Calculate optimal patrol allocation based on violations
totalPatrolHours = 40;
violationWeights = dailyOperations(:, 4) / sum(dailyOperations(:, 4));
patrolAllocation = round(violationWeights * totalPatrolHours);

disp('>> WEEKLY PATROL SCHEDULE:');
for park = 1:5
    fprintf('%s: %d hours/week (%.1f%% of total)\n', parkNames{park}, ...
            patrolAllocation(park), violationWeights(park)*100);
end
disp(' ');

% Calculate expected violation reduction
reductionRate = 0.65;
expectedViolations = dailyOperations(:, 4) * (1 - reductionRate);
violationReduction = dailyOperations(:, 4) - expectedViolations;

disp('>> PROJECTED VIOLATION REDUCTION:');
fprintf('Current Total: %d violations/day\n', totalViolations);
fprintf('Projected Total: %.0f violations/day\n', sum(expectedViolations));
fprintf('Expected Reduction: %.0f violations/day (%.1f%%)\n', ...
        sum(violationReduction), reductionRate*100);
disp(' ');


disp('====================================================================');
disp('   EXECUTIVE SUMMARY & RECOMMENDATIONS');
disp('====================================================================');
disp(' ');

disp('>> KEY FINDINGS:');
fprintf('1. System daily revenue: P%.2f\n', totalRevenue);
fprintf('2. Total violations requiring attention: %d\n', totalViolations);
fprintf('3. Average efficiency score: %.3f\n', avgEfficiency);
fprintf('4. Revenue optimization potential: P%.2f/day\n', totalGap);
disp(' ');

disp('>> TOP 3 RECOMMENDATIONS:');
fprintf('1. Implement dynamic pricing at %s (highest optimization potential)\n', ...
        parkNames{maxGapPark});
fprintf('2. Increase enforcement at %s (highest violations)\n', ...
        parkNames{find(highViolationParks, 1)});
fprintf('3. Schedule immediate maintenance at %s (lowest efficiency)\n', ...
        parkNames{worstParkIdx});
disp(' ');

disp('====================================================================');
disp('   END OF REPORT');
disp('====================================================================');