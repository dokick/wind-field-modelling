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
xlim([130, 170]);
ylim([-0.5, 1.1]);

figure(3);
plot(w_lat.Values);

figure(4);
plot(w_lon.Values);

figure(5);

interval_start = find(nearby.Values.Data, 1, "first");
interval_end = find(nearby.Values.Data, 1, "last");
number_of_elements = interval_end - interval_start + 1;

lat_relevant = lat(interval_start:interval_end, 2);
lon_relevant = lon(interval_start:interval_end, 2);
[lat_mesh, lon_mesh] = meshgrid(lat_relevant, lon_relevant);

w_lat_relevant = w_lat.Values.Data(interval_start:interval_end);
w_lon_relevant = w_lon.Values.Data(interval_start:interval_end);

w_lat_relevant_mat = transpose(repmat(w_lat_relevant, 1, number_of_elements));
w_lon_relevant_mat = repmat(w_lon_relevant, 1, number_of_elements);

w_result = min(w_lat_relevant_mat, w_lon_relevant_mat);

s = surf(rad2deg(lat_mesh), rad2deg(lon_mesh), w_result);
shading interp
colorbar
