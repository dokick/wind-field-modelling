% This is a unit test script and shouldn't fail, because of already defined variables in the workspace
% That's why clear is called
clear;

load("MyConfiguration80.mat");

FREQUENCY = 125;  % Hz
SIM_TIME = 300;  % s

time = linspace(0, SIM_TIME, SIM_TIME*FREQUENCY + 1);  % s

lat_north = 53;  % deg
lat_south = 52;  % deg
lat = zeros(length(time), 2);
lat(:, 1) = time;
lat(:, 2) = linspace( ...
    deg2rad(lat_north), ...
    deg2rad(lat_south), ...
    length(time));  % rad

lon_east = 14;  % deg
lon_west = 13;  % deg
lon = zeros(length(time), 2);
lon(:, 1) = time;
lon(:, 2) = linspace( ...
    deg2rad(lon_east), ...
    deg2rad(lon_west), ...
    length(time));  % rad

alt = zeros(length(time), 2);
alt(:, 1) = time;
alt(:, 2) = linspace(1000, 1000, length(time));  % m

EVENT_HORIZON = 1000;  % m

north_lla = ned2lla([EVENT_HORIZON, 0, 0], [lat_north, lon_east, 1000], "flat");
north = north_lla(1);  % deg
south_lla = ned2lla([-EVENT_HORIZON, 0, 0], [lat_north, lon_east, 1000], "flat");
south = south_lla(1);  % deg
east_lla = ned2lla([0, EVENT_HORIZON, 0], [lat_north, lon_east, 1000], "flat");
east = east_lla(2);  % deg
west_lla = ned2lla([0, -EVENT_HORIZON, 0], [lat_north, lon_east, 1000], "flat");
west = west_lla(2);  % deg

% The following parameters have to be 1x2, because they are scalar
% and constant throughout the simulation

% lat_0 = [0, (north-south)*rand + south];  % deg
lat_0 = [0, deg2rad(53)];  % rad
% lon_0 = [0, (east-west)*rand + west];  % deg
lon_0 = [0, deg2rad(14)];  % rad
alt_0 = [0, 1000];  % m

amplitude = [0, 10];  % m/s
gust_width = [0, 500];  % m

gradient_north = [0, 2*amplitude(2)];  % m/s
gradient_south = [0, 2*amplitude(2)];  % m/s

gradient_east = [0, 3*amplitude(2)];  % m/s
gradient_west = [0, 3*amplitude(2)];  % m/s

