clear; clc; close all;

data = readtable('Netflix_Data.csv');

disp('Dataset imported successfully!');
fprintf('Total number of entries: %d\n\n', height(data));

%% Extract and Prepare Variables
releaseYear = data.release_year;
contentType = data.type;
durationRaw = data.duration;

duration = zeros(height(data), 1);
for i = 1:height(data)
    durationStr = durationRaw{i};
    numbers = regexp(durationStr, '\d+', 'match');
    if ~isempty(numbers)
        duration(i) = str2double(numbers{1});
    end
end


rng(42); 
rating = 5 + 2.5 * rand(height(data), 1) + ...
         0.02 * (releaseYear - min(releaseYear)) + ...
         randn(height(data), 1) * 0.5;
rating = max(min(rating, 10), 1); 

% Create synthetic views based on recent content and ratings
views = 1000 + 5000 * (releaseYear - min(releaseYear)) / (max(releaseYear) - min(releaseYear)) + ...
        1000 * rating + randn(height(data), 1) * 500;
views = max(views, 100);

disp('Variables extracted successfully!');
fprintf('Year range: %d - %d\n', min(releaseYear), max(releaseYear));
fprintf('Average duration: %.1f\n', mean(duration));
fprintf('Average rating: %.2f\n\n', mean(rating));

%% 3. Create All Visualizations in One Figure
figure(1);
set(gcf, 'Position', [50, 50, 1400, 900]);
set(gcf, 'Color', 'white');

% Plot 1: Line Plot - Content Release Trend Over Time
subplot(2, 3, 1);
[yearCounts, uniqueYears] = groupcounts(releaseYear);
plot(uniqueYears, yearCounts, 'r-o', 'LineWidth', 2, 'MarkerSize', 5, 'MarkerFaceColor', 'r');
title('Content Releases Over Time', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Release Year', 'FontSize', 10);
ylabel('Number of Titles', 'FontSize', 10);
grid on;
set(gca, 'FontSize', 9);

disp('Plot 1 completed: Content release trend');

% Plot 2: Scatter Plot - Duration vs Rating
subplot(2, 3, 2);
scatter(duration, rating, 50, views, 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 0.3);
title('Duration vs Rating', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Duration (min/seasons)', 'FontSize', 10);
ylabel('Rating (out of 10)', 'FontSize', 10);
c = colorbar;
c.Label.String = 'Views';
c.Label.FontSize = 9;
colormap(gca, jet);
grid on;
set(gca, 'FontSize', 9);

disp('Plot 2 completed: Duration vs Rating scatter plot');

% Plot 3: Histogram - Distribution of Ratings
subplot(2, 3, 3);
histogram(rating, 25, 'FaceColor', [0.9 0.1 0.1], 'EdgeColor', 'black', 'LineWidth', 0.8);
title('Rating Distribution', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Rating (out of 10)', 'FontSize', 10);
ylabel('Frequency', 'FontSize', 10);
grid on;
set(gca, 'FontSize', 9);
% Add mean line
meanRating = mean(rating);
hold on;
xline(meanRating, 'b--', 'LineWidth', 2, 'Label', sprintf('Mean: %.2f', meanRating), ...
      'FontSize', 9, 'LabelOrientation', 'horizontal');
hold off;

disp('Plot 3 completed: Rating distribution histogram');

% Plot 4: 3D Scatter Plot - Year, Duration, Rating
subplot(2, 3, 4);
scatter3(releaseYear, duration, rating, 40, views, 'filled', 'MarkerEdgeAlpha', 0.5);
title('3D: Year, Duration, Rating', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Release Year', 'FontSize', 10);
ylabel('Duration', 'FontSize', 10);
zlabel('Rating', 'FontSize', 10);
c = colorbar;
c.Label.String = 'Views';
c.Label.FontSize = 9;
colormap(gca, parula);
grid on;
view(45, 25);
set(gca, 'FontSize', 9);

disp('Plot 4 completed: 3D scatter plot');

% Plot 5: Bar Chart - Average Rating by Content Type
subplot(2, 3, 5);
[G, types] = findgroups(contentType);
avgRatingByType = splitapply(@mean, rating, G);
b = bar(avgRatingByType, 'FaceColor', [0.2 0.6 0.8], 'EdgeColor', 'black', 'LineWidth', 1);
title('Avg Rating by Type', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Content Type', 'FontSize', 10);
ylabel('Avg Rating', 'FontSize', 10);
set(gca, 'XTickLabel', types, 'FontSize', 9);
grid on;
ylim([0 10]);
% Add value labels
hold on;
for i = 1:length(avgRatingByType)
    text(i, avgRatingByType(i) + 0.2, sprintf('%.2f', avgRatingByType(i)), ...
        'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold');
end
hold off;

disp('Plot 5 completed: Average rating by content type');

% Add main title for entire figure
sgtitle('Netflix Dataset - Complete Visualization Analysis', 'FontSize', 16, 'FontWeight', 'bold');

%% 8. Display Summary Statistics
fprintf('\n=== SUMMARY STATISTICS ===\n');
fprintf('Total titles: %d\n', height(data));
fprintf('Movies: %d\n', sum(strcmp(contentType, 'Movie')));
fprintf('TV Shows: %d\n', sum(strcmp(contentType, 'TV Show')));
fprintf('Year range: %d - %d\n', min(releaseYear), max(releaseYear));
fprintf('Average rating: %.2f\n', mean(rating));
fprintf('Rating std dev: %.2f\n', std(rating));

disp(' ');
disp('==============================================');
disp('All visualizations completed successfully!');
disp('==============================================');