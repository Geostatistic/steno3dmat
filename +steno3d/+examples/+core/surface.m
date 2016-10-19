%Steno3D Surface resource construction examples
%
%   Example 1:
%       % Create a basic triangulated Steno3D Surface
%       sfc = steno3d.core.Surface;
%
%       % This Surface will use a Mesh2D, which requires vertices and
%       % triangle indices
%       verts = rand(100, 3);
%       tris = convhull(verts(:, 1), verts(:, 2), verts(:, 3));
%       mesh = steno3d.core.Mesh2D;
%       mesh.Vertices = verts;
%       mesh.Triangles = tris;
%       sfc.Mesh = mesh;
%
%       % Ensure this Surface is valid
%       sfc.validate();
%
%       % Add this Surface to a Steno3D Project
%       example1 = steno3d.core.Project;
%       example1.Resources = sfc;
%       example1.plot();
%       clear sfc tris verts mesh
%
%   Example 2:
%       % Create a basic grid Steno3D Surface with customized appearance
%       sfc = steno3d.core.Surface;
%       sfc.Title = 'Example 2 Grid';
%       sfc.Description = 'This Surface will be yellow';
%
%       % This Surface will use a Mesh2DGrid, which requires grid
%       % spacing and optional height data
%       heights = peaks(20);
%       mesh = steno3d.core.Mesh2DGrid;
%       mesh.H1 = ones(19, 1);
%       mesh.H2 = ones(19, 1);
%       mesh.Z = heights(:);
%       sfc.Mesh = mesh;
%
%       % Set display options
%       sfc.Opts.Color = 'y';
%       sfc.Opts.Opacity = 0.75;
%       sfc.Mesh.Opts.Wireframe = true;
%
%       % Ensure this Surface is valid
%       sfc.validate();
%       % Add this Surface to a Steno3D Project
%       example2 = steno3d.core.Project;
%       example2.Title = 'Example 2';
%       example2.Description = 'Project with a surface';
%       example2.Resources = sfc;
%       example2.plot();
%       clear sfc mesh heights
%
%   Example 3:
%       % Create a Steno3D Surface with data.
%       % Note: This surface constructor encapsulates all the features
%       % of sfc (and more) from Example 1.
%       v = rand(100, 3);
%       t = convhull(v(:, 1), v(:, 2), v(:, 3));
%       sfc = steno3d.core.Surface(                                  ...
%              'Title', 'Example 3 Surface',                            ...
%              'Description', 'This Surface resource will have data',   ...
%              'Mesh', steno3d.core.Mesh2D(                             ...
%                  'Vertices', v,                                       ...
%                  'Triangles', t,                                      ...
%                  'Opts', {'Wireframe', true}                          ...
%              ),                                                       ...
%              'Opts', {'Color', 'y', 'Opacity', 0.75}                  ...
%          );
%
%       % Construct a DataArray of triangle x-location
%       trixloc = mean(reshape(v(t, 1), size(t)), 2);
%       xdata = steno3d.core.DataArray(                              ...
%              'Title', 'X-Location',                                   ...
%              'Array', trixloc                                         ...
%          );
%       % Add the data to the Surface resource. Location 'CC' puts the
%       % data on the triangle faces.
%       sfc.Data = {'Location', 'CC', 'Data', xdata};
%
%       % Ensure this Point is valid
%       sfc.validate();
%       % Add this Surface to a Steno3D Project
%       example3 = steno3d.core.Project(                             ...
%              'Title', 'Example 3',                                    ...
%              'Description', 'Project with a surface',                 ...
%              'Resources', sfc                                         ...
%          );
%       example3.plot();
%       clear sfc xdata v t
%
%   Example 4:
%       % Create a Steno3D Surface with image projected onto it
%       v = rand(100, 3);
%       sfc = steno3d.core.Surface(                                  ...
%              'Title', 'Example 4 Surface',                            ...
%              'Description', 'This Surface resource has an image',     ...
%              'Mesh', steno3d.core.Mesh2D(                             ...
%                  'Vertices', v,                                       ...
%                  'Triangles', convhull(v(:, 1), v(:, 2), v(:, 3)),    ...
%                  'Opts', {'Wireframe', true}
%              ),                                                       ...
%              'Opts', {'Color', 'y'}                                   ...
%          );
%
%       % Construct a Texture2DImage
%       pngFile = [tempname '.png'];
%       imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
%       tex = steno3d.core.Texture2DImage(                           ...
%              'Image', pngFile,                                        ...
%              'O', [-1 -1 0],                                          ...
%              'U', [3 0 0],                                            ...
%              'V', [0 3 0]                                             ...
%          );
%       % Add the image to the Surface
%       sfc.Textures = tex;
%
%       % Ensure this Surface is valid
%       sfc.validate();
%       % Add this Surface to a Steno3D Project
%       example4 = steno3d.core.Project(                             ...
%              'Title', 'Example 4',                                    ...
%              'Description', 'Project with a surface',                 ...
%              'Resources', sfc                                         ...
%          );
%       example4.plot();
%       clear sfc tex pngFile v
%
%   Example 5:
%       % Create a Steno3D Surface with multiple datasets and textures.
%       % Note: There are several new features introduced in this highly
%       % consolidated construction. (1) Multiple datasets and textures
%       % are assigned as a cell array. (2) Passing cell arrays of
%       % parameters (e.g. for Mesh) implicitly calls the correct
%       % constructor. (3) Specifying O, U, and V in the Mesh2DGrid
%       % moves it away from the origin and rotates/skews the axes.
%       % (4) The texture attempts to coerce a JPG file to PNG.
%       pks = peaks(20);
%       sfc = steno3d.core.Surface(                                  ...
%              'Title', 'Example 5 Grid',                               ...
%              'Description', 'This Surface resource will have data',   ...
%              'Mesh', {                                                ...
%                  'H1', 2*ones(19, 1),                                 ...
%                  'H2', 3*ones(19, 1),                                 ...
%                  'O', [-19 0 -28.5],                                  ...
%                  'U', [1 0 0],                                        ...
%                  'V', [.5 0 sqrt(3)/2],                               ...
%                  'Z', pks(:)                                          ...
%              },                                                       ...
%              'Opts', {'Color', 'y', 'Opacity', 0.75},                 ...
%              'Data', {{                                               ...
%                  'Location', 'N',                                     ...
%                  'Data', {'Title', 'Peaks Data', 'Array', pks(:)}     ...
%              }, {                                                     ...
%                  'Location', 'CC',                                    ...
%                  'Data', {'Title', 'Random', 'Array', rand(19*19, 1)} ...
%              }},                                                      ...
%              'Textures', {{                                           ...
%                  'Title', 'Aligned image',                            ...
%                  'Image', 'ngc6543a.jpg',                             ...
%                  'U', 38*[1 0 0],                                     ...
%                  'V', 57*[.5 0 sqrt(3)/2],                            ...
%                  'O', [-19 0 -28.5]                                   ...
%              }, {                                                     ...
%                  'Title', 'Small square image',                       ...
%                  'Image', 'ngc6543a.jpg',                             ...
%                  'O', [-.5 0 -20],                                    ...
%                  'U', 'X',                                            ...
%                  'V', 'Z'                                             ...
%              }}                                                       ...
%          );
%
%       % Ensure this Surface is valid
%       sfc.validate();
%       % Add this Surface to a Steno3D Project
%       example5 = steno3d.core.Project(                             ...
%              'Title', 'Example 5',                                    ...
%              'Description', 'Project with a surface',                 ...
%              'Resources', sfc                                         ...
%          );
%       example5.plot();
%       clear sfc
%
%   You can <a href="matlab: steno3d.examples.core.surface
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.core.surface
%   Then plot the projects with:
%       example1.plot(); % etc...
%
%   See also
%


% Example 1:
% Create a basic triangulated Steno3D Surface
sfc = steno3d.core.Surface;

% This Surface will use a Mesh2D, which requires vertices and
% triangle indices
verts = rand(100, 3);
tris = convhull(verts(:, 1), verts(:, 2), verts(:, 3));
mesh = steno3d.core.Mesh2D;
mesh.Vertices = verts;
mesh.Triangles = tris;
sfc.Mesh = mesh;

% Ensure this Surface is valid
sfc.validate();

% Add this Surface to a Steno3D Project
example1 = steno3d.core.Project;
example1.Resources = sfc;
example1.plot();
clear sfc tris verts mesh

% Example 2:
% Create a basic grid Steno3D Surface with customized appearance
sfc = steno3d.core.Surface;
sfc.Title = 'Example 2 Grid';
sfc.Description = 'This Surface will be yellow';

% This Surface will use a Mesh2DGrid, which requires grid
% spacing and optional height data
heights = peaks(20);
mesh = steno3d.core.Mesh2DGrid;
mesh.H1 = ones(19, 1);
mesh.H2 = ones(19, 1);
mesh.Z = heights(:);
sfc.Mesh = mesh;

% Set display options
sfc.Opts.Color = 'y';
sfc.Opts.Opacity = 0.75;
sfc.Mesh.Opts.Wireframe = true;

% Ensure this Surface is valid
sfc.validate();
% Add this Surface to a Steno3D Project
example2 = steno3d.core.Project;
example2.Title = 'Example 2';
example2.Description = 'Project with a surface';
example2.Resources = sfc;
example2.plot();
clear sfc mesh heights

% Example 3:
% Create a Steno3D Surface with data.
% Note: This surface constructor encapsulates all the features
% of sfc (and more) from Example 1.
v = rand(100, 3);
t = convhull(v(:, 1), v(:, 2), v(:, 3));
sfc = steno3d.core.Surface(                                  ...
    'Title', 'Example 3 Surface',                            ...
    'Description', 'This Surface resource will have data',   ...
    'Mesh', steno3d.core.Mesh2D(                             ...
        'Vertices', v,                                       ...
        'Triangles', t,                                      ...
        'Opts', {'Wireframe', true}                          ...
    ),                                                       ...
    'Opts', {'Color', 'y', 'Opacity', 0.75}                  ...
);

% Construct a DataArray of triangle x-location
trixloc = mean(reshape(v(t, 1), size(t)), 2);
xdata = steno3d.core.DataArray(                              ...
    'Title', 'X-Location',                                   ...
    'Array', trixloc                                         ...
);
% Add the data to the Surface resource. Location 'CC' puts the
% data on the triangle faces.
sfc.Data = {'Location', 'CC', 'Data', xdata};

% Ensure this Point is valid
sfc.validate();
% Add this Surface to a Steno3D Project
example3 = steno3d.core.Project(                             ...
    'Title', 'Example 3',                                    ...
    'Description', 'Project with a surface',                 ...
    'Resources', sfc                                         ...
);
example3.plot();
clear sfc xdata v t

% Example 4:
% Create a Steno3D Surface with image projected onto it
v = rand(100, 3);
sfc = steno3d.core.Surface(                                  ...
    'Title', 'Example 4 Surface',                            ...
    'Description', 'This Surface resource has an image',     ...
    'Mesh', steno3d.core.Mesh2D(                             ...
        'Vertices', v,                                       ...
        'Triangles', convhull(v(:, 1), v(:, 2), v(:, 3)),    ...
        'Opts', {'Wireframe', true}                          ...
    ),                                                       ...
    'Opts', {'Color', 'y'}                                   ...
);

% Construct a Texture2DImage
pngFile = [tempname '.png'];
imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
tex = steno3d.core.Texture2DImage(                           ...
    'Image', pngFile,                                        ...
    'O', [-1 -1 0],                                          ...
    'U', [3 0 0],                                            ...
    'V', [0 3 0]                                             ...
);
% Add the image to the Surface
sfc.Textures = tex;

% Ensure this Surface is valid
sfc.validate();
% Add this Surface to a Steno3D Project
example4 = steno3d.core.Project(                             ...
    'Title', 'Example 4',                                    ...
    'Description', 'Project with a surface',                 ...
    'Resources', sfc                                         ...
);
example4.plot();
clear sfc tex pngFile v

% Example 5:
% Create a Steno3D Surface with multiple datasets and textures.
% Note: There are several new features introduced in this highly
% consolidated construction. (1) Multiple datasets and textures
% are assigned as a cell array. (2) Passing cell arrays of
% parameters (e.g. for Mesh) implicitly calls the correct
% constructor. (3) Specifying O, U, and V in the Mesh2DGrid
% moves it away from the origin and rotates/skews the axes.
% (4) The texture attempts to coerce a JPG file to PNG.
pks = peaks(20);
sfc = steno3d.core.Surface(                                  ...
'Title', 'Example 5 Grid',                               ...
'Description', 'This Surface resource will have data',   ...
'Mesh', {                                                ...
'H1', 2*ones(19, 1),                                 ...
'H2', 3*ones(19, 1),                                 ...
'O', [-19 0 -28.5],                                  ...
'U', [1 0 0],                                        ...
'V', [.5 0 sqrt(3)/2],                               ...
'Z', pks(:)                                          ...
},                                                       ...
'Opts', {'Color', 'y', 'Opacity', 0.75},                 ...
'Data', {{                                               ...
'Location', 'N',                                     ...
'Data', {'Title', 'Peaks Data', 'Array', pks(:)}  ...
}, {                                                     ...
'Location', 'CC',                                    ...
'Data', {'Title', 'Random', 'Array', rand(19*19, 1)} ...
}},                                                      ...
'Textures', {{                                           ...
'Title', 'Aligned image',                            ...
'Image', 'ngc6543a.jpg',                             ...
'U', 38*[1 0 0],                                     ...
'V', 57*[.5 0 sqrt(3)/2],                            ...
'O', [-19 0 -28.5]                                   ...
}, {                                                     ...
'Title', 'Small square image',                       ...
'Image', 'ngc6543a.jpg',                             ...
'O', [-.5 0 -20],                                    ...
'U', 'X',                                            ...
'V', 'Z'                                             ...
}}                                                       ...
);

% Ensure this Surface is valid
sfc.validate();
% Add this Surface to a Steno3D Project
example5 = steno3d.core.Project(                             ...
'Title', 'Example 5',                                    ...
'Description', 'Project with a surface',                 ...
'Resources', sfc                                         ...
);
example5.plot();
clear sfc
