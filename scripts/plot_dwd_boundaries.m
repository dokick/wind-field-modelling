close all;
hold on;

icon_d2_lat = [43.18, 58.08];
icon_d2_lon = [356.06-360, 20.34];

icon_d2_lat_ger = [47, 55];
icon_d2_lon_ger = [5, 15];

figure;
gx = geoaxes;
h = geoplot( gx, ...
    [icon_d2_lat(1), icon_d2_lat(2), icon_d2_lat(2), icon_d2_lat(1), icon_d2_lat(1)], ...
    [icon_d2_lon(1), icon_d2_lon(1), icon_d2_lon(2), icon_d2_lon(2), icon_d2_lon(1)], ...
    "-k", ...
    [icon_d2_lat_ger(1), icon_d2_lat_ger(2), icon_d2_lat_ger(2), icon_d2_lat_ger(1), icon_d2_lat_ger(1)], ...
    [icon_d2_lon_ger(1), icon_d2_lon_ger(1), icon_d2_lon_ger(2), icon_d2_lon_ger(2), icon_d2_lon_ger(1)], ...
    "--k");
h(1).LineWidth = 2;
h(2).LineWidth = 2;
geotickformat(gx, "dd");

gx.LatitudeAxis.FontSize = 13;
gx.LongitudeAxis.FontSize = 13;

gx.LatitudeAxis.TickValues = [45, 47.5, 50, 52.5, 55, 57.5];
gx.LongitudeAxis.TickValues = [-5, 0, 5, 10, 15, 20];

hold off;