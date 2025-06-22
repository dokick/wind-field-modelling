wind_index = 3;
nearby_index = 4;

close all;

w_g = out.logsout.getElement("model_trapezoidal_gust_w").Values.Data;
w_g = w_g(1:end-1);  % From 0s to 80s leads to 10001 elements, not compatible with reshape()
w_g = reshape(w_g, size(lat_mesh));

nearby = out.logsout.getElement("model_trapezoidal_gust_nearby").Values.Data;
nearby = nearby(1:end-1);  % From 0s to 80s leads to 10001 elements, not compatible with reshape()
nearby = reshape(nearby, size(lat_mesh));

surf(lat_mesh, lon_mesh, w_g);
figure;
surf(lat_mesh, lon_mesh, double(nearby));

figure;
plot(out.logsout.getElement("model_trapezoidal_gust_nearby").Values);