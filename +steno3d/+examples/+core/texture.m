%Steno3D Texture2DImage construction examples
%
%   Example 1:
%       % Initialize a Steno3D Surface resource
%       mySurf = steno3d.core.Surface;
%       mySurf.Mesh = {'H1', ones(10, 1), 'H2', ones(10, 1)};
%
%       % Create a Texture2DImage the same size as the Surface
%       myTex = steno3d.core.Texture2DImage;
%       myTex.U = [10 0 0];
%       myTex.V = [0 10 0];
%       % Make a PNG image for the texture
%       pngFile = [tempname '.png'];
%       imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
%       myTex.Image = pngFile;
%
%       % Add the texture to the Surface resource
%       mySurf.Textures = myTex;
%
%       % Pack this example into a project
%       example1 = steno3d.core.Project(                             ...
%              'Title', 'Textures: Example 1',                          ...
%              'Resources', mySurf                                      ...
%          );
%       clear mySurf myTex pngFile
%
%   Example 2:
%       % Initialize a Steno3D Point resource
%       myPoint = steno3d.core.Point(                                ...
%              'Mesh', {'Vertices', rand(1000, 3)}                      ...
%          );
%
%       % Create a Texture2DImage to project onto the points. This
%       % texture is projected perpendicular to the X-Z plane. Also, a
%       % JPG image is used; Texture2DImage attempts to coerce this to a
%       % PNG.
%       myPoint.Textures = steno3d.core.Texture2DImage(              ...
%              'U', 'X',                                                ...
%              'V', 'Z',                                                ...
%              'Image', 'ngc6543a.jpg'                                  ...
%          );
%       % Give the Point resource an additional texture. This texture is
%       % defined with skewed axes and an offset origin; it is projected
%       % onto the points perpendicular to the defined face (in the
%       % U-cross-V direction).
%       myPoint.Textures{end+1} = steno3d.core.Texture2DImage(       ...
%              'O', [.25 .25 .25],                                      ...
%              'U', [.4 0 -.3],                                         ...
%              'V', [.1 .2 .5],                                         ...
%              'Image', 'ngc6543a.jpg'                                  ...
%          );
%
%       % Pack this example into a project
%       example2 = steno3d.core.Project(                             ...
%              'Title', 'Textures: Example 2',                          ...
%              'Resources', myPoint                                     ...
%          );
%       clear myPoint
%
%   Example 3:
%       % Create a temporary PNG file
%       fig = figure; [x, y, z] = sphere; surf(x, y, z);
%       h = findobj('Type', 'surface');
%       load earth; hemisphere = [ones(257,125),X,ones(257,125)];
%       set(h,'CData',flipud(hemisphere),'FaceColor','texturemap');
%       colormap(map); axis equal; view([90 0]);
%       fig.Position = [fig.Position(1:3) fig.Position(3)];
%       ax = gca; ax.Position = [0 0 1 1];
%       pngFile = [tempname '.png'];
%       print(fig, '-dpng', pngFile);
%       close(fig)
%       clear map X h hemisphere fig ax
%
%       % Create a surface. Here the Texture2DImage constructor is
%       % called implicitly by providing a cell array of input
%       % parameters.
%       mySurf = steno3d.core.Surface(                               ...
%              'Title', 'Hemisphere',                                   ...
%              'Mesh', {                                                ...
%                  'Triangles', convhull(x(:), y(:), z(:)),             ...
%                  'Vertices', [x(:) y(:) z(:)]                         ...
%              },                                                       ...
%              'Textures', {                                            ...
%                  'O', [-1 -1 -1],                                     ...
%                  'U', [2 0 0],                                        ...
%                  'V', [0 0 2],                                        ...
%                  'Image', pngFile                                     ...
%              }                                                        ...
%          );
%
%       % Pack this example into a project
%       example3 = steno3d.core.Project(                             ...
%              'Title', 'Textures: Example 3',                          ...
%              'Resources', mySurf                                      ...
%          );
%       clear mySurf x y z pngFile
%
%   You can <a href="matlab: steno3d.examples.core.texture
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.core.texture
%   Then plot the projects with:
%       example1.plot(); % etc...
%
%   See also
%


% Example 1:
% Initialize a Steno3D Surface resource
mySurf = steno3d.core.Surface;
mySurf.Mesh = {'H1', ones(10, 1), 'H2', ones(10, 1)};

% Create a Texture2DImage the same size as the Surface
myTex = steno3d.core.Texture2DImage;
myTex.U = [10 0 0];
myTex.V = [0 10 0];
% Make a PNG image for the texture
pngFile = [tempname '.png'];
imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
myTex.Image = pngFile;

% Add the texture to the Surface resource
mySurf.Textures = myTex;

% Pack this example into a project
example1 = steno3d.core.Project(                             ...
    'Title', 'Textures: Example 1',                          ...
    'Resources', mySurf                                      ...
);
clear mySurf myTex pngFile

% Example 2:
% Initialize a Steno3D Point resource
myPoint = steno3d.core.Point(                                ...
    'Mesh', {'Vertices', rand(1000, 3)}                      ...
);

% Create a Texture2DImage to project onto the points. This
% texture is projected perpendicular to the X-Z plane. Also, a
% JPG image is used; Texture2DImage attempts to coerce this to a
% PNG.
myPoint.Textures = steno3d.core.Texture2DImage(              ...
    'U', 'X',                                                ...
    'V', 'Z',                                                ...
    'Image', 'ngc6543a.jpg'                                  ...
);
% Give the Point resource an additional texture. This texture is
% defined with skewed axes and an offset origin; it is projected
% onto the points perpendicular to the defined face (in the
% U-cross-V direction).
myPoint.Textures{end+1} = steno3d.core.Texture2DImage(       ...
    'O', [.25 .25 .25],                                      ...
    'U', [.4 0 -.3],                                         ...
    'V', [.1 .2 .5],                                         ...
    'Image', 'ngc6543a.jpg'                                  ...
);

% Pack this example into a project
example2 = steno3d.core.Project(                             ...
    'Title', 'Textures: Example 2',                          ...
    'Resources', myPoint                                     ...
);
clear myPoint

% Example 3:
% Create a temporary PNG file
fig = figure; [x, y, z] = sphere; surf(x, y, z);
h = findobj('Type', 'surface');
load earth; hemisphere = [ones(257,125),X,ones(257,125)];
set(h,'CData',flipud(hemisphere),'FaceColor','texturemap');
colormap(map); axis equal; view([90 0]);
fig.Position = [fig.Position(1:3) fig.Position(3)];
ax = gca; ax.Position = [0 0 1 1];
pngFile = [tempname '.png'];
print(fig, '-dpng', pngFile);
close(fig)
clear map X h hemisphere fig ax

% Create a surface. Here the Texture2DImage constructor is
% called implicitly by providing a cell array of input
% parameters.
mySurf = steno3d.core.Surface(                               ...
    'Title', 'Hemisphere',                                   ...
    'Mesh', {                                                ...
        'Triangles', convhull(x(:), y(:), z(:)),             ...
        'Vertices', [x(:) y(:) z(:)]                         ...
    },                                                       ...
    'Textures', {                                            ...
        'O', [-1 -1 -1],                                     ...
        'U', [2 0 0],                                        ...
        'V', [0 0 2],                                        ...
        'Image', pngFile                                     ...
    }                                                        ...
);

% Pack this example into a project
example3 = steno3d.core.Project(                             ...
    'Title', 'Textures: Example 3',                          ...
    'Resources', mySurf                                      ...
);
clear mySurf x y z pngFile
