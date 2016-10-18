%Steno3D addData examples
%
%   Example 1:
%       >> % Initialize a Project with red Points using scatter
%       >> coords = rand(100, 3);
%       >> example1 = steno3d.scatter(coords, 'r');
%       >>
%       >> % Add random data to the Points (the first Project resource)
%       >> steno3d.addData(example1.Resources{1}, 'X Data', coords(:, 1));
%       >> example1.plot();
%       >> clear coords
%
%   Example 2:
%       >> % Initialize a Project with a peaks Surface
%       >> [example2, pks] = steno3d.surface(peaks(20));
%       >> % This grid is 20 x 20 edges, 19 x 19 faces
%       >>
%       >> % Add untitled node data from a matrix
%       >> steno3d.addData(pks, rand(20));
%       >> % Add titled node data from an array
%       >> steno3d.addData(pks, 'Random Node Data', rand(400, 1));
%       >> % Add untitled face data from a matrix
%       >> steno3d.addData(pks, rand(19));
%       >> % Add titled face data from an array
%       >> steno3d.addData(pks, rand(361, 1));
%       >>
%       >> % example2 now has a Surface resource with 4 datasets
%       >> example2.plot();
%       >> clear pks
%
%   You can <a href="matlab: steno3d.examples.data
%   ">click here</a> to run the above examples or type:
%       >> steno3d.examples.data
%   Then plot the projects with:
%       >> example1.plot(); % etc...
%
%   See also steno3d.addData, steno3d.core.DataArray, steno3d.core.binders,
%   steno3d.scatter, steno3d.surface
%


% Example 1:
% Initialize a Project with red Points using scatter
coords = rand(100, 3);
example1 = steno3d.scatter(coords, 'r');

% Add random data to the Points (the first Project resource)
steno3d.addData(example1.Resources{1}, 'X Data', coords(:, 1));
example1.plot();
clear coords

% Example 2:
% Initialize a Project with a peaks Surface
[example2, pks] = steno3d.surface(peaks(20));
% This grid is 20 x 20 edges, 19 x 19 faces

% Add untitled node data from a matrix
steno3d.addData(pks, rand(20));
% Add titled node data from an array
steno3d.addData(pks, 'Random Node Data', rand(400, 1));
% Add untitled face data from a matrix
steno3d.addData(pks, rand(19));
% Add titled face data from an array
steno3d.addData(pks, rand(361, 1));

% example2 now has a Surface resource with 4 datasets
example2.plot();
clear pks
