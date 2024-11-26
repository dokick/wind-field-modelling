function out = create_boundaries(lat_start, lat_end, lon_start, lon_end, height_start, height_end)
    % CREATEBOUNDARIES Creates a LAT, LON, HEIGHT Box
    % All units are rad or meters
    out.lat_start = lat_start;
    out.lat_end = lat_end;
    out.lon_start = lon_start;
    out.lon_end = lon_end;
    out.height_start = height_start;
    out.height_end = height_end;
end
