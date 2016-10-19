%Steno3D addData examples
%
%   Example 1: Create a <a href="matlab: help steno3d.core.Point
%   ">Point</a> resource and add untitled x-coordinate data
%       coords = rand(100, 3);
%       [example1, pts] = steno3d.scatter(coords, 'r');
%       steno3d.addData(pts, coords(:, 1));
%       clear coords pts;
%
%   Example 2: Create a <a href="matlab: help steno3d.core.Surface
%   ">Surface</a> and add random face data
%       x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
%       tris = convhull(x, y, z);
%       example2 = steno3d.trisurf(tris, x, y, z, 'r');
%       steno3d.addData(example2.Resources{1}, 'Face Data', rand(4, 1));
%       clear x y z tris;
%
%   Example 3: Create a grid Surface and add four datasets
%       [example3, pks] = steno3d.surface(peaks(20));
%       % Note: pks is a grid with 20x20 edges and 19x19 faces. Data of
%       % several different sizes can be added
%       steno3d.addData(pks, 'Node Data from Matrix', rand(20, 20));
%       steno3d.addData(pks, 'Node Data from Array', rand(20*20, 1));
%       steno3d.addData(pks, 'Face Data from Matrix', rand(19, 19));
%       steno3d.addData(pks, 'Face Data from Array', rand(19*19, 1));
%       clear pks;
%
%   You can <a href="matlab: steno3d.examples.adddata
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.adddata
%   Then plot the projects with:
%       example1.plot(); % etc...
%
%
%   See also STENO3D.ADDDATA, STENO3D.SCATTER, STENO3D.TRISURF,
%   STENO3D.SURFACE
%


% Example 1: Create a Point resource and add untitled x-coordinate data
coords = rand(100, 3);
[example1, pts] = steno3d.scatter(coords, 'r');
steno3d.addData(pts, coords(:, 1));
clear coords pts

% Example 2: Create a Surface and add random face data
x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
tris = convhull(x, y, z);
example2 = steno3d.trisurf(tris, x, y, z, 'r');
steno3d.addData(example2.Resources{1}, 'Face Data', rand(4, 1));
clear x y z tris

% Example 3: Create a grid Surface and add four datasets
[example3, pks] = steno3d.surface(peaks(20));
% Note: pks is a grid with 20x20 edges and 19x19 faces. Data of
% several different sizes can be added
steno3d.addData(pks, 'Node Data from Matrix', rand(20, 20));
steno3d.addData(pks, 'Node Data from Array', rand(20*20, 1));
steno3d.addData(pks, 'Face Data from Matrix', rand(19, 19));
steno3d.addData(pks, 'Face Data from Array', rand(19*19, 1));
clear pks