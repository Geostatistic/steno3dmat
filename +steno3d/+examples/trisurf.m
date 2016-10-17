%Steno3D trisurf plotting examples
%
%   Example 1:
%       >> % Create a Steno3D Project with triangulated Surface resource
%       >> x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
%       >> tris = convhull(x, y, z);
%       >> example1 = steno3d.trisurf(tris, x, y, z);
%       >> clear x y z
%
%   Example 2:
%       >> % Create Project and blue Surface from triangles and vertices
%       >> verts = rand(100, 3)-0.5;
%       >> tris = convhull(verts(:, 1), verts(:, 2), verts(:, 3));
%       >> example2 = steno3d.trisurf(tris, verts, 'b');
%
%   Example 3:
%       >> % Create Project and Surface with node and cell-center data
%       >> verts = rand(100, 3)-0.5;
%       >> tris = convhull(verts(:, 1), verts(:, 2), verts(:, 3));
%       >> example3 = steno3d.trisurf(tris, verts,                      ...
%              'Random Node Data', rand(size(verts, 1), 1),             ...
%              'Random Face Data', rand(size(tris, 1), 1)               ...
%          );
%
%   Example 4:
%       >> % Create Project and blue Surface from triangles and vertices
%       >> verts = rand(100, 3)-0.5;
%       >> tris = convhull(verts(:, 1), verts(:, 2), verts(:, 3));
%       >> [example4, mySurface] = steno3d.trisurf(tris, verts, 'b');
%       >> % Change properties of the Project and the Surface
%       >> example4.Title = 'Example 4 Project';
%       >> mySurface.Title = 'Blue Surface';
%       >> % Add another translucent yellow Surface around that surface
%       >> [~, mySurface] = steno3d.trisurf(example4, tris, verts*2, 'y');
%       >> mySurface.Opts.Opacity = 0.25;
%       >> example4.plot();
%       >> clear mySurface verts tris
%       >> % Note: mySurface is always accessable using:
%       >> example4.Resources{end};
%
%   You can <a href="matlab: steno3d.examples.trisurf
%   ">click here</a> to run the above examples or type:
%       >> steno3d.examples.trisurf
%   Then plot the projects with:
%       >> example1.plot(); % etc...
%
% Additional Examples:
%   <a href="matlab: help steno3d.examples.core.surface
%   ">surface resources</a>, <a href="matlab:
%   help steno3d.examples.core.project
%   ">projects</a>, <a href="matlab: help steno3d.examples.upload
%   ">uploading</a>, <a href="matlab: help steno3d.examples.plotting
%   ">other plotting functions</a>
%
%   See also steno3d.trisurf, steno3d.core.Surface, steno3d.core.Project
%
% Steno3D trisurf plotting examples

% Example 1:
% Create a Steno3D Project with triangulated Surface resource
x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
tris = convhull(x, y, z);
example1 = steno3d.trisurf(tris, x, y, z);
clear x y z

% Example 2:
% Create Project and blue Surface from triangles and vertices
verts = rand(100, 3)-0.5;
tris = convhull(verts(:, 1), verts(:, 2), verts(:, 3));
example2 = steno3d.trisurf(tris, verts, 'b');

% Example 3:
% Create Project and Surface with node and cell-center data
verts = rand(100, 3)-0.5;
tris = convhull(verts(:, 1), verts(:, 2), verts(:, 3));
example3 = steno3d.trisurf(tris, verts,                      ...
    'Random Node Data', rand(size(verts, 1), 1),             ...
    'Random Face Data', rand(size(tris, 1), 1)               ...
);

% Example 4:
% Create Project and blue Surface from triangles and vertices
verts = rand(100, 3)-0.5;
tris = convhull(verts(:, 1), verts(:, 2), verts(:, 3));
[example4, mySurface] = steno3d.trisurf(tris, verts, 'b');
% Change properties of the Project and the Surface
example4.Title = 'Example 4 Project';
mySurface.Title = 'Blue Surface';
% Add another translucent yellow Surface around that surface
[~, mySurface] = steno3d.trisurf(example4, tris, verts*2, 'y');
mySurface.Opts.Opacity = 0.25;
example4.plot();
clear mySurface verts tris
% Note: mySurface is always accessable using:
example4.Resources{end};