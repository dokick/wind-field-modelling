lat = [0, 52.49];
lon = [0, 13.49];

EVENT_HORIZON = 10000;

north_lla = ned2lla([EVENT_HORIZON/2, 0, 0], [lat(2), lon(2), height_0(2)], "flat");
north = deg2rad(north_lla(1)); % rad
south_lla = ned2lla([-EVENT_HORIZON/2, 0, 0], [lat(2), lon(2), height_0(2)], "flat");
south = deg2rad(south_lla(1)); % rad
east_lla = ned2lla([0, EVENT_HORIZON/2, 0], [lat(2), lon(2), height_0(2)], "flat");
east = deg2rad(east_lla(2)); % rad
west_lla = ned2lla([0, -EVENT_HORIZON/2, 0], [lat(2), lon(2), height_0(2)], "flat");
west = deg2rad(west_lla(2)); % rad

lat_spectrum = linspace(north, south);
lon_spectrum = linspace(east, west);

[lat_mesh, lon_mesh] = meshgrid(lat_spectrum, lon_spectrum);

time_end = (numel(lat_mesh) - 1)/FREQUENCY;

lat_mesh_flat = zeros([numel(lat_mesh), 2]);
lon_mesh_flat = zeros([numel(lon_mesh), 2]);

lat_mesh_flat(:, 1) = linspace(0, time_end, numel(lat_mesh));
lon_mesh_flat(:, 1) = linspace(0, time_end, numel(lon_mesh));

lat_mesh_flat(:, 2) = reshape(lat_mesh, [1, numel(lat_mesh)]);
lon_mesh_flat(:, 2) = reshape(lon_mesh, [1, numel(lon_mesh)]);

% lat_mesh_flat(end+1, 2) = lat_mesh_flat(end, 2);
% lon_mesh_flat(end+1, 2) = lon_mesh_flat(end, 2);

lat = lat_mesh_flat;
lon = lon_mesh_flat;