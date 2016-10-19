%Steno3D surface plotting examples
%
%   Example 1:
%       % Create Steno3D Project with Surface resource from matrix Z
%       Z = peaks(20);
%       example1 = steno3d.surface(Z);
%
%   Example 2:
%       % Create Project with red Surface offset from origin
%       Z = peaks(20);
%       example2 = steno3d.surface([100 100 100], Z, 'r');
%
%   Example 3:
%       % Create Project with flat surface with irregular spacing
%       example3 = steno3d.surface([0:5:25 26:74 75:5:100],          ...
%                                     [25:2:45 46:54 55:2:75]);
%       % Add another vertical, angled Surface resource to that project
%       steno3d.surface(                                             ...
%              example3, 'Z', [0:10], [0.3 1 0], [0:100], [0 0 5]       ...
%          );
%
%   Example 4:
%       % Create Project with vertical surface and Peaks topography
%       Z = peaks(20);
%       example4 = steno3d.surface('X', [0:2:10 11:18 19:2:29],      ...
%                                     'Z', [0:2:10 11:18 10:2:29],      ...
%                                     [0 0 0], Z);
%
%   Example 5:
%       % Add node data, cell-center data, and an image to the surface
%       Z = peaks(20);
%       pngFile = [tempname '.png'];
%       imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
%       [example5, mySurface] = steno3d.surface(                     ...
%              1:5:100, 1:5:100, Z,                                     ...
%              'Random Vertex Data', rand(20),                          ...
%              'Random Face Data', rand(19),                            ...
%              'Space Image', pngFile                                   ...
%          );
%       % Change properties of the Project and the Surface
%       example5.Title = 'Example 5 Project';
%       mySurface.Title = 'Peaks, Data, and Space';
%       mySurface.Mesh.Opts.Wireframe = true;
%       example5.plot();
%       clear mySurface Z pngFile
%       % Note: mySurface is always accessable using:
%       example5.Resources{1};
%
%   You can <a href="matlab: steno3d.examples.surface
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.surface
%   Then plot the projects with:
%       example1.plot(); % etc...
%
% Additional Examples:
%   <a href="matlab: help steno3d.examples.core.surface
%   ">surface resources</a>, <a href="matlab:
%   help steno3d.examples.core.project
%   ">projects</a>, <a href="matlab: help steno3d.examples.upload
%   ">uploading</a>, <a href="matlab: help steno3d.examples.plotting
%   ">other plotting functions</a>
%
%   See also steno3d.surface, steno3d.core.Surface, steno3d.core.Project
%


% Example 1:
% Create Steno3D Project with Surface resource from matrix Z
Z = peaks(20);
example1 = steno3d.surface(Z);

% Example 2:
% Create Project with red Surface offset from origin
Z = peaks(20);
example2 = steno3d.surface([100 100 100], Z, 'r');

% Example 3:
% Create Project with flat surface with irregular spacing
example3 = steno3d.surface([0:5:25 26:74 75:5:100],          ...
[25:2:45 46:54 55:2:75]);
% Add another vertical, angled Surface resource to that project
steno3d.surface(                                             ...
    example3, 'Z', [0:10], [0.3 1 0], [0:100], [0 0 5]       ...
);

% Example 4:
% Create Project with vertical surface and Peaks topography
Z = peaks(20);
example4 = steno3d.surface('X', [0:2:10 11:18 19:2:29],      ...
                           'Z', [0:2:10 11:18 19:2:29],      ...
                           [0 0 0], Z);

% Example 5:
% Add node data, cell-center data, and an image to the surface
Z = peaks(20);
pngFile = [tempname '.png'];
imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
[example5, mySurface] = steno3d.surface(                     ...
    1:5:100, 1:5:100, Z,                                     ...
    'Random Vertex Data', rand(20),                          ...
    'Random Face Data', rand(19),                            ...
    'Space Image', pngFile                                   ...
);
% Change properties of the Project and the Surface
example5.Title = 'Example 5 Project';
mySurface.Title = 'Peaks, Data, and Space';
mySurface.Mesh.Opts.Wireframe = true;
example5.plot();
clear mySurface Z pngFile
% Note: mySurface is always accessable using:
example5.Resources{1};
