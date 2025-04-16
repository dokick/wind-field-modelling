wind_index = 3;
nearby_index = 4;

w_g = out.logsout{wind_index}.Values.Data;
w_g = w_g(1:end-1);
w_g = reshape(w_g, size(lat_mesh));

nearby = out.logsout{nearby_index}.Values.Data;
nearby = nearby(1:end-1);
nearby = reshape(nearby, size(lat_mesh));

surf(lat_mesh, lon_mesh, w_g);
figure;
surf(lat_mesh, lon_mesh, double(nearby));

figure;
plot(out.logsout{nearby_index}.Values);