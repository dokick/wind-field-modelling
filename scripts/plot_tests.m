altitude = out.logsout{1};
latitude = out.logsout{2};
longitude = out.logsout{3};
w = out.logsout{4};
nearby = out.logsout{5};

figure(1);
plot(w.Values);

figure(2);
ylim([0.1 1.1]);
plot(nearby.Values);
