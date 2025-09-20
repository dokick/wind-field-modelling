close all;

hold on;

plot(lon(:, 2), lat(:, 2), "DisplayName", "Flight path");

for i = 1:trapezoidal_gust_capacity
    scatter(trapezoidal_gust_params{2, i}, trapezoidal_gust_params{1, i}, "DisplayName", "Trapez "+i);
end

for i = 1:sinusoidal_gust_capacity
    scatter(sinusoidal_gust_params{2, i}, sinusoidal_gust_params{1, i}, "DisplayName", "Sinus "+i);
end

for i = 1:les_gust_capacity
    scatter(les_gust_params{2, i}, les_gust_params{1, i}, "DisplayName", "LES "+i);
end

for i = 1:cosine_gust_capacity
    scatter(cosine_gust_params{2, i}, cosine_gust_params{1, i}, "DisplayName", "Cosine "+i);
end

[north, south, east, west] = calculate_boundaries(EVENT_HORIZON, lat(1, 2), lon(1, 2), 1000);

event_horizon_x = [east, west, west, east, east];
event_horizon_y = [north, north, south, south, north];

plot(event_horizon_x, event_horizon_y, "DisplayName", "Event horizon");

hold off;