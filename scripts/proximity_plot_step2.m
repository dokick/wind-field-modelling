w_g = out.logsout{4}.Values.Data;
w_g = reshape(w_g, size(lat_mesh));

nearby = out.logsout{7}.Values.Data;
nearby = reshape(nearby, size(lat_mesh));

surf(lat_mesh, lon_mesh, w_g);
figure;
surf(lat_mesh, lon_mesh, double(nearby));

figure;
plot(out.logsout{7}.Values);