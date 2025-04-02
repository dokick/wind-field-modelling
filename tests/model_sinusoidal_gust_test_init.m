% This is a unit test script and shouldn't fail, because of already defined variables in the workspace
% That's why clear is called
clear;

load("MyConfiguration80.mat");

FREQUENCY = 125; % Hz
SIM_TIME = 300; % s

CHORD_LENGTH = 5;  % m

time = linspace(0, SIM_TIME, SIM_TIME*FREQUENCY + 1); % s

lat = zeros(length(time), 2);
lat(:, 1) = time;
lat(:, 2) = linspace( ...
    deg2rad(52.5), ...
    deg2rad(52.45), ...
    length(time)); % rad

lon = zeros(length(time), 2);
lon(:, 1) = time;
lon(:, 2) = linspace( ...
    deg2rad(13.5), ...
    deg2rad(12), ...
    length(time)); % rad

altitude = zeros(length(time), 2);
altitude(:, 1) = time;
altitude(:, 2) = linspace(1000, 1000, length(time)); % m

% The following parameters have to be 1x2, because they are scalar
% and constant throughout the simulation

lat_0 = [0, 52.5]; % deg
lon_0 = [0, 13.5]; % deg
height_0 = [0, 1000]; % m

% The following paramters are specific to the phenomena

amplitude = [0, 10]; % m/s
gust_width = [0, 1000]; % m
