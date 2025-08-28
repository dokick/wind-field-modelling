% Before running make sure simulation sample time is restored

%% Data transformation

trapezoidal_gust_log_ids = [ ...
    "model_trapezoidal_gust_lat_0", ...
    "model_trapezoidal_gust_lon_0", ...
    "model_trapezoidal_gust_alt_0", ...
    "model_trapezoidal_gust_gust_width", ...
    "model_trapezoidal_gust_amplitude", ...
    "model_trapezoidal_gust_gradient_north", ...
    "model_trapezoidal_gust_gradient_south", ...
    "model_trapezoidal_gust_gradient_east", ...
    "model_trapezoidal_gust_gradient_west"];

sinusoidal_gust_log_ids = [ ...
    "model_sinusoidal_gust_lat_0", ...
    "model_sinusoidal_gust_lon_0", ...
    "model_sinusoidal_gust_alt_0", ...
    "model_sinusoidal_gust_gust_width", ...
    "model_sinusoidal_gust_amplitude"];

les_gust_log_ids = [ ...
    "model_les_gust_lat_0", ...
    "model_les_gust_lon_0", ...
    "model_les_gust_alt_0", ...
    "model_les_gust_gust_width", ...
    "model_les_gust_amplitude_u", ...
    "model_les_gust_amplitude_v", ...
    "model_les_gust_amplitude_w", ...
    "model_les_gust_gust_class"];

cosine_gust_log_ids = [ ...
    "model_cosine_gust_lat_0", ...
    "model_cosine_gust_lon_0", ...
    "model_cosine_gust_alt_0", ...
    "model_cosine_gust_gust_width", ...
    "model_cosine_gust_amplitude"];

trapezoidal_gust_params = transform_data(trapezoidal_gust_log_ids, trapezoidal_gust_capacity, out);
sinusoidal_gust_params = transform_data(sinusoidal_gust_log_ids, sinusoidal_gust_capacity, out);
les_gust_params = transform_data(les_gust_log_ids, les_gust_capacity, out);
cosine_gust_params = transform_data(cosine_gust_log_ids, cosine_gust_capacity, out);

%% Run sim and plot
% Running this section make sure the base models have restored their sample time otherwise this section will fail

warning("off");

resolution = 100;

[total_trapez_instances ,plot_values_trapez] = plot_instances_of_model( ...
    trapezoidal_gust_params, ...
    "model_trapezoidal_gust_w_g", ...
    "model_trapezoidal_gust_test", ...
    length(trapezoidal_gust_log_ids), ...
    trapezoidal_gust_capacity, ...
    resolution);
[total_sinus_instances, plot_values_sinus] = plot_instances_of_model( ...
    sinusoidal_gust_params, ...
    "model_sinusoidal_gust_w_g", ...
    "model_sinusoidal_gust_test", ...
    length(sinusoidal_gust_log_ids), ...
    sinusoidal_gust_capacity, ...
    resolution);
[total_les_instances, plot_values_les] = plot_instances_of_model( ...
    les_gust_params, ...
    "model_les_gust_w_g", ...
    "model_knigge_test", ...
    length(les_gust_log_ids), ...
    les_gust_capacity, ...
    resolution);
[total_cosine_instances, plot_values_cosine] = plot_instances_of_model( ...
    cosine_gust_params, ...
    "model_cosine_gust_w_g", ...
    "model_cosine_gust_test", ...
    length(cosine_gust_log_ids), ...
    cosine_gust_capacity, ...
    resolution);

%% Plot

h = figure("visible", "off");
hold on;

for i = 1:total_trapez_instances
    s = surf(plot_values_trapez{i, 1}, plot_values_trapez{i, 2}, plot_values_trapez{i, 3});
    s.EdgeAlpha = 0;
end

for i = 1:total_sinus_instances
    s = surf(plot_values_sinus{i, 1}, plot_values_sinus{i, 2}, plot_values_sinus{i, 3});
    s.EdgeAlpha = 0;
end

for i = 1:total_les_instances
    s = surf(plot_values_les{i, 1}, plot_values_les{i, 2}, plot_values_les{i, 3});
    s.EdgeAlpha = 0;
end

for i = 1:total_cosine_instances
    s = surf(plot_values_cosine{i, 1}, plot_values_cosine{i, 2}, plot_values_cosine{i, 3});
    s.EdgeAlpha = 0;
end

hold off;
set(h, "visible", "on");

%% Run the simulations

warning("off");

model_type = "trapezoidal";
resolution = 100;
START_TIME = 0.0;
SAMPLE_TIME = 0.008;

h = figure("visible", "off");
hold on;
if length(lat) == resolution*resolution + 1
    lat(end, :) = [];
end
if length(lon) == resolution*resolution + 1
    lon(end, :) = [];
end

total_instances = 0;
for i = 1:trapezoidal_gust_capacity
    total_instances = total_instances + length(trapezoidal_gust_params{1, i});
end

current_instance = 0;
for i = 1:trapezoidal_gust_capacity
    current_params = trapezoidal_gust_params(:, i);
%     current_lat_0 = trapezoidal_gust_params{1, i};
%     current_lon_0 = trapezoidal_gust_params{2, i};
%     current_alt_0 = trapezoidal_gust_params{3, i};
%     current_gust_width = trapezoidal_gust_params{4, i};
    num_instances = length(trapezoidal_gust_params{1, i});
    % disp("Total instances in current slot: " + num_instances);
    for j = 1:num_instances
        % disp("Current instance: " + j);
        current_values = zeros([1, num_params]);
        for k = 1:num_params
            current_values(k) = current_params{k, 1}(j);
        end
        lat_j = current_values(1);
        lon_j = current_values(2);
        alt_j = current_values(3);
        gust_width_j = current_values(4)/2;
        [north, south, east, west] = calculate_boundaries(gust_width_j, lat_j, lon_j, alt_j);
        STOP_TIME = resolution*resolution*SAMPLE_TIME;
        time = linspace(0, STOP_TIME-START_TIME, (STOP_TIME-START_TIME)*FREQUENCY+1);  % s
        [lat_matrix, lon_matrix] = meshgrid(linspace(south, north, resolution), linspace(east, west, resolution));
        lat(:, 1) = time(1:end-1);
        lat(:, 2) = reshape(lat_matrix, [resolution*resolution, 1]);
        lon(:, 1) = time(1:end-1);
        lon(:, 2) = reshape(lon_matrix, [resolution*resolution, 1]);
        alt = [0, alt_j];
        lat_0 = [0, lat_j];
        lon_0 = [0, lon_j];
        alt_0 = [0, alt_j];
        gust_width = [0, gust_width_j];
        amplitude = [0, current_values(5)];
        if model_type == "trapezoidal"
            gradient_north = [0, current_values(6)];
            gradient_south = [0, current_values(7)];
            gradient_east = [0, current_values(8)];
            gradient_west = [0, current_values(9)];
        end
        simOut = sim("model_trapezoidal_gust_test");
        w_W_g = simOut.logsout.getElement("model_trapezoidal_gust_w").Values;
        s = surf(lat_matrix, lon_matrix, reshape(w_W_g.Data(1:end-1), [resolution, resolution]));
        s.EdgeAlpha = 0;
        current_instance = current_instance + 1;
        disp("Progress: " + current_instance/total_instances*100 + "%");
    end
end

hold off;
set(h, "visible", "on");

%% Functions

function gust_params = transform_data(model_param_ids, capacity, simOut)
    gust_lat_0 = cell(1, capacity);
    model_gust_lat_0 = simOut.logsout.getElement(model_param_ids(1)).Values;

    for i = 1:capacity
        gust_lat_0{1, i}(:, 1) = model_gust_lat_0.Data(i:capacity:end-1+i);
    end

    relevant_indexes = cell(1, capacity);

    for i = 1:capacity
        relevant_indexes{1, i} = zeros([length(gust_lat_0{1, i}), 1]);
        relevant_indexes{1, i}(1, 1) = 1;
    end

    for i = 1:capacity
        current_slot = gust_lat_0{1, i};
        valid_index = 2;
        for j = 1:length(current_slot)-1
            current_value = current_slot(j, 1);
            next_value = current_slot(j+1, 1);
            if next_value-current_value ~= 0
                relevant_indexes{1, i}(valid_index, 1) = j+1;
                valid_index = valid_index + 1;
            end
        end
    end

    % Cut off trailing zeros
    for i = 1:capacity
        last = find(relevant_indexes{1, i}==0, 1);
        relevant_indexes{1, i} = relevant_indexes{1, i}(1:last-1);
    end

    num_params = length(model_param_ids);

    gust_params = cell(num_params, capacity);

    for i = 1:num_params
        for j = 1:capacity
            model_param = simOut.logsout.getElement(model_param_ids(i)).Values;
            gust_params{i, j}(:, 1) = model_param.Data(j:capacity:end-1+j);
            gust_params{i, j} = gust_params{i, j}(relevant_indexes{1, j});
        end
    end
end

function [total_instances, plot_values] = plot_instances_of_model(model_params, model_log_id_w, model_name, num_params, capacity, resolution)
    START_TIME = 0.0;
    SAMPLE_TIME = 0.008;
    FREQUENCY = 125;

    total_instances = 0;
    for i = 1:capacity
        total_instances = total_instances + length(model_params{1, i});
    end

    plot_values = cell(total_instances, 3);

    current_instance = 0;
    for i = 1:capacity
        current_params = model_params(:, i);
        num_instances = length(model_params{1, i});
        % disp("Total instances in current slot: " + num_instances);
        for j = 1:num_instances
            % disp("Current instance: " + j);
            current_values = zeros([1, num_params]);
            for k = 1:num_params
                current_values(k) = current_params{k, 1}(j);
            end
            lat_j = current_values(1);
            lon_j = current_values(2);
            alt_j = current_values(3);
            gust_width_j = current_values(4)/2;
            [north, south, east, west] = calculate_boundaries(gust_width_j, lat_j, lon_j, alt_j);
            STOP_TIME = resolution*resolution*SAMPLE_TIME;
            time = linspace(0, STOP_TIME-START_TIME, (STOP_TIME-START_TIME)*FREQUENCY+1);  % s
            [lat_matrix, lon_matrix] = meshgrid(linspace(south, north, resolution), linspace(east, west, resolution));
            lat(:, 1) = time(1:end-1);
            lat(:, 2) = reshape(lat_matrix, [resolution*resolution, 1]);
            lon(:, 1) = time(1:end-1);
            lon(:, 2) = reshape(lon_matrix, [resolution*resolution, 1]);
            alt = [0, alt_j];
            lat_0 = [0, lat_j];
            lon_0 = [0, lon_j];
            alt_0 = [0, alt_j];
            gust_width = [0, gust_width_j];
            amplitude = [0, current_values(5)];

            simIn = Simulink.SimulationInput(model_name);
            simIn = simIn.setVariable("lat", lat);
            simIn = simIn.setVariable("lon", lon);
            simIn = simIn.setVariable("alt", alt);
            simIn = simIn.setVariable("lat_0", lat_0);
            simIn = simIn.setVariable("lon_0", lon_0);
            simIn = simIn.setVariable("alt_0", alt_0);
            simIn = simIn.setVariable("gust_width", gust_width);
            if model_name == "model_trapezoidal_gust_test"
                gradient_north = [0, current_values(6)];
                gradient_south = [0, current_values(7)];
                gradient_east = [0, current_values(8)];
                gradient_west = [0, current_values(9)];
                simIn = simIn.setVariable("amplitude", amplitude);
                simIn = simIn.setVariable("gradient_north", gradient_north);
                simIn = simIn.setVariable("gradient_south", gradient_south);
                simIn = simIn.setVariable("gradient_east", gradient_east);
                simIn = simIn.setVariable("gradient_west", gradient_west);
            elseif model_name == "model_knigge_test"
                amplitude_u = [0, current_values(5)];
                amplitude_v = [0, current_values(6)];
                amplitude_w = [0, current_values(7)];
                gust_class = [0, current_values(8)];
                simIn = simIn.setVariable("amplitude_u", amplitude_u);
                simIn = simIn.setVariable("amplitude_v", amplitude_v);
                simIn = simIn.setVariable("amplitude_w", amplitude_w);
                simIn = simIn.setVariable("gust_class", gust_class);
            else
                simIn = simIn.setVariable("amplitude", amplitude);
            end

            simOut = sim(simIn);
            w_W_g = simOut.logsout.getElement(model_log_id_w).Values;
            plot_values(current_instance+1, :) = {lat_matrix, lon_matrix, reshape(w_W_g.Data(1:end-1), [resolution, resolution])};
            %s = surf(lat_matrix, lon_matrix, reshape(w_W_g.Data(1:end-1), [resolution, resolution]));
            %s.EdgeAlpha = 0;
            current_instance = current_instance + 1;
            disp("Progress for " + model_name + ": " + current_instance/total_instances*100 + "%");
        end
    end
end
