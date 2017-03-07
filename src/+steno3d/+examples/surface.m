%Steno3D surface plotting examples
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso STENO3D.SURFACE, STENO3D.CORE.SURFACE, STENO3D.CORE.PROJECT
%


%Example 1: Create Steno3D %%%ref[Project](steno3d.core.Project) with %%%ref[Surface](steno3d.core.Surface) resource from matrix Z
Z = peaks(20);
example1 = steno3d.surface(Z);

%Example 2: Create Project with red Surface offset from origin
Z = peaks(20);
example2 = steno3d.surface([100 100 100], Z, 'r');

%Example 3: Create Project with irregular-spaced and angled Surfaces
example3 = steno3d.surface([0:5:25 26:74 75:5:100],          ...
                           [25:2:45 46:54 55:2:75]);
steno3d.surface(                                             ...
    example3, 'Z', [0:10], [0.3 1 0], [0:100], [0 0 5]       ...
);

%Example 4: Create Project with vertical Surface and Peaks topography
Z = peaks(20);
example4 = steno3d.surface('X', [0:2:10 11:18 19:2:29],      ...
                           'Z', [0:2:10 11:18 19:2:29],      ...
                           [0 0 0], Z);

%Example 5: Add node data, cell-center data, and an image to the Surface
Z = peaks(20);
pngFile = [tempname '.png'];
imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
[example5, mySurface] = steno3d.surface(                     ...
    1:5:100, 1:5:100, Z,                                     ...
    'Random Vertex Data', rand(20),                          ...
    'Random Face Data', rand(19),                            ...
    'Space Image', pngFile                                   ...
);
example5.Title = 'Example 5 Project';
mySurface.Title = 'Peaks, Data, and Space';
mySurface.Mesh.Opts.Wireframe = true;
example5.plot();
clear mySurface Z pngFile
