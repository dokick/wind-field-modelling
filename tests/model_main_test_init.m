% This is a unit test script and shouldn't fail, because of already defined variables in the workspace
% That's why clear is called
clear;

load("MyConfiguration4900.mat");

distance = 147;  % km Berlin -> Magdeburg

FREQUENCY = 125;  % Hz
SIM_TIME = 4900;  % s

time = linspace(0, SIM_TIME, SIM_TIME*FREQUENCY + 1);  % s

lat_north = 52.5;  % deg
lat_south = 52;  % deg
lat = zeros(length(time), 2);
lat(:, 1) = time;
lat(:, 2) = linspace( ...
    deg2rad(lat_north), ...
    deg2rad(lat_south), ...
    length(time));  % rad

lon_east = 13.5;
lon_west = 11.5;
lon = zeros(length(time), 2);
lon(:, 1) = time;
lon(:, 2) = linspace( ...
    deg2rad(lon_east), ...
    deg2rad(lon_west), ...
    length(time));  % rad

alt = zeros(length(time), 2);
alt(:, 1) = time;
alt(:, 2) = linspace(1000, 1000, length(time));  % m

q0 = [0, 0];
q1 = [0, 0];
q2 = [0, 0];
q3 = [0, 0];

u_in = [0, 0];  % m/s
v_in = [0, 0];  % m/s
w_in = [0, 0];  % m/s

p_g = [0, 0];  % 1/s
q_g = [0, 0];  % 1/s
r_g = [0, 0];  % 1/s

EVENT_HORIZON = 1000;

north_lla = ned2lla([EVENT_HORIZON/2, 0, 0], [lat_north, lon_east, 1000], "flat");
north = north_lla(1);  % deg
south_lla = ned2lla([-EVENT_HORIZON/2, 0, 0], [lat_north, lon_east, 1000], "flat");
south = south_lla(1);  % deg
east_lla = ned2lla([0, EVENT_HORIZON/2, 0], [lat_north, lon_east, 1000], "flat");
east = east_lla(2);  % deg
west_lla = ned2lla([0, -EVENT_HORIZON/2, 0], [lat_north, lon_east, 1000], "flat");
west = west_lla(2);  % deg

SEED = 11;
rng(SEED, "twister");

sinusoidal_gust_capacity = 5;
trapezoidal_gust_capacity = 5;
knigge_gust_capacity = 5;
cosine_gust_capacity = 5;

% The following parameters have to be 1x2, because they are scalar
% and constant throughout the simulation

% Sinusoidal gust config

number_sinusoidal_gust_parameters = 5;
% 5 is amount of parameters for sinusoidal gusts
sinusoidal_gusts = zeros([sinusoidal_gust_capacity, number_sinusoidal_gust_parameters]);
SINUSOIDAL_GUST_EMPTY = zeros([sinusoidal_gust_capacity, 1]);
SINUSOIDAL_GUST_MAX_WIDTH = 5;  % m
SINUSOIDAL_GUST_MAX_AMPLITUDE = 5;  % m/s

for i = 1:sinusoidal_gust_capacity
    sinusoidal_gusts(i, 1) = 55;  % [lat_0] = deg
    sinusoidal_gusts(i, 2) = 40;  % [lon_0] = deg
    sinusoidal_gusts(i, 3) = 1000;  % [alt_0] = m
    sinusoidal_gusts(i, 4) = SINUSOIDAL_GUST_MAX_WIDTH*rand;  % [gust_width] = m
    sinusoidal_gusts(i, 5) = SINUSOIDAL_GUST_MAX_AMPLITUDE*rand;  % [amplitude] = m/s
end

% Trapezoidal gust config

number_trapezoidal_gust_parameters = 9;
% 9 is amount of parameters for trapezoidal gusts
trapezoidal_gusts = zeros([trapezoidal_gust_capacity, number_trapezoidal_gust_parameters]);
TRAPEZOIDAL_GUST_EMPTY = zeros([trapezoidal_gust_capacity, 1]);
TRAPEZOIDAL_GUST_MAX_WIDTH = 5;  % m
TRAPEZOIDAL_GUST_MAX_AMPLITUDE = 5;  % m/s

for i = 1:trapezoidal_gust_capacity
    trapezoidal_gusts(i, 1) = 55;  % [lat_0] = deg
    trapezoidal_gusts(i, 2) = 40;  % [lon_0] = deg
    trapezoidal_gusts(i, 3) = 1000;  % [alt_0] = m
    trapezoidal_gusts(i, 4) = TRAPEZOIDAL_GUST_MAX_WIDTH*rand;  % [gust_width] = m
    trapezoidal_gusts(i, 5) = 200;  % [gradient_north] = (m/s)/rad
    trapezoidal_gusts(i, 6) = 200;  % [gradient_south] = (m/s)/rad
    trapezoidal_gusts(i, 7) = 200;  % [gradient_east] = (m/s)/rad
    trapezoidal_gusts(i, 8) = 200;  % [gradient_west] = (m/s)/rad
    trapezoidal_gusts(i, 9) = TRAPEZOIDAL_GUST_MAX_AMPLITUDE*rand;  % [amplitude] = m/s
end

% Knigge gust config

number_knigge_parameters = 6;
% 6 is amount of parameters for knigge gusts
knigge_gusts = zeros([knigge_gust_capacity, number_knigge_parameters]);
KNIGGE_GUST_EMPTY = zeros([knigge_gust_capacity, 1]);
KNIGGE_GUST_MAX_WIDTH = 5;  % m
KNIGGE_GUST_MAX_AMPLITUDE = 5;  % m/s

for i = 1:knigge_gust_capacity
    knigge_gusts(i, 1) = 55;  % [lat_0] = deg
    knigge_gusts(i, 2) = 40;  % [lon_0] = deg
    knigge_gusts(i, 3) = 1000;  % [alt_0] = m
    knigge_gusts(i, 4) = KNIGGE_GUST_MAX_WIDTH*rand;  % [gust_width] = m
    knigge_gusts(i, 5) = KNIGGE_GUST_MAX_AMPLITUDE*rand;  % [amplitude] = m/s
    knigge_gusts(i, 6) = randi(3);  % [gust_class] = -
end

% 1-cos gust config

number_cosine_gust_parameters = 5;
% 5 is amount of parameters for trapezoidal gusts
cosine_gusts = zeros([cosine_gust_capacity, number_cosine_gust_parameters]);
COSINE_GUST_EMPTY = zeros([cosine_gust_capacity, 1]);
COSINE_GUST_MAX_WIDTH = 5;  % m
COSINE_GUST_MAX_AMPLITUDE = 5;  % m/s

for i = 1:cosine_gust_capacity
    cosine_gusts(i, 1) = 55;  % [lat_0] = deg
    cosine_gusts(i, 2) = 40;  % [lon_0] = deg
    cosine_gusts(i, 3) = 1000;  % [alt_0] = m
    cosine_gusts(i, 4) = COSINE_GUST_MAX_WIDTH*rand;  % [gust_width] = m
    cosine_gusts(i, 5) = COSINE_GUST_MAX_AMPLITUDE*rand;  % [amplitude] = m/s
end
