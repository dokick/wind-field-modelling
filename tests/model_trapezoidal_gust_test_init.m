% This is a unit test script and shouldn't fail, because of already defined variables in the workspace
% That's why clear is called
clear;

time = linspace(0, 100); % s
lat = zeros(length(time), 2);
lat(:, 1) = time;
lat(:, 2) = linspace( ...
    deg2rad(52.5), ...
    deg2rad(52.5), ...
    length(time)); % rad
lon = zeros(length(time), 2);
lon(:, 1) = time;
lon(:, 2) = linspace( ...
    deg2rad(13.5), ...
    deg2rad(10.5), ...
    length(time)); % TODO
altitude = zeros(length(time), 2);
altitude(:, 1) = time;
altitude(:, 2) = linspace(1000, 1000, length(time)); % TODO

lat_0 = deg2rad(52.5); % rad
lon_0 = deg2rad(12); % rad
height_0 = 1000; % rad
angle_entry = deg2rad(45); % rad
angle_exit = deg2rad(40);
amplitude = 10; % m/s
width = 1000; % m
