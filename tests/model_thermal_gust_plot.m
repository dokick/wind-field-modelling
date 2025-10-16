close all;

w_g = out.logsout.getElement("model_thermal_gust_w_g").Values.Data;
w_g = w_g(1:end-1);  % From 0s to 8000s leads to 10000001 elements, not compatible with reshape()
w_g = reshape(w_g, size(lat_mesh));

s = surf(lon_mesh, lat_mesh, w_g);
s.EdgeAlpha = 0;
cb = colorbar;
cb.Label.String = "Windgeschwindigkeit [m/s]";
cb.Label.FontSize = 15;
xlabel("Längengrad (LON)", "FontSize", 15);
ylabel("Breitengrad (LAT)", "FontSize", 15);
effective_radius = gust_radius(2)*2.5;
[no, so, ea, we] = calculate_boundaries(effective_radius, lat_0(2), lon_0(2), alt_0(2));
xlim([we, ea]);
ylim([so, no]);
% set(gca, 'xtick', []);
% set(gca, 'ytick', []);

figure;
contourf(lon_mesh, lat_mesh, w_g);
cb = colorbar;
cb.Label.String = "Windgeschwindigkeit [m/s]";
cb.Label.FontSize = 15;
xlabel("Längengrad (LON)", "FontSize", 15);
ylabel("Breitengrad (LAT)", "FontSize", 15);
xlim([we, ea]);
ylim([so, no]);
% set(gca, 'xtick', []);
% set(gca, 'ytick', []);
