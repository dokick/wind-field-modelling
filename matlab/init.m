% clear;

% read_wind_field;

grid_step = 0.02;
lat_breakpoints = (47:grid_step:54.98)*pi/180;
lon_breakpoints = (5:grid_step:14.98)*pi/180;
height_breakpoints = 1:28;


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