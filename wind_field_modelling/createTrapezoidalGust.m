function out = createTrapezoidalGust(boundaries, angle_entry, angle_exit, amplitude, width)
    % CREATETRAPEZOIDALGUST Sets parameters fo a trapezoidal gust
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
