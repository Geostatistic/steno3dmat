%Steno3D addImage examples
%
%   Example 1:
%       % Create a temporary PNG file
%       pngFile = [tempname '.png'];
%       imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
%       % Create a Project with a Point resource using scatter
%       [example1, pts] = steno3d.scatter(rand(1000, 3));
%       % Add the image to the points, projecting it from the top down
%       steno3d.addImage(pts, pngFile, 1, 1);
%       example1.plot();
%       clear pngFile pts
%
%   Example 2:
%       % Create a temporary PNG file
%       pngFile = [tempname '.png'];
%       imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
%       % Create a Project with a vertical Surface resource
%       [example2, sfc] = steno3d.surface(                          ...
%           'X', 0:.1:1, 'Z', 0:.1:1, [0 0 0]                        ...
%       );
%       % Add the image to the points, projecting it horizontally
%       steno3d.addImage(sfc, pngFile, 'X', .25, 'Z', .25);
%       % Add the image to the points with an offset
%       steno3d.addImage(sfc, pngFile, 'X', .25, 'Z', .25,          ...
%                        [.25 0 .25]);
%       % Add the image to the points with title, offset and reversed
%       steno3d.addImage(sfc, pngFile, [-1 0 0], .5, [0 0 -1], .5,   ...
%                        [1 0 1], 'Reversed Space Image');
%       example2.plot();
%       clear pngFile sfc
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
%       % Create a surface
%       verts = [x(:) y(:) z(:)];
%       tris = convhull(x(:), y(:), z(:));
%       [example3, sph] = steno3d.trisurf(tris, verts);
%       % Add the image
%       steno3d.addImage(sph, pngFile, 'X', 2, 'Z', 2, [-1 -1 -1],   ...
%                        'Hemisphere');
%       example3.plot();
%       clear x y z verts tris sph pngFile
%
%   You can <a href="matlab: steno3d.examples.image
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.image
%   Then plot the projects with:
%       example1.plot(); % etc...
%
%   See also steno3d.addImage, steno3d.core.Texture2DImage,
%   steno3d.scatter, steno3d.surface, steno3d.trisurf
%


% Example 1:
% Create a temporary PNG file
pngFile = [tempname '.png'];
imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
% Create a Project with a Point resource using scatter
[example1, pts] = steno3d.scatter(rand(1000, 3));
% Add the image to the points, projecting it from the top down
steno3d.addImage(pts, pngFile, 1, 1);
example1.plot();
clear pngFile pts

% Example 2:
% Create a temporary PNG file
pngFile = [tempname '.png'];
imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
% Create a Project with a vertical Surface resource
[example2, sfc] = steno3d.surface(                          ...
    'X', 0:.1:1, 'Z', 0:.1:1, [0 0 0]                        ...
);
% Add the image to the points, projecting it horizontally
steno3d.addImage(sfc, pngFile, 'X', .25, 'Z', .25);
% Add the image to the points with an offset
steno3d.addImage(sfc, pngFile, 'X', .25, 'Z', .25,          ...
                 [.25 0 .25]);
% Add the image to the points with title, offset and reversed
steno3d.addImage(sfc, pngFile, [-1 0 0], .5, [0 0 -1], .5,   ...
                 [1 0 1], 'Reversed Space Image');
example2.plot();
clear pngFile sfc

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

% Create a surface
verts = [x(:) y(:) z(:)];
tris = convhull(x(:), y(:), z(:));
[example3, sph] = steno3d.trisurf(tris, verts);
% Add the image
steno3d.addImage(sph, pngFile, 'X', 2, 'Z', 2, [-1 -1 -1],   ...
                 'Hemisphere');
example3.plot();
clear x y z verts tris sph pngFile
