function [north, south, east, west] = calculate_boundaries(radius, lat, lon, alt)
    %   CALCULATE_BOUNDARIES Summary of this function goes here
    %   Detailed explanation goes here
    lat = rad2deg(lat);
    lon = rad2deg(lon);
    north_lla = ned2lla([radius, 0, 0], [lat, lon, alt], "flat");
    north = deg2rad(north_lla(1));  % rad
    south_lla = ned2lla([-radius, 0, 0], [lat, lon, alt], "flat");
    south = deg2rad(south_lla(1));  % rad
    east_lla = ned2lla([0, radius, 0], [lat, lon, alt], "flat");
    east = deg2rad(east_lla(2));  % rad
    west_lla = ned2lla([0, -radius, 0], [lat, lon, alt], "flat");
    west = deg2rad(west_lla(2));  % rad
end

