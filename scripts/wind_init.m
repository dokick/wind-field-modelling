% read_wind_field;

% load("MyConfiguration.mat");

simulation_time = 1000;  % s

matrix_idx = ceil((0:0.02:simulation_time) / 3600);
matrix_idx(1) = 1;

number_of_latitude_elements = 400;
number_of_longitude_elements = 500;
number_of_heights = 28;

ts_wind_u = timeseries(0, 0:0.02:simulation_time);
ts_wind_v = timeseries(0, 0:0.02:simulation_time);
ts_wind_w = timeseries(0, 0:0.02:simulation_time);

% Wind models config

rng(12345);

EVENT_HORIZON = 1000;  % m

% Translational wind config
trans_lat_start = 0;  % rad
trans_lat_end = 0.5;  % rad
trans_lon_start = 0;  % rad
trans_lon_end = 0.5;  % rad
trans_height_start = 0;  % rad
trans_height_end = 0.5;  % rad
translationalWind = createTranslationalWind( ...
    trans_lat_start, trans_lat_end, trans_lon_start, trans_lon_end, trans_height_start, trans_height_end, ...
    [10*rand, 10*rand, 10*rand]);

% Gust config
gust_start_time = 10*rand;  % s
gust_length = [(120-80)*rand+80 (120-80)*rand+80 (120-80)*rand+80];  % [m] dx, dy, dz (NED)
gust_amplitude = [4*rand 4*rand 4*rand];  % [m/s] ug, vg, wg
% ts_wind_u = ts_wind_u + createGust(gust_start_time, gust_length, gust_amplitude);

lat_breakpoints = (47:0.02:54.98)*pi/180;
lon_breakpoints = (5:0.02:14.98)*pi/180;
% height_breakpoints = [...
%     10.000, ...
%     37.606, ...
%     77.745, ...
%     126.857, ...
%     183.592, ...
%     317.092, ...
%     393.002, ...
%     474.652, ...
%     561.856, ...
%     654.479, ...
%     752.427, ...
%     855.630, ...
%     924.048, ...
%     1077.658, ...
%     1196.457, ...
%     1320.458, ...
%     1449.686, ...
%     1584.179, ...
%     1723.991, ...
%     1869.185, ...
%     2019.836, ...
%     2176.032, ...
%     247.172, ...
%     2337.870, ...
%     2505.461, ...
%     2678.926, ...
%     2858.399, ...
%     3044.029];

HEIGHT_BREAKPOINTS = [...
    3044.029, ...
    2858.399, ...
    2678.926, ...
    2505.461, ...
    2337.870, ...
    2176.032, ...
    2019.836, ...
    1869.185, ...
    1723.991, ...
    1584.179, ...
    1449.686, ...
    1320.458, ...
    1196.457, ...
    1077.658, ...
    924.048, ...
    855.630, ...
    752.427, ...
    654.479, ...
    561.856, ...
    474.652, ...
    393.002, ...
    317.092, ...
    247.172, ...
    183.592, ...
    126.857, ...
    77.745, ...
    37.606, ...
    10.000];

quaternionBus = defineBus(4, "Bus for quaternions", ["q0", "q1", "q2", "q3"], "real", 1, "double", 0, 1, "1", ["1st quaternion", "2nd quaternion", "3rd quaternion", "4th quaternion"]);
velocityBus = defineBus(3, "Bus for translatorial wind velocities", ["u", "v", "w"], "real", 1, "double", 0, 100, "m/s", ["u = north velocity", "v = east velocity", "w = down velocity"]);
rotationBus = defineBus(3, "Bus for rotational wind velocities", ["p", "q", "r"], "real", 1, "double", 0, 100, "1/s", ["p = rotation around -axis", "q = rotation around -axis", "r = rotation around -axis"]);

% Gust configs:

capacities.sinusoidal_gust_capacity = 5;
capacities.trapezoidal_gust_capacity = 5;

% TODO: Make this into an array so multiple can exist
sinusoidal_gust_boundaries = create_boundaries(0, 2*pi, 0, 2*pi, 0, 3000);
sinusoidal_gust = create_sinusoidal_gust(0, sinusoidal_gust_boundaries, 5, 5, 5);

% TODO: Make this into an array so multiple can exist
trapezoidal_boundaries = create_boundaries(0, 2*pi, 0, 2*pi, 0, 3000);
% trapezoidal_gust = create_trapezoidal_gust(trapezoidal_boundaries, pi/4, pi/4, 5, 5);
trapezoidal_gust_bus = defineBus(10, ...
    "Bus for trapez gusts", ...
    ["LAT_START", "LAT_END", "LON_START", "LON_END", "HEIGHT_START", "HEIGHT_END", ...
    "angle_entry", "angle_exit", "amplitude", "width"], ...
    "real", 1, "double", -1000, 1000, "", ...
    ["", "", "", "", "", "", "", "", "", ""]);
trapezoidal_gusts = zeros([capacities.trapezoidal_gust_capacity, 9]);  % 9 is amount of parameters for trapez gusts

for i = 1:capacities.trapezoidal_gust_capacity
    trapezoidal_gusts(i, 1) = 55;  % lat_0
    trapezoidal_gusts(i, 2) = 40;  % lon_0
    trapezoidal_gusts(i, 3) = 1000;  % alt_0
    trapezoidal_gusts(i, 4) = 1000;  % width
    trapezoidal_gusts(i, 5) = 200;  % gradient_north
    trapezoidal_gusts(i, 6) = 200;  % gradient_south
    trapezoidal_gusts(i, 7) = 200;  % gradient_east
    trapezoidal_gusts(i, 8) = 200;  % gradient_west
    trapezoidal_gusts(i, 9) = 10;  % amplitude
end

function out = create_boundaries(lat_start, lat_end, lon_start, lon_end, height_start, height_end)
    % All units are rad or meters
    out.lat_start = lat_start;
    out.lat_end = lat_end;
    out.lon_start = lon_start;
    out.lon_end = lon_end;
    out.height_start = height_start;
    out.height_end = height_end;
end

function out = create_sinusoidal_gust(time_start, boundaries, amplitude, width, speed)
    % Units
    % [time_start] = s
    % [boundaries] = rad & m
    % [amplitude] = m/s
    % [width] = m
    % [speed] = m/s (tow speed)
    out.boundaries.lat_start = boundaries.lat_start;
    out.boundaries.lat_end = boundaries.lat_end;
    out.boundaries.lon_start = boundaries.lon_start;
    out.boundaries.lon_end = boundaries.lon_end;
    out.boundaries.height_start = boundaries.height_start;
    out.boundaries.height_end = boundaries.height_end;
    out.amplitude = amplitude;
    out.width = width;
    out.speed = speed;
    out.time_start = time_start;
end

function out = create_trapezoidal_gust(boundaries, angle_entry, angle_exit, amplitude, width)
    % Units
    % [boundaries] = rad & m
    % [angle_entry] = rad
    % [angle_exit] = rad
    % [amplitude] = m/s
    % [width] = m
    out.boundaries.lat_start = boundaries.lat_start;
    out.boundaries.lat_end = boundaries.lat_end;
    out.boundaries.lon_start = boundaries.lon_start;
    out.boundaries.lon_end = boundaries.lon_end;
    out.boundaries.height_start = boundaries.height_start;
    out.boundaries.height_end = boundaries.height_end;
    out.angle_entry = angle_entry;
    out.angle_exit = angle_exit;
    out.amplitude = amplitude;
    out.width = width;
end

function out = createTranslationalWind(lat_start, lat_end, lon_start, lon_end, height_start, height_end, velocity)
    % velocity (u v w) in NED coordinate system and m/s
    % precision = 0.02;
    % number_of_lat_elements = round((lat_end - lat_start) / precision);
    % number_of_lon_elements = round((lon_end - lon_start) / precision);
    % number_of_height_elements = round((height_end - height_start) / precision);
    out.u = padarray( ...
        zeros([2, 2, 2]) + velocity(1), ...
        [1 1 1], 0, "both");
    out.v = padarray( ...
        zeros([2, 2, 2]) + velocity(2), ...
        [1 1 1], 0, "both");
    out.w = padarray( ...
        zeros([2, 2, 2]) + velocity(3), ...
        [1 1 1], 0, "both");
end

% function ts = createModel(lat, lon, height)
%     ts = timeseries(0, 0:0.02:100);
%     for idx=0:0.02:100
%         ts.Data(idx) = createEmptyGermanMap();
%     end
% end

function out = createGauss(lat, lon, height, gust_start_time, gust_length, gust_amplitude)
    out.u = padarray( ...
        exp(-0.5 * ((-gust_length/2:gust_length/2 / gust_length) ^ 2)) / (gust_length*sqrt(2*pi)), ...
        [1 1 1], 0, "both");
    out.v = padarray( ...
        exp(-0.5 * ((-gust_length/2:gust_length/2 / gust_length) ^ 2)) / (gust_length*sqrt(2*pi)), ...
        [1 1 1], 0, "both");
    out.w = padarray( ...
        exp(-0.5 * ((-gust_length/2:gust_length/2 / gust_length) ^ 2)) / (gust_length*sqrt(2*pi)), ...
        [1 1 1], 0, "both");
end

function ts = createPotentialVortex(lat, lon, height, radius, circulation)
    ts = timeseries(0, 0:0.02:simulation_time);
    u_theta = - circulation / (2 * pi * radius);
    for idx=0:0.02:100
        ts.Data(idx) = createEmptyGermanMap();
    end
end

function matrix = createEmptyGermanMap()
    number_of_latitude_elements = 400;
    number_of_longitude_elements = 500;
    number_of_heights = 28;
    matrix = zeros( ...
        number_of_latitude_elements, ...
        number_of_longitude_elements, ...
        number_of_heights);
end

function bus = defineBus(numberOfElems, busDescription, busElemName, busElemComplexity, busElemDim, busElemType, busElemMin, busElemMax, busElemDocUnit, busElemDescription)
    bus = Simulink.Bus;
    bus.Description = busDescription;
    bus.DataScope = 'Auto';
    bus.HeaderFile = '';
    bus.Alignment = -1;
    % elems = cell([1, numberOfElems]);
    for i = 1:numberOfElems
        elems(i) = Simulink.BusElement;
        elems(i).Name = busElemName(i);
        elems(i).Complexity = busElemComplexity;
        elems(i).Dimensions = busElemDim;
        elems(i).DataType = busElemType;
        elems(i).Min = busElemMin;
        elems(i).Max = busElemMax;
        elems(i).DimensionsMode = 'Fixed';
        elems(i).SamplingMode = 'Sample based';
        elems(i).SampleTime = -1;
        elems(i).DocUnits = busElemDocUnit;
        elems(i).Description = busElemDescription(i);
    end
    bus.Elements = elems;
end
