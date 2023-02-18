% Lat-Lon box of germany
% LON: 5°E - 15°E (500 elements)
% LAT: 47°N - 55°N (400 elements)

% 5°E = Col 448
% 14.98°E = Col 947
% 47°N = Row 192
% 54.98°N = Row 591

% Input
path_to_data = "D:\Dogukan\VM Shared Files\Ubuntu 18.04.6\sf_icon-d2\2023020912";
timestamp = "2023020912";

% Constants
number_of_longitude_elements = 500;
number_of_latitude_elements = 400;
number_of_heights = 29;
number_of_hours = 48;

hours_u = {number_of_hours};
hours_v = {number_of_hours};
hours_w = {number_of_hours};
for hour = 0:number_of_hours
    hours_u(hour) = get_freezed_wind_field(timestamp, hour, "u");
    hours_v(hour) = get_freezed_wind_field(timestamp, hour, "v");
    hours_w(hour) = get_freezed_wind_field(timestamp, hour, "w");
end

function wind_field = get_freezed_wind_field(date, hour, field)
    wind_field = zeros(number_of_longitude_elements, number_of_latitude_elements, number_of_heights, "single");

    for idx = 1:number_of_heights
        filename = sprintf("\%s\icon-d2_germany_regular-lat-lon_model-level_%s_0%02d_%d_%s.csv", field, date, hour, idx, field);
        mat = readtable(path_to_data + filename, "ReadRowNames", true, "ReadVariableNames", true);
        wind_field(:, :, idx) = mat(448:947, 192:591);
    end
end