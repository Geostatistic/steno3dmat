%   Example 1:
%       >> % Initialize a Steno3D Point resource
%       >> myPoints = steno3d.core.Point;
%       >> myPoints.Mesh = steno3d.core.Mesh0D;
%       >> myPoints.Mesh.Vertices = rand(100, 3);
%       >>
%       >> % Create a DATARRAY the same length as the Vertices
%       >> myData = steno3d.core.DataArray;
%       >> myData.Title = 'Random Point Data';
%       >> myData.Array = rand(100, 1);
%       >>
%       >> % Bind the data to the Point resource
%       >> % Location must be specified; for points, the only available
%       >> % option is 'N' (nodes)
%       >> myPoints.Data = {                                            ...
%              'Location', 'N',                                         ...
%              'Data', myData                                           ...
%          };
%       >>
%       >> % Ensure that the Point resource is valid
%       >> myPoints.validate();
%
%   Example 2:
%       >> % Initialize a Steno3D Surface resource
%       >> mySurf = steno3d.core.Surface;
%       >> mySurf.Mesh = steno3d.core.Mesh2DGrid;
%       >> mySurf.Mesh.H1 = ones(5, 1);
%       >> mySurf.Mesh.H2 = ones(10, 1);
%       >>
%       >> % Create a DATARRAY the same size as the cell centers
%       >> ccValues = rand(5, 10);
%       >> myDataCC = steno3d.core.DataArray;
%       >> myDataCC.Title = 'Random Cell-Centered Data';
%       >> myDataCC.Array = ccValues(:);
%       >>
%       >> % Create a DATARRAY the same size as the nodes
%       >> nValues = rand(6, 11);
%       >> myDataN = steno3d.core.DataArray;
%       >> myDataN.Title = 'Random Node Data';
%       >> myDataN.Array = nValues(:);
%       >>
%       >> % Bind the data sets to their respective Surface locations
%       >> mySurf.Data{1} = {                                           ...
%              'Location', 'CC',                                        ...
%              'Data', myDataCC                                         ...
%          };
%       >> mySurf.Data{2} = {                                           ...
%              'Location', 'N',                                         ...
%              'Data', myDataN                                          ...
%          };
%       >>
%       >> % Ensure that the Surface resource is valid
%       >> mySurf.validate();
%
%   Example 3:
%       >> % Initialize the same resources as Examples 1 and 2
%       >> myPoints = steno3d.core.Point;
%       >> myPoints.Mesh = steno3d.core.Mesh0D;
%       >> myPoints.Mesh.Vertices = rand(100, 3);
%       >> mySurf = steno3d.core.Surface;
%       >> mySurf.Mesh = steno3d.core.Mesh2DGrid;
%       >> mySurf.Mesh.H1 = ones(5, 1);
%       >> mySurf.Mesh.H2 = ones(10, 1);
%       >>
%       >> % Use the steno3d.addData function to simplify adding data
%       >> steno3d.addData(myPoints, 'Random Point Data', rand(100, 1));
%       >> steno3d.addData(mySurf, 'Random Data 1', rand(5, 10));
%       >> steno3d.addData(mySurf, 'Random Data 2', rand(6, 11));
%       >>
%       >> % Ensure the resources are valid
%       >> myPoints.validate();
%       >> mySurf.validate();
%
%   You can run the above examples with:
%       >> steno3d.examples.data
%   This script packages the three examples into Steno3D Projects so they
%   can be plotted with:
%       >> example1.plot(); example2.plot(); example3.plot();
%
%   See also steno3d.core.DataArray, steno3d.core.binders,
%   steno3d.addData, steno3d.core.Point, steno3d.core.Surface,
%   steno3d.core.Mesh0D, steno3d.core.Mesh2DGrid
%


% Example 1:
% Initialize a Steno3D Point resource
myPoints = steno3d.core.Point;
myPoints.Mesh = steno3d.core.Mesh0D;
myPoints.Mesh.Vertices = rand(100, 3);

% Create a DATARRAY the same length as the Vertices
myData = steno3d.core.DataArray;
myData.Title = 'Random Point Data';
myData.Array = rand(100, 1);

% Bind the data to the Point resource
% Location must be specified; for points, the only available
% option is 'N' (nodes)
myPoints.Data = {                                            ...
    'Location', 'N',                                         ...
    'Data', myData                                           ...
};

% Ensure that the Point resource is valid
myPoints.validate();

example1 = steno3d.core.Project(                             ...
    'Title', 'Data: Example 1',                              ...
    'Resources', myPoints                                    ...
);
clear myPoints myData;

% Example 2:
% Initialize a Steno3D Surface resource
mySurf = steno3d.core.Surface;
mySurf.Mesh = steno3d.core.Mesh2DGrid;
mySurf.Mesh.H1 = ones(5, 1);
mySurf.Mesh.H2 = ones(10, 1);

% Create a DATARRAY the same size as the cell centers
ccValues = rand(5, 10);
myDataCC = steno3d.core.DataArray;
myDataCC.Title = 'Random Cell-Centered Data';
myDataCC.Array = ccValues(:);

% Create a DATARRAY the same size as the nodes
nValues = rand(6, 11);
myDataN = steno3d.core.DataArray;
myDataN.Title = 'Random Node Data';
myDataN.Array = nValues(:);

% Bind the data sets to their respective Surface locations
mySurf.Data{1} = {                                           ...
    'Location', 'CC',                                        ...
    'Data', myDataCC                                         ...
};
mySurf.Data{2} = {                                           ...
    'Location', 'N',                                         ...
    'Data', myDataN                                          ...
};

% Ensure that the Surface resource is valid
mySurf.validate();

example2 = steno3d.core.Project(                             ...
    'Title', 'Data: Example 2',                              ...
    'Resources', mySurf                                      ...
);
clear mySurf myDataCC myDataN ccValues nValues;

% Example 3:
% Initialize the same resources as Examples 1 and 2
myPoints = steno3d.core.Point;
myPoints.Mesh = steno3d.core.Mesh0D;
myPoints.Mesh.Vertices = rand(100, 3);
mySurf = steno3d.core.Surface;
mySurf.Mesh = steno3d.core.Mesh2DGrid;
mySurf.Mesh.H1 = ones(5, 1);
mySurf.Mesh.H2 = ones(10, 1);

% Use the steno3d.addData function to simplify adding data
steno3d.addData(myPoints, 'Random Point Data', rand(100, 1));
steno3d.addData(mySurf, 'Random Data 1', rand(5, 10));
steno3d.addData(mySurf, 'Random Data 2', rand(6, 11));

% Ensure the resources are valid
myPoints.validate();
mySurf.validate();

example3 = steno3d.core.Project(                             ...
    'Title', 'Data: Example 3',                              ...
    'Resources', {myPoints, mySurf}                          ...
);
clear myPoints mySurf;