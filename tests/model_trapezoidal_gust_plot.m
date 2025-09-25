close all;

w_g = out.logsout.getElement("model_trapezoidal_gust_w").Values.Data;
w_g = w_g(1:end-1);  % From 0s to 80s leads to 10001 elements, not compatible with reshape()
w_g = reshape(w_g, size(lat_mesh));

s = surf(lat_mesh, lon_mesh, w_g);
s.EdgeAlpha = 0;
cb = colorbar;
cb.Label.String = "Windgeschwindigkeit [m/s]";
cb.Label.FontSize = 15;
xlabel("Breitengrad (LAT)", "FontSize", 15);
ylabel("Längengrad (LON)", "FontSize", 15);
xlim([0.92498, 0.92507]);
ylim([0.24426, 0.24444]);
% set(gca, 'xtick', []);
% set(gca, 'ytick', []);

figure;
contourf(lat_mesh, lon_mesh, w_g);
cb = colorbar;
cb.Label.String = "Windgeschwindigkeit [m/s]";
cb.Label.FontSize = 15;
xlabel("Breitengrad (LAT)", "FontSize", 15);
ylabel("Längengrad (LON)", "FontSize", 15);
xlim([0.92498, 0.92507]);
ylim([0.24426, 0.24444]);
% set(gca, 'xtick', []);
% set(gca, 'ytick', []);
