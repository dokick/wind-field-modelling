% This is a unit test script and shouldn't fail, because of already defined variables in the workspace
% That's why clear is called
clear;

load("MyConfigurationDyn.mat");

FREQUENCY = 125;  % Hz
START_TIME = 0;
STOP_TIME = 8000;  % s
SAMPLE_TIME = 1/FREQUENCY;  % s

SIM_TIME = STOP_TIME - START_TIME;  % s

time = linspace(0, SIM_TIME, SIM_TIME*FREQUENCY + 1);  % s

lat_north = 52.5;  % deg
lat_south = 52.45;  % deg
lat = zeros(length(time), 2);
lat(:, 1) = time;
lat(:, 2) = linspace( ...
    deg2rad(lat_north), ...
    deg2rad(lat_south), ...
    length(time));  % rad

lon_east = 13.5;
lon_west = 12;
lon = zeros(length(time), 2);
lon(:, 1) = time;
lon(:, 2) = linspace( ...
    deg2rad(lon_east), ...
    deg2rad(lon_west), ...
    length(time));  % rad

alt = zeros(length(time), 2);
alt(:, 1) = time;
alt(:, 2) = linspace(1000, 1000, length(time));  % m

EVENT_HORIZON = 1000;

north_lla = ned2lla([EVENT_HORIZON, 0, 0], [lat_north, lon_east, 1000], "flat");
north = north_lla(1);  % deg
south_lla = ned2lla([-EVENT_HORIZON, 0, 0], [lat_north, lon_east, 1000], "flat");
south = south_lla(1);  % deg
east_lla = ned2lla([0, EVENT_HORIZON, 0], [lat_north, lon_east, 1000], "flat");
east = east_lla(2);  % deg
west_lla = ned2lla([0, -EVENT_HORIZON, 0], [lat_north, lon_east, 1000], "flat");
west = west_lla(2);  % deg

rng(11, "twister");

% The following parameters have to be 1x2, because they are scalar
% and constant throughout the simulation

% lat_0 = [0, (north-south)*rand + south]; % deg
lat_0 = [0, deg2rad(lat_north)];  % rad
% lon_0 = [0, (east-west)*rand + west]; % deg
lon_0 = [0, deg2rad(lon_east)];  % rad
alt_0 = [0, 1000]; % m

% The following paramters are specific to the phenomena

gust_width = [0, 200];  % m
[u_m, v_m, w_m] = calculate_amplitude(alt_0(2), gust_width(2));
amplitude_u = [0, u_m];  % m/s
amplitude_v = [0, v_m];  % m/s
amplitude_w = [0, w_m];  % m/s
% Gust class options: 1, 2, 3
gust_class = [0, 3];  % -
