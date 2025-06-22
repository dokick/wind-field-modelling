clear;
close all;

lat = linspace(0.5, 1.1, 10000);  % rad

lat_0 = 45;  % deg

amplitude = 10;  % m/s

gust_width = 3333000;  % m

north_lla = ned2lla([gust_width/2, 0, 0], [lat_0, 0, 100], "flat");
north = deg2rad(north_lla(1));  % rad
south_lla = ned2lla([-gust_width/2, 0, 0], [lat_0, 0, 100], "flat");
south = deg2rad(south_lla(1));  % rad

[lat_cross_north_100, lat_cross_south_100, w_g_north_100, w_g_south_100 ...
    ] = calc_wind(lat, deg2rad(lat_0), north, south, amplitude, amplitude);
[lat_cross_north_200, lat_cross_south_200, w_g_north_200, w_g_south_200 ...
    ] = calc_wind(lat, deg2rad(lat_0), north, south, 2*amplitude, amplitude);
[lat_cross_north_300, lat_cross_south_300, w_g_north_300, w_g_south_300 ...
    ] = calc_wind(lat, deg2rad(lat_0), north, south, 3*amplitude, amplitude);

hold on;
plot(lat, w_g_north_100, "-", "Color", "r");
plot(lat, w_g_south_100, "-", "Color", "r");
plot([deg2rad(lat_0), deg2rad(lat_0)], [0, amplitude]);

plot([0.5, 1.1], [0, 0]);
plot([0.5, 1.1], [amplitude, amplitude]);
ylim([-10, 20]);

plot(lat, w_g_north_200, "--", "Color", "b");
plot(lat, w_g_south_200, "--", "Color", "b");

plot(lat, w_g_north_300, "-.", "Color", "g");
plot(lat, w_g_south_300, "-.", "Color", "g");

hold off;

function [x_cross_upper, x_cross_lower, w_g_upper, w_g_lower ...
    ] = calc_wind(x, x_0, x_upper, x_lower, grad, amplitude)
    w_g_upper = grad * (x - x_upper) / (x_0 - x_upper);
    w_g_lower = grad * (x - x_lower) / (x_0 - x_lower);
    x_cross_upper = amplitude / grad * (x_0 - x_upper) + x_upper;
    x_cross_lower = amplitude / grad * (x_0 - x_lower) + x_lower;
end