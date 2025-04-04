% LAT-LON box of germany

% LAT: 47°N - 55°N (400 elements)
% 47°N = Row 192
% 54.98°N = Row 591

% LON: 5°E - 15°E (500 elements)
% 5°E = Col 448
% 14.98°E = Col 947

% Input/Config
path_to_data = "D:\\Dogukan\\VM Shared Files\\Ubuntu 18.04.6\\sf_icon-d2\\2023050218";
timestamp = "2023050218";
number_of_hours = 2;
start_hour = 3;
height_levels = 65:-1:38;

% Constants
number_of_lat_elements = 400;
number_of_lon_elements = 500;

hours_u = {number_of_hours};
hours_v = {number_of_hours};
hours_w = {number_of_hours};
hour_index = 1;
for hour = start_hour:(start_hour + number_of_hours - 1)
    hours_u{hour_index} = get_freezed_wind_field(path_to_data, number_of_lat_elements, number_of_lon_elements, height_levels, timestamp, hour, "v");
    hours_v{hour_index} = get_freezed_wind_field(path_to_data, number_of_lat_elements, number_of_lon_elements, height_levels, timestamp, hour, "u");
    hours_w{hour_index} = -get_freezed_wind_field(path_to_data, number_of_lat_elements, number_of_lon_elements, height_levels, timestamp, hour, "w");
    hour_index = hour_index + 1;
end

function wind_field = get_freezed_wind_field(path_to_data, number_of_latitude_elements, number_of_longitude_elements, height_levels, date, hour, field)
    wind_field = zeros(number_of_latitude_elements, number_of_longitude_elements, length(height_levels), "single");

    idx = 1;
    for height = height_levels
        filename = sprintf("\\%s\\icon-d2_germany_regular-lat-lon_model-level_%s_0%02d_%d_%s.csv", field, date, hour, height, field);
        mat = readtable(path_to_data + filename, "ReadRowNames", true, "ReadVariableNames", true);
        wind_field(:, :, idx) = table2array(mat(192:591, 448:947));
        idx = idx + 1;
    end
end
