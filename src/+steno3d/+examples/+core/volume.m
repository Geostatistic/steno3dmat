%Volume resource construction examples:
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso steno3d.core.Volume, steno3d.core.Mesh3DGrid, steno3d.core.DataArray, steno3d.core.Project
%


%   Example 1:  Create a Steno3D %%%ref[Volume](steno3d.core.Volume) resource with cell-centered %%%ref[data](steno3d.core.DataArray)
%
%   %%%note
%       Unlike other Steno3D resources, Volumes require data
vol = steno3d.core.Volume;
xspacing = ones(5, 1);
yspacing = ones(10, 1);
zspacing = ones(15, 1);
mesh = steno3d.core.Mesh3DGrid;
mesh.H1 = xspacing;
mesh.H2 = yspacing;
mesh.H3 = zspacing;
vol.Mesh = mesh;
[x, ~, ~] = ndgrid(-2:2, -4.5:4.5, -7:7);
xdata = steno3d.core.DataArray;
xdata.Title = 'X Values';
xdata.Array = x(:);
vol.Data = {'Location', 'CC', 'Data', xdata};
example1 = steno3d.core.Project;
example1.Resources = vol;
example1.plot;
clear vol xspacing yspacing zspacing mesh xdata x;

%%%image /images/core-volume-examples-images/core-volume-example1.png

%   Example 2: Create a Volume resource offset from zero and set options
vol = steno3d.core.Volume;
vol.Title = 'Example 2 Volume';
vol.Description = 'This Volume resource will be yellow';
mesh = steno3d.core.Mesh3DGrid;
mesh.H1 = ones(5, 1);
mesh.H2 = ones(10, 1);
mesh.H3 = ones(15, 1);
mesh.O = [-2.5 -5 -7.5];
vol.Mesh = mesh;
vol.Opts.Color = 'y';
vol.Opts.Opacity = 0.75;
vol.Mesh.Opts.Wireframe = true;
[x, ~, ~] = ndgrid(-2:2, -4.5:4.5, -7:7);
xdata = steno3d.core.DataArray;
xdata.Title = 'X Values';
xdata.Array = x(:);
vol.Data = {'Location', 'CC', 'Data', xdata};
example2 = steno3d.core.Project;
example2.Title = 'Example 2';
example2.Description = 'Project with a volume';
example2.Resources = vol;
example2.plot;
clear vol mesh xdata x;

%%%image /images/core-volume-examples-images/core-volume-example2.png

%   Example 3: Create a Volume resource in a more compact way
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
[x, ~, ~] = ndgrid(-2:2, -4.5:4.5, -7:7);
xdata = steno3d.core.DataArray(                              ...
    'Title', 'X Values',                                     ...
    'Array', x(:)                                            ...
);
vol.Data = {'Location', 'CC', 'Data', xdata};
example3 = steno3d.core.Project(                             ...
    'Title', 'Example 3',                                    ...
    'Description', 'Project with a volume',                  ...
    'Resources', vol                                         ...
);
example3.plot;
clear vol xdata x;

%%%image /images/core-volume-examples-images/core-volume-example3.png

%   Example 4: Create a Volume resource with multiple datasets
%
%   %%%note
%       There are a couple new features introduced in this
%       consolidated construction. (1) Multiple datasets are assigned
%       as a cell array. (2) Passing cell arrays of parameters (e.g.
%       for Mesh) implicitly calls the correct constructor. (3) Data
%       Location is not specified since 'CC' is the only available
%       location for volumes.
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
example4 = steno3d.core.Project(                             ...
    'Title', 'Example 4',                                    ...
    'Description', 'Project with a volume',                  ...
    'Resources', vol                                         ...
);
example4.plot;
clear vol x y z;

%%%image /images/core-volume-examples-images/core-volume-example4.png

