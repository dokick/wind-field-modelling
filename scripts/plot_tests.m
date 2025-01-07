altitude = out.logsout{1};
latitude = out.logsout{2};
longitude = out.logsout{3};
w = out.logsout{4};
w_lat = out.logsout{5};
w_lon = out.logsout{6};
nearby = out.logsout{7};

figure(1);
plot(w.Values);
xlim([130, 170]);
ylim([-0.5, amplitude(2)+1]);

figure(2);
plot(nearby.Values);
xlim([100, 200]);
ylim([-0.5, 1.1]);

figure(3);
plot(w_lat.Values);

figure(4);
plot(w_lon.Values);

figure(5);

north_lla = ned2lla([gust_width(2)/2, 0, 0], [lat_0(2), lon_0(2), height_0(2)], "flat");
south_lla = ned2lla([-gust_width(2)/2, 0, 0], [lat_0(2), lon_0(2), height_0(2)], "flat");
east_lla = ned2lla([0, gust_width(2)/2, 0], [lat_0(2), lon_0(2), height_0(2)], "flat");
west_lla = ned2lla([0, -gust_width(2)/2, 0], [lat_0(2), lon_0(2), height_0(2)], "flat");
north = north_lla(1);
south = south_lla(1);
east = east_lla(2);
west = west_lla(2);

[lat_mesh, lon_mesh] = meshgrid(linspace(south, north), linspace(west, east));

lat_vals = min([ ...
    -gradient_north(2)*deg2rad(lat_mesh-north), ...
    gradient_south(2)*deg2rad(lat_mesh-south), ...
    amplitude]);
lon_vals = min([ ...
    -gradient_east(2)*deg2rad(lon_mesh-east), ...
    gradient_west(2)*deg2rad(lon_mesh-west), ...
    amplitude]);

surf(lat_mesh, lon_mesh, min([lat_vals, lon_vals]));
