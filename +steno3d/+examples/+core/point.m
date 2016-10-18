%Steno3D Point resource construction examples
%
%   Example 1:
%       >> % Create a basic Steno3D Point
%       >> pt = steno3d.core.Point;
%       >>
%       >> % A Point requires a Mesh0D with spatial vertices
%       >> verts = rand(100, 3);
%       >> mesh = steno3d.core.Mesh0D;
%       >> mesh.Vertices = verts;
%       >> pt.Mesh = mesh;
%       >>
%       >> % Ensure this Point is valid
%       >> pt.validate();
%       >>
%       >> % Add this Point to a Steno3D Project
%       >> example1 = steno3d.core.Project;
%       >> example1.Resources = pt;
%       >> example1.plot();
%       >> clear pt verts mesh
%
%   Example 2:
%       >> % Create a Steno3D Point with customized appearance
%       >> pt = steno3d.core.Point;
%       >> pt.Title = 'Example 2 Point';
%       >> pt.Description = 'This Point resource will be Yellow';
%       >>
%       >> % Give the Point a mesh
%       >> mesh = steno3d.core.Mesh0D;
%       >> mesh.Vertices = rand(100, 3);
%       >> pt.Mesh = mesh;
%       >>
%       >> % Set display options
%       >> pt.Opts.Color = 'y';
%       >> pt.Opts.Opacity = 0.75;
%       >>
%       >> % Ensure this Point is valid
%       >> pt.validate();
%       >> % Add this Point to a Steno3D Project
%       >> example2 = steno3d.core.Project;
%       >> example2.Title = 'Example 2';
%       >> example2.Description = 'Project with some points';
%       >> example2.Resources = pt;
%       >> example2.plot();
%       >> clear pt mesh
%
%   Example 3:
%       >> % Create a Steno3D Point with data.
%       >> % Note: This point constructor encapsulates all the features of
%       >> % pt from Example 2.
%       >> verts = rand(100, 3);
%       >> pt = steno3d.core.Point(                                     ...
%              'Title', 'Example 3 Point',                              ...
%              'Description', 'This Point resource will have data',     ...
%              'Mesh', steno3d.core.Mesh0D(                             ...
%                  'Vertices', verts                                    ...
%              ),                                                       ...
%              'Opts', {'Color', 'y', 'Opacity', 0.75}                  ...
%          );
%       >>
%       >> % Construct a DataArray
%       >> xdata = steno3d.core.DataArray(                              ...
%              'Title', 'X-Values',                                     ...
%              'Array', verts(:, 1)                                     ...
%          );
%       >> % Add the data to the Point resource. Location 'N' puts the data
%       >> % on the vertices.
%       >> pt.Data = {'Location', 'N', 'Data', xdata};
%       >>
%       >> % Ensure this Point is valid
%       >> pt.validate();
%       >> % Add this Point to a Steno3D Project
%       >> example3 = steno3d.core.Project(                             ...
%              'Title', 'Example 3',                                    ...
%              'Description', 'Project with some points',               ...
%              'Resources', pt                                          ...
%          );
%       >> example3.plot();
%       >> clear pt xdata verts
%
%   Example 4:
%       >> % Create a Steno3D Point with image projected onto it
%       >> pt = steno3d.core.Point(                                     ...
%              'Title', 'Example 4 Point',                              ...
%              'Description', 'This Point resource will have an image', ...
%              'Mesh', steno3d.core.Mesh0D(                             ...
%                  'Vertices', rand(100, 3)                             ...
%              ),                                                       ...
%              'Opts', {'Color', 'y', 'Opacity', 0.75}                  ...
%          );
%       >>
%       >> % Construct a Texture2DImage
%       >> pngFile = [tempname '.png'];
%       >> imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
%       >> tex = steno3d.core.Texture2DImage(                           ...
%              'Image', pngFile,                                        ...
%              'O', [0 0 0],                                            ...
%              'U', [1 0 0],                                            ...
%              'V', [0 1 0]                                             ...
%          );
%       >> % Add the image to the point
%       >> pt.Textures = tex;
%       >>
%       >> % Ensure this Point is valid
%       >> pt.validate();
%       >> % Add this Point to a Steno3D Project
%       >> example4 = steno3d.core.Project(                             ...
%              'Title', 'Example 4',                                    ...
%              'Description', 'Project with some points',               ...
%              'Resources', pt                                          ...
%          );
%       >> example4.plot();
%       >> clear pt tex pngFile
%
%   Example 5:
%       >> % Create a Steno3D Point with multiple datasets and textures.
%       >> % Note: There are several new features introduced in this highly
%       >> % consolidated construction. (1) Multiple datasets and textures
%       >> % are assigned as a cell array. (2) Passing cell arrays of
%       >> % parameters (e.g. for Mesh) implicitly calls the correct
%       >> % constructor. (3) Data Location is not specified since 'N' is
%       >> % the only available location for points. (4) The texture uses
%       >> % default values for O, U, and V, and attempts to coerce a JPG
%       >> % file to PNG.
%       >> verts = rand(100, 3);
%       >> pt = steno3d.core.Point(                                     ...
%              'Title', 'Example 5 Point',                              ...
%              'Description', 'This Point resource will have data',     ...
%              'Mesh', {'Vertices', verts},                             ...
%              'Opts', {'Color', 'y', 'Opacity', 0.75},                 ...
%              'Data', {                                                ...
%                  {'Data', {'Title', 'X-Data', 'Array', verts(:, 1)}}, ...
%                  {'Data', {'Title', 'Y-Data', 'Array', verts(:, 2)}}, ...
%                  {'Data', {'Title', 'Z-Data', 'Array', verts(:, 3)}}  ...
%              },                                                       ...
%              'Textures', {                                            ...
%                  {'Image', 'ngc6543a.jpg', 'U', [.5 0 0]},            ...
%                  {'Image', 'ngc6543a.jpg', 'V', [0 .5 0]}             ...
%              }                                                        ...
%          );
%       >>
%       >> % Ensure this Point is valid
%       >> pt.validate();
%       >> % Add this Point to a Steno3D Project
%       >> example5 = steno3d.core.Project(                             ...
%              'Title', 'Example 5',                                    ...
%              'Description', 'Project with some points',               ...
%              'Resources', pt                                          ...
%          );
%       >> example5.plot();
%       >> clear pt verts
%
%   You can <a href="matlab: steno3d.examples.core.point
%   ">click here</a> to run the above examples or type:
%       >> steno3d.examples.core.point
%   Then plot the projects with:
%       >> example1.plot(); % etc...
%
%   See also 
%
%  


% Example 1:
% Create a basic Steno3D Point
pt = steno3d.core.Point;

% A Point requires a Mesh0D with spatial vertices
verts = rand(100, 3);
mesh = steno3d.core.Mesh0D;
mesh.Vertices = verts;
pt.Mesh = mesh;

% Ensure this Point is valid
pt.validate();

% Add this Point to a Steno3D Project
example1 = steno3d.core.Project;
example1.Resources = pt;
example1.plot();
clear pt verts mesh

% Example 2:
% Create a Steno3D Point with customized appearance
pt = steno3d.core.Point;
pt.Title = 'Example 2 Point';
pt.Description = 'This Point resource will be Yellow';

% Give the Point a mesh
mesh = steno3d.core.Mesh0D;
mesh.Vertices = rand(100, 3);
pt.Mesh = mesh;

% Set display options
pt.Opts.Color = 'y';
pt.Opts.Opacity = 0.75;

% Ensure this Point is valid
pt.validate();
% Add this Point to a Steno3D Project
example2 = steno3d.core.Project;
example2.Title = 'Example 2';
example2.Description = 'Project with some points';
example2.Resources = pt;
example2.plot();
clear pt mesh

% Example 3:
% Create a Steno3D Point with data.
% Note: This point constructor encapsulates all the features of
% pt from Example 2.
verts = rand(100, 3);
pt = steno3d.core.Point(                                     ...
    'Title', 'Example 3 Point',                              ...
    'Description', 'This Point resource will have data',     ...
    'Mesh', steno3d.core.Mesh0D(                             ...
        'Vertices', verts                                    ...
    ),                                                       ...
    'Opts', {'Color', 'y', 'Opacity', 0.75}                  ...
);

% Construct a DataArray
xdata = steno3d.core.DataArray(                              ...
    'Title', 'X-Values',                                     ...
    'Array', verts(:, 1)                                     ...
);
% Add the data to the Point resource. Location 'N' puts the data
% on the vertices.
pt.Data = {'Location', 'N', 'Data', xdata};

% Ensure this Point is valid
pt.validate();
% Add this Point to a Steno3D Project
example3 = steno3d.core.Project(                             ...
    'Title', 'Example 3',                                    ...
    'Description', 'Project with some points',               ...
    'Resources', pt                                          ...
);
example3.plot();
clear pt xdata verts

% Example 4:
% Create a Steno3D Point with image projected onto it
pt = steno3d.core.Point(                                     ...
    'Title', 'Example 4 Point',                              ...
    'Description', 'This Point resource will have an image', ...
    'Mesh', steno3d.core.Mesh0D(                             ...
        'Vertices', rand(100, 3)                             ...
    ),                                                       ...
    'Opts', {'Color', 'y', 'Opacity', 0.75}                  ...
);

% Construct a Texture2DImage
pngFile = [tempname '.png'];
imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
tex = steno3d.core.Texture2DImage(                           ...
    'Image', pngFile,                                        ...
    'O', [0 0 0],                                            ...
    'U', [1 0 0],                                            ...
    'V', [0 1 0]                                             ...
);
% Add the image to the point
pt.Textures = tex;

% Ensure this Point is valid
pt.validate();
% Add this Point to a Steno3D Project
example4 = steno3d.core.Project(                             ...
    'Title', 'Example 4',                                    ...
    'Description', 'Project with some points',               ...
    'Resources', pt                                          ...
);
example4.plot();
clear pt tex pngFile

% Example 5:
% Create a Steno3D Point with multiple datasets and textures.
% Note: There are several new features introduced in this highly
% consolidated construction. (1) Multiple datasets and textures
% are assigned as a cell array. (2) Passing cell arrays of
% parameters (e.g. for Mesh) implicitly calls the correct
% constructor. (3) Data Location is not specified since 'N' is
% the only available option for points. (4) The texture uses
% default values for O, U, and V, and attempts to coerce a JPG
% file to PNG.
verts = rand(100, 3);
pt = steno3d.core.Point(                                     ...
    'Title', 'Example 5 Point',                              ...
    'Description', 'This Point resource will have data',     ...
    'Mesh', {'Vertices', verts},                             ...
    'Opts', {'Color', 'y', 'Opacity', 0.75},                 ...
    'Data', {                                                ...
        {'Data', {'Title', 'X-Data', 'Array', verts(:, 1)}}, ...
        {'Data', {'Title', 'Y-Data', 'Array', verts(:, 2)}}, ...
        {'Data', {'Title', 'Z-Data', 'Array', verts(:, 3)}}  ...
    },                                                       ...
    'Textures', {                                            ...
        {'Image', 'ngc6543a.jpg', 'U', [.5 0 0]},            ...
        {'Image', 'ngc6543a.jpg', 'V', [0 .5 0]}             ...
    }                                                        ...
);

% Ensure this Point is valid
pt.validate();
% Add this Point to a Steno3D Project
example5 = steno3d.core.Project(                             ...
    'Title', 'Example 5',                                    ...
    'Description', 'Project with some points',               ...
    'Resources', pt                                          ...
);
example5.plot();
clear pt verts