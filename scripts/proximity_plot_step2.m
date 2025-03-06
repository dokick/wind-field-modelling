w_g = out.logsout{4}.Values.Data;
w_g = w_g(1:end-1, :);  % Delete last element, because of 10001
w_g = reshape(w_g, size(lat_mesh));
surf(lat_mesh, lon_mesh, w_g);