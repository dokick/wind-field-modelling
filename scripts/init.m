% clear;

% read_wind_field;

grid_step = 0.02;
lat_breakpoints = (47:grid_step:54.98)*pi/180;
lon_breakpoints = (5:grid_step:14.98)*pi/180;
% height_breakpoints = [...
%     10.000, ...
%     37.606, ...
%     77.745, ...
%     126.857, ...
%     183.592, ...
%     317.092, ...
%     393.002, ...
%     474.652, ...
%     561.856, ...
%     654.479, ...
%     752.427, ...
%     855.630, ...
%     924.048, ...
%     1077.658, ...
%     1196.457, ...
%     1320.458, ...
%     1449.686, ...
%     1584.179, ...
%     1723.991, ...
%     1869.185, ...
%     2019.836, ...
%     2176.032, ...
%     247.172, ...
%     2337.870, ...
%     2505.461, ...
%     2678.926, ...
%     2858.399, ...
%     3044.029];

height_breakpoints = [...
    3044.029, ...
    2858.399, ...
    2678.926, ...
    2505.461, ...
    2337.870, ...
    2176.032, ...
    2019.836, ...
    1869.185, ...
    1723.991, ...
    1584.179, ...
    1449.686, ...
    1320.458, ...
    1196.457, ...
    1077.658, ...
    924.048, ...
    855.630, ...
    752.427, ...
    654.479, ...
    561.856, ...
    474.652, ...
    393.002, ...
    317.092, ...
    247.172, ...
    183.592, ...
    126.857, ...
    77.745, ...
    37.606, ...
    10.000];

quaternionBus = defineBus(4, "Bus for quaternions", ["q0", "q1", "q2", "q3"], "real", 1, "double", 0, 1, "1", ["1st quaternion", "2nd quaternion", "3rd quaternion", "4th quaternion"]);
velocityBus = defineBus(3, "Bus for translatorial wind velocities", ["u", "v", "w"], "real", 1, "double", 0, 100, "m/s", ["u = north velocity", "v = east velocity", "w = down velocity"]);
rotationBus = defineBus(3, "Bus for rotational wind velocities", ["p", "q", "r"], "real", 1, "double", 0, 100, "1/s", ["p = rotation around -axis", "q = rotation around -axis", "r = rotation around -axis"]);

function bus = defineBus(numberOfElems, busDescription, busElemName, busElemComplexity, busElemDim, busElemType, busElemMin, busElemMax, busElemDocUnit, busElemDescription)
    bus = Simulink.Bus;
    bus.Description = busDescription;
    bus.DataScope = 'Auto';
    bus.HeaderFile = '';
    bus.Alignment = -1;
    % elems = cell([1, numberOfElems]);
    for i = 1:numberOfElems
        elems(i) = Simulink.BusElement;
        elems(i).Name = busElemName(i);
        elems(i).Complexity = busElemComplexity;
        elems(i).Dimensions = busElemDim;
        elems(i).DataType = busElemType;
        elems(i).Min = busElemMin;
        elems(i).Max = busElemMax;
        elems(i).DimensionsMode = 'Fixed';
        elems(i).SamplingMode = 'Sample based';
        elems(i).SampleTime = -1;
        elems(i).DocUnits = busElemDocUnit;
        elems(i).Description = busElemDescription(i);
    end
    bus.Elements = elems;
end