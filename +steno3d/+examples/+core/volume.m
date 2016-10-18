%Steno3D Volume resource construction examples
%
%   Example 1:
%       >> % Create a basic Steno3D Volume.
%       >> vol = steno3d.core.Volume;
%       >>
%       >> % A Volume requires a Mesh3DGrid with grid spacing
%       >> xspacing = ones(5, 1);
%       >> yspacing = ones(10, 1);
%       >> zspacing = ones(15, 1);
%       >> mesh = steno3d.core.Mesh3DGrid;
%       >> mesh.H1 = xspacing;
%       >> mesh.H2 = yspacing;
%       >> mesh.H3 = zspacing;
%       >> vol.Mesh = mesh;
%       >>
%       >> % Unlike other composite resources, Volumes require data.
%       >> % Construct a DataArray:
%       >> [x, ~, ~] = ndgrid(-2:2, -4.5:4.5, -7:7);
%       >> xdata = steno3d.core.DataArray;
%       >> xdata.Title = 'X Values';
%       >> xdata.Array = x(:);
%       >>
%       >> % Add the data to the Volume resource. Location 'CC' puts the
%       >> % data on the cell centers.
%       >> vol.Data = {'Location', 'CC', 'Data', xdata};
%       >>
%       >> % Ensure this Volume is valid
%       >> vol.validate();
%       >>
%       >> % Add this Volume to a Steno3D Project
%       >> example1 = steno3d.core.Project;
%       >> example1.Resources = vol;
%       >> example1.plot();
%       >> clear vol xspacing yspacing zspacing mesh xdata x
%
%   Example 2:
%       >> % Create a Steno3D Volume with customized appearance and offset.
%       >> vol = steno3d.core.Volume;
%       >> vol.Title = 'Example 2 Volume';
%       >> vol.Description = 'This Volume resource will be yellow';
%       >>
%       >> % Give the Volume a mesh
%       >> mesh = steno3d.core.Mesh3DGrid;
%       >> mesh.H1 = ones(5, 1);
%       >> mesh.H2 = ones(10, 1);
%       >> mesh.H3 = ones(15, 1);
%       >> mesh.O = [-2.5 -5 -7.5];
%       >> vol.Mesh = mesh;
%       >>
%       >> % Set display options
%       >> vol.Opts.Color = 'y';
%       >> vol.Opts.Opacity = 0.75;
%       >> vol.Mesh.Opts.Wireframe = true;
%       >>
%       >> % Add data
%       >> [x, ~, ~] = ndgrid(-2:2, -4.5:4.5, -7:7);
%       >> xdata = steno3d.core.DataArray;
%       >> xdata.Title = 'X Values';
%       >> xdata.Array = x(:);
%       >> vol.Data = {'Location', 'CC', 'Data', xdata};
%       >>
%       >> % Ensure this Volume is valid
%       >> vol.validate();
%       >> % Add this Volume to a Steno3D Project
%       >> example2 = steno3d.core.Project;
%       >> example2.Title = 'Example 2';
%       >> example2.Description = 'Project with a volume';
%       >> example2.Resources = vol;
%       >> example2.plot();
%       >> clear vol mesh xdata x
%
%   Example 3:
%       >> % Create a Steno3D Volume with data.
%       >> % Note: This Volume constructor encapsulates all the features of
%       >> % vol from Example 2.
%       >> vol = steno3d.core.Volume(                                   ...
%              'Title', 'Example 3 Volume',                             ...
%              'Description', 'This Volume resource will have data',    ...
%              'Mesh', steno3d.core.Mesh3DGrid(                         ...
%                  'H1', ones(5, 1),                                    ...
%                  'H2', ones(10, 1),                                   ...
%                  'H3', ones(15, 1),                                   ...
%                  'O', [-2.5 -5 -7.5],                                 ...
%                  'Opts', {'Wireframe', true}                          ...
%              ),                                                       ...
%              'Opts', {'Color', 'y', 'Opacity', 0.75}                  ...
%          );
%       >>
%       >> % Add data
%       >> [x, ~, ~] = ndgrid(-2:2, -4.5:4.5, -7:7);
%       >> xdata = steno3d.core.DataArray(                              ...
%              'Title', 'X Values',                                     ...
%              'Array', x(:)                                            ...
%          );
%       >> vol.Data = {'Location', 'CC', 'Data', xdata};
%       >>
%       >> % Ensure this Line is valid
%       >> vol.validate();
%       >> % Add this Line to a Steno3D Project
%       >> example3 = steno3d.core.Project(                             ...
%              'Title', 'Example 3',                                    ...
%              'Description', 'Project with a volume',                    ...
%              'Resources', vol                                         ...
%          );
%       >> example3.plot();
%       >> clear vol xdata x
%
%   Example 4:
%       >> % Create a Steno3D Volume with multiple datasets.
%       >> % Note: There are a couple new features introduced in this
%       >> % consolidated construction. (1) Multiple datasets are assigned
%       >> % as a cell array. (2) Passing cell arrays of parameters (e.g.
%       >> % for Mesh) implicitly calls the correct constructor. (3) Data
%       >> % Location is not specified since 'CC' is the only available
%       >> % location for volumes.
%       >> [x, y, z] = ndgrid(-2:2, -4.5:4.5, -7:7);
%       >> vol = steno3d.core.Volume(                                   ...
%              'Title', 'Example 4 Volume',                             ...
%              'Description', 'This Volume resource will have data',    ...
%              'Mesh', {'H1', ones(5, 1),                               ...
%                       'H2', ones(10, 1),                              ...
%                       'H3', ones(15, 1),                              ...
%                       'O', [-2.5 -5 -7.5],                            ...
%                       'Opts', {'Wireframe', true}},                   ...
%              'Opts', {'Color', 'y', 'Opacity', 0.75},                 ...
%              'Data', {                                                ...
%                  {'Data', {'Title', 'X Data', 'Array', x(:)}},        ...
%                  {'Data', {'Title', 'Y Data', 'Array', y(:)}},        ...
%                  {'Data', {'Title', 'Z Data', 'Array', z(:)}}         ...
%              }                                                        ...
%          );
%       >>
%       >> % Ensure this Volume is valid
%       >> vol.validate();
%       >> % Add this Volume to a Steno3D Project
%       >> example4 = steno3d.core.Project(                             ...
%              'Title', 'Example 4',                                    ...
%              'Description', 'Project with a volume',                  ...
%              'Resources', vol                                         ...
%          );
%       >> example4.plot();
%       >> clear vol x y z
%
%   You can <a href="matlab: steno3d.examples.core.vole
%   ">click here</a> to run the above examples or type:
%       >> steno3d.examples.core.vole
%   Then plot the projects with:
%       >> example1.plot(); % etc...
%
%   See also 
%
%  


% Example 1:
% Create a basic Steno3D Volume.
vol = steno3d.core.Volume;

% A Volume requires a Mesh3DGrid with grid spacing
xspacing = ones(5, 1);
yspacing = ones(10, 1);
zspacing = ones(15, 1);
mesh = steno3d.core.Mesh3DGrid;
mesh.H1 = xspacing;
mesh.H2 = yspacing;
mesh.H3 = zspacing;
vol.Mesh = mesh;

% Unlike other composite resources, Volumes require data.
% Construct a DataArray:
[x, ~, ~] = ndgrid(-2:2, -4.5:4.5, -7:7);
xdata = steno3d.core.DataArray;
xdata.Title = 'X Values';
xdata.Array = x(:);

% Add the data to the Volume resource. Location 'CC' puts the
% data on the cell centers.
vol.Data = {'Location', 'CC', 'Data', xdata};

% Ensure this Volume is valid
vol.validate();

% Add this Volume to a Steno3D Project
example1 = steno3d.core.Project;
example1.Resources = vol;
example1.plot();
clear vol xspacing yspacing zspacing mesh xdata x

% Example 2:
% Create a Steno3D Volume with customized appearance and offset.
vol = steno3d.core.Volume;
vol.Title = 'Example 2 Volume';
vol.Description = 'This Volume resource will be yellow';

% Give the Volume a mesh
mesh = steno3d.core.Mesh3DGrid;
mesh.H1 = ones(5, 1);
mesh.H2 = ones(10, 1);
mesh.H3 = ones(15, 1);
mesh.O = [-2.5 -5 -7.5];
vol.Mesh = mesh;

% Set display options
vol.Opts.Color = 'y';
vol.Opts.Opacity = 0.75;
vol.Mesh.Opts.Wireframe = true;

% Add data
[x, ~, ~] = ndgrid(-2:2, -4.5:4.5, -7:7);
xdata = steno3d.core.DataArray;
xdata.Title = 'X Values';
xdata.Array = x(:);
vol.Data = {'Location', 'CC', 'Data', xdata};

% Ensure this Volume is valid
vol.validate();
% Add this Volume to a Steno3D Project
example2 = steno3d.core.Project;
example2.Title = 'Example 2';
example2.Description = 'Project with a volume';
example2.Resources = vol;
example2.plot();
clear vol mesh xdata x

% Example 3:
% Create a Steno3D Volume with data.
% Note: This Volume constructor encapsulates all the features of
% vol from Example 2.
vol = steno3d.core.Volume(                                   ...
'Title', 'Example 3 Volume',                             ...
'Description', 'This Volume resource will have data',    ...
'Mesh', steno3d.core.Mesh3DGrid(                         ...
'H1', ones(5, 1),                                    ...
'H2', ones(10, 1),                                   ...
'H3', ones(15, 1),                                   ...
'O', [-2.5 -5 -7.5],                                 ...
'Opts', {'Wireframe', true}                          ...
),                                                       ...
'Opts', {'Color', 'y', 'Opacity', 0.75}                  ...
);

% Add data
[x, ~, ~] = ndgrid(-2:2, -4.5:4.5, -7:7);
xdata = steno3d.core.DataArray(                              ...
'Title', 'X Values',                                     ...
'Array', x(:)                                            ...
);
vol.Data = {'Location', 'CC', 'Data', xdata};

% Ensure this Line is valid
vol.validate();
% Add this Line to a Steno3D Project
example3 = steno3d.core.Project(                             ...
'Title', 'Example 3',                                    ...
'Description', 'Project with a volume',                    ...
'Resources', vol                                         ...
);
example3.plot();
clear vol xdata x

% Example 4:
% Create a Steno3D Volume with multiple datasets.
% Note: There are a couple new features introduced in this
% consolidated construction. (1) Multiple datasets are assigned
% as a cell array. (2) Passing cell arrays of parameters (e.g.
% for Mesh) implicitly calls the correct constructor. (3) Data
% Location is not specified since 'CC' is the only available
% location for volumes.
[x, y, z] = ndgrid(-2:2, -4.5:4.5, -7:7);
vol = steno3d.core.Volume(                                   ...
'Title', 'Example 4 Volume',                             ...
'Description', 'This Volume resource will have data',    ...
'Mesh', {'H1', ones(5, 1),                               ...
'H2', ones(10, 1),                              ...
'H3', ones(15, 1),                              ...
'O', [-2.5 -5 -7.5],                            ...
'Opts', {'Wireframe', true}},                   ...
'Opts', {'Color', 'y', 'Opacity', 0.75},                 ...
'Data', {                                                ...
{'Data', {'Title', 'X Data', 'Array', x(:)}},        ...
{'Data', {'Title', 'Y Data', 'Array', y(:)}},        ...
{'Data', {'Title', 'Z Data', 'Array', z(:)}}         ...
}                                                        ...
);

% Ensure this Volume is valid
vol.validate();
% Add this Volume to a Steno3D Project
example4 = steno3d.core.Project(                             ...
'Title', 'Example 4',                                    ...
'Description', 'Project with a volume',                  ...
'Resources', vol                                         ...
);
example4.plot();
clear vol x y z

