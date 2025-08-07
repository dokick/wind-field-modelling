quantity = out.logsout.getElement("model_cosine_gust_lat_0").Values;
num_split = trapezoidal_gust_capacity;

instances = cell(1, num_split);

for i = 1:num_split
    instances{1, i}(:, 1) = quantity.Time(i:num_split:end-1+i);
    instances{1, i}(:, 2) = quantity.Data(i:num_split:end-1+i);
end

close all;
hold on;
for i = 1:num_split
    plot(instances{1, i}(:, 1), instances{1, i}(:, 2));
end
hold off;
