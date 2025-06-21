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

% The following parameters have to be 1x2, because they are scalar
% and constant throughout the simulation

q0 = [0, 0];  % 1
q1 = [0, 0];  % 1
q2 = [0, 0];  % 1
q3 = [0, 0];  % 1

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

% Capacity config

sinusoidal_gust_capacity = 5;
trapezoidal_gust_capacity = 5;
knigge_gust_capacity = 5;
cosine_gust_capacity = 5;

% Sinusoidal gust config

number_sinusoidal_gust_parameters = 5;
% 5 is amount of parameters for sinusoidal gusts
SINUSOIDAL_GUST_EMPTY = zeros([sinusoidal_gust_capacity, 1]);
SINUSOIDAL_GUST_MAX_WIDTH = 5;  % m
SINUSOIDAL_GUST_MAX_AMPLITUDE = 5;  % m/s

% Trapezoidal gust config

number_trapezoidal_gust_parameters = 9;
% 9 is amount of parameters for trapezoidal gusts
TRAPEZOIDAL_GUST_EMPTY = zeros([trapezoidal_gust_capacity, 1]);
TRAPEZOIDAL_GUST_MAX_WIDTH = 5;  % m
TRAPEZOIDAL_GUST_MAX_AMPLITUDE = 5;  % m/s

% Knigge gust config

number_knigge_parameters = 6;
% 6 is amount of parameters for knigge gusts
KNIGGE_GUST_EMPTY = zeros([knigge_gust_capacity, 1]);
KNIGGE_GUST_MAX_WIDTH = 5;  % m
KNIGGE_GUST_MAX_AMPLITUDE = 5;  % m/s

% 1-cos gust config

number_cosine_gust_parameters = 5;
% 5 is amount of parameters for trapezoidal gusts
COSINE_GUST_EMPTY = zeros([cosine_gust_capacity, 1]);
COSINE_GUST_MAX_WIDTH = 5;  % m
COSINE_GUST_MAX_AMPLITUDE = 5;  % m/s
