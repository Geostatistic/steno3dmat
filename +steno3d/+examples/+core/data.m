%Steno3D DataArray construction examples
%
%   Example 1:
%       % Initialize a Steno3D Point resource
%       myPoints = steno3d.core.Point;
%       myPoints.Mesh = steno3d.core.Mesh0D;
%       myPoints.Mesh.Vertices = rand(100, 3);
%
%       % Create a DataArray the same length as the Vertices
%       myData = steno3d.core.DataArray;
%       myData.Title = 'Random Point Data';
%       myData.Array = rand(100, 1);
%
%       % Bind the data to the Point resource
%       % Location must be specified; for points, the only available
%       % option is 'N' (nodes)
%       myPoints.Data = {                                            ...
%           'Location', 'N',                                         ...
%           'Data', myData                                           ...
%       };
%
%       % Ensure that the Point resource is valid
%       myPoints.validate();
%
%       % Pack this example into a project
%       example1 = steno3d.core.Project(                             ...
%           'Title', 'Data: Example 1',                              ...
%           'Resources', myPoints                                    ...
%       );
%       clear myPoints myData
%
%   Example 2:
%       % Initialize a Steno3D Surface resource
%       mySurf = steno3d.core.Surface;
%       mySurf.Mesh = steno3d.core.Mesh2DGrid;
%       mySurf.Mesh.H1 = ones(5, 1);
%       mySurf.Mesh.H2 = ones(10, 1);
%
%       % Create a DataArray the same size as the cell centers
%       ccValues = rand(5, 10);
%       myDataCC = steno3d.core.DataArray;
%       myDataCC.Title = 'Random Cell-Centered Data';
%       myDataCC.Array = ccValues(:);
%
%       % Create a DataArray the same size as the nodes
%       nValues = rand(6, 11);
%       myDataN = steno3d.core.DataArray;
%       myDataN.Title = 'Random Node Data';
%       myDataN.Array = nValues(:);
%
%       % Bind the data sets to their respective Surface locations
%       mySurf.Data{1} = {                                           ...
%           'Location', 'CC',                                        ...
%           'Data', myDataCC                                         ...
%       };
%       mySurf.Data{2} = {                                           ...
%           'Location', 'N',                                         ...
%           'Data', myDataN                                          ...
%       };
%
%       % Ensure that the Surface resource is valid
%       mySurf.validate();
%
%       % Pack this example into a project
%       example2 = steno3d.core.Project(                             ...
%           'Title', 'Data: Example 2',                              ...
%           'Resources', mySurf                                      ...
%       );
%       clear mySurf myDataCC myDataN ccValues nValues
%
%   You can <a href="matlab: steno3d.examples.core.data
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.core.data
%   Then plot the projects with:
%       example1.plot(); % etc...
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

% Create a DataArray the same length as the Vertices
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

% Pack this example into a project
example1 = steno3d.core.Project(                             ...
    'Title', 'Data: Example 1',                              ...
    'Resources', myPoints                                    ...
);
clear myPoints myData

% Example 2:
% Initialize a Steno3D Surface resource
mySurf = steno3d.core.Surface;
mySurf.Mesh = steno3d.core.Mesh2DGrid;
mySurf.Mesh.H1 = ones(5, 1);
mySurf.Mesh.H2 = ones(10, 1);

% Create a DataArray the same size as the cell centers
ccValues = rand(5, 10);
myDataCC = steno3d.core.DataArray;
myDataCC.Title = 'Random Cell-Centered Data';
myDataCC.Array = ccValues(:);

% Create a DataArray the same size as the nodes
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

% Pack this example into a project
example2 = steno3d.core.Project(                             ...
    'Title', 'Data: Example 2',                              ...
    'Resources', mySurf                                      ...
);
clear mySurf myDataCC myDataN ccValues nValues

