model_trapezoidal_gust_lat_0 = out.logsout.getElement("model_trapezoidal_gust_lat_0").Values;
model_trapezoidal_gust_lon_0 = out.logsout.getElement("model_trapezoidal_gust_lon_0").Values;
model_trapezoidal_gust_amplitude = out.logsout.getElement("model_trapezoidal_gust_amplitude").Values;
model_trapezoidal_gust_gust_width = out.logsout.getElement("model_trapezoidal_gust_gust_width").Values;
model_trapezoidal_gust_gradient_north = out.logsout.getElement("model_trapezoidal_gust_gradient_north").Values;
model_trapezoidal_gust_gradient_south = out.logsout.getElement("model_trapezoidal_gust_gradient_south").Values;
model_trapezoidal_gust_gradient_east = out.logsout.getElement("model_trapezoidal_gust_gradient_east").Values;
model_trapezoidal_gust_gradient_west = out.logsout.getElement("model_trapezoidal_gust_gradient_west").Values;

trapezoidal_gust_lat_0 = cell([1, trapezoidal_gust_capacity]);
trapezoidal_gust_lon_0 = cell([1, trapezoidal_gust_capacity]);
trapezoidal_gust_amplitude = cell([1, trapezoidal_gust_capacity]);
trapezoidal_gust_gust_width = cell([1, trapezoidal_gust_capacity]);
trapezoidal_gust_gradient_north = cell([1, trapezoidal_gust_capacity]);
trapezoidal_gust_gradient_south = cell([1, trapezoidal_gust_capacity]);
trapezoidal_gust_gradient_east = cell([1, trapezoidal_gust_capacity]);
trapezoidal_gust_gradient_west = cell([1, trapezoidal_gust_capacity]);

for i = 1:trapezoidal_gust_capacity
    trapezoidal_gust_lat_0{1, i} = model_trapezoidal_gust_lat_0.Data(i:trapezoidal_gust_capacity:end);
    trapezoidal_gust_lon_0{1, i} = model_trapezoidal_gust_lon_0.Data(i:trapezoidal_gust_capacity:end);
    trapezoidal_gust_amplitude{1, i} = model_trapezoidal_gust_amplitude.Data(i:trapezoidal_gust_capacity:end);
    trapezoidal_gust_gust_width{1, i} = model_trapezoidal_gust_gust_width.Data(i:trapezoidal_gust_capacity:end);
    trapezoidal_gust_gradient_north{1, i} = model_trapezoidal_gust_gradient_north.Data(i:trapezoidal_gust_capacity:end);
    trapezoidal_gust_gradient_south{1, i} = model_trapezoidal_gust_gradient_south.Data(i:trapezoidal_gust_capacity:end);
    trapezoidal_gust_gradient_east{1, i} = model_trapezoidal_gust_gradient_east.Data(i:trapezoidal_gust_capacity:end);
    trapezoidal_gust_gradient_west{1, i} = model_trapezoidal_gust_gradient_west.Data(i:trapezoidal_gust_capacity:end);
end

%% Model Config
% load("MyConfigurationDyn.mat");
START_TIME = 0;  % s
STOP_TIME = 8000;  % s
SAMPLE_TIME = 0.008;  % s

model_cosine_gust_gust_width = out.logsout.getElement("model_cosine_gust_gust_width").Values;
model_cosine_gust_amplitude = out.logsout.getElement("model_cosine_gust_amplitude").Values;
model_cosine_gust_lat_0 = out.logsout.getElement("model_cosine_gust_lat_0").Values;
model_cosine_gust_lon_0 = out.logsout.getElement("model_cosine_gust_lon_0").Values;

cosine_gust_w_g = cell([1, cosine_gust_capacity]);
%% First pre run Cosine gust
lat_0 = [0, model_cosine_gust_lat_0.Data(1)];  % rad
lon_0 = [0, model_cosine_gust_lon_0.Data(1)];  % rad
gust_width = [0, model_cosine_gust_gust_width.Data(1)];  % m
amplitude = [0, model_cosine_gust_amplitude.Data(1)];  % m/s

%% First post run cosine gust
model_cosine_gust_w_g = out.logsout.getElement("model_cosine_gust_w_g").Values;
cosine_gust_w_g{1, 1} = model_cosine_gust_w_g.Data(1:end-1);

%% Run for all cosine gusts
for i = 1:cosine_gust_capacity
    lat_0 = [0, model_cosine_gust_lat_0.Data(i)];  % rad
    lon_0 = [0, model_cosine_gust_lon_0.Data(i)];  % rad
    gust_width = [0, model_cosine_gust_gust_width.Data(i)];  % m
    amplitude = [0, model_cosine_gust_amplitude.Data(i)];  % m/s
    out = sim("model_cosine_gust_test");
    model_cosine_gust_w_g = out.logsout.getElement("model_cosine_gust_w_g").Values;
    cosine_gust_w_g{1, i} = model_cosine_gust_w_g.Data(1:end-1);
    % cosine_gust_w_g{1, i} = cosine_gust_w_g{1, i}(1:end-1);
end

%% Plotting
% cosine_gust_w_g_mesh = reshape(cosine_gust_w_g{1, 1}, [1000, 1000]);
close all;

hold on;
for i = 1:cosine_gust_capacity
    s = surf(lat_mesh, lon_mesh, reshape(cosine_gust_w_g{1, i}, [1000, 1000]));
    s.EdgeAlpha = 0;
end
hold off;

%% Test

mdl = "model_cosine_gust_test";
mdlConfig = getActiveConfigSet(mdl);
simConfig = copy(mdlConfig);
set_param(simConfig, "StopTime", "10");
out2 = sim(mdl, simConfig);