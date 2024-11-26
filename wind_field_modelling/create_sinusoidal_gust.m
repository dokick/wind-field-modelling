function out = create_sinusoidal_gust(time_start, boundaries, amplitude, width, speed)
    % CREATESINUSOIDALGUST Sets parameters for sinussoidal gusts
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
