load("2025032606_hours_u.mat");
load("2025032606_hours_v.mat");
load("2025032606_hours_w.mat");

lon_germany = 5:0.02:14.98;  % 500
lat_germany = 47:0.02:54.98;  % 400

[lon_germany, lat_germany] = meshgrid(lon_germany, lat_germany);

height = 12;

u_w = hours_u{1, 1};
v_w = hours_v{1, 1};
w_w = hours_w{1, 1};

mag_wind = sqrt(u_w(:, :, height).^2 + v_w(:, :, height).^2 + w_w(:, :, height).^2);

contourf(lon_germany(1:5:end, 1:5:end), lat_germany(1:5:end, 1:5:end), mag_wind(1:5:end, 1:5:end));
hcb = colorbar;
ylabel(hcb, "Betrag der Windgeschwindigkeit in m/s");
% hcb.Title.String = "Betrag der Windgeschwindigkeit in m/s";
hold on
resolution = 25;
quiver3( ...
    lon_germany(1:resolution:end, 1:resolution:end), ...
    lat_germany(1:resolution:end, 1:resolution:end), ...
    zeros(size(lon_germany(1:resolution:end, 1:resolution:end)))+15, ...
    v_w(1:resolution:end, 1:resolution:end, height), ...
    u_w(1:resolution:end, 1:resolution:end, height), ...
    w_w(1:resolution:end, 1:resolution:end, height), ...
    "w" ...
    );
xlabel("Längengrade in Grad [°]");
ylabel("Breitengrade in Grad [°]");
% figure

% Achsen testen
% quiver3 testen

% contourf(lon_germany(1:10:end, 1:10:end), lat_germany(1:10:end, 1:10:end), mag_wind(1:10:end, 1:10:end));
