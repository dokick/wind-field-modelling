load("2025031112_hours_u.mat");
load("2025031112_hours_v.mat");
load("2025031112_hours_w.mat");

lat_germany = 47:0.02:54.98;  % 400
lon_germany = 5:0.02:14.98;  % 500

[lat_germany, lon_germany] = meshgrid(lat_germany, lon_germany);

height = 13;

u_w = hours_u{1, 1};
v_w = hours_v{1, 1};
w_w = hours_w{1, 1};

mag_wind = transpose( ...
    sqrt(u_w(:, :, height).^2 + v_w(:, :, height).^2 + w_w(:, :, height).^2) ...
);

contour(lon_germany, lat_germany, mag_wind);