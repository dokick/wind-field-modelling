close all;

is_logs_from_henrik = true;

if is_logs_from_henrik
    lat(:, 1) = logsout.getElement("<r4Lat_co_deg>").Values.Time;
    lat(:, 2) = deg2rad(logsout.getElement("<r4Lat_co_deg>").Values.Data);
    lon(:, 1) = logsout.getElement("<r4Lon_co_deg>").Values.Time;
    lon(:, 2) = deg2rad(logsout.getElement("<r4Lon_co_deg>").Values.Data);
end

hold on;

plot(lon(:, 2), lat(:, 2), "k", "DisplayName", "Flight path");
% plot(lon.Data, lat.Data, "DisplayName", "Flight path");

for i = 1:trapezoidal_gust_capacity
    scatter(trapezoidal_gust_params{2, i}, trapezoidal_gust_params{1, i}, "square", "k", "DisplayName", "Trapez "+i);
end

for i = 1:sinusoidal_gust_capacity
    scatter(sinusoidal_gust_params{2, i}, sinusoidal_gust_params{1, i}, "o", "k", "DisplayName", "Sinus "+i);
end

for i = 1:les_gust_capacity
    scatter(les_gust_params{2, i}, les_gust_params{1, i}, "^", "k", "DisplayName", "LES "+i);
end

for i = 1:cosine_gust_capacity
    scatter(cosine_gust_params{2, i}, cosine_gust_params{1, i}, "x", "k", "DisplayName", "Cosine "+i);
end

[north, south, east, west] = calculate_boundaries(EVENT_HORIZON, lat(1, 2), lon(1, 2), 1000);

event_horizon_x = [east, west, west, east, east];
event_horizon_y = [north, north, south, south, north];

plot(event_horizon_x, event_horizon_y, "--k", "DisplayName", "Event horizon");

h = zeros(6, 1);
h(1) = plot(NaN, NaN, "squarek");
h(2) = plot(NaN, NaN, "ok");
h(3) = plot(NaN, NaN, "^k");
h(4) = plot(NaN, NaN, "xk");
h(5) = plot(NaN, NaN, "-k");
h(6) = plot(NaN, NaN, "--k");
legend(h, "Trapezförmige Böen", "Sinusförmige Böen", "LES-Böen", "'1-cos'-Böen", "Flugpfad", ...
    "Eventhorizont (erster Zeitschritt)");

xlabel("Längengrad (LON) [rad]", "FontSize", 15);
ylabel("Breitengrad (LAT) [rad]", "FontSize", 15);
title("Testflug einer nicht-linearen Simulation (600s)", "FontSize", 15);

hold off;