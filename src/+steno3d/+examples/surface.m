%surface plotting examples:
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso steno3d.surface, steno3d.core.Surface, steno3d.core.Project
%


%   Example 1: Create Steno3D %%%ref[Project](steno3d.core.Project) with %%%ref[Surface](steno3d.core.Surface) resource from matrix Z
Z = peaks(20);
example1 = steno3d.surface(Z);

%%%image /images/surface-examples-images/surface-example-1.png

%   Example 2: Create a red Surface (same surface resource in example1) with an offset of [100 100 100] from origin
Z = peaks(20);
example2 = steno3d.surface([100 100 100], Z, 'r');

%%%image /images/surface-examples-images/surface-example-2.png

%   Example 3: Add an angled Surface to an existing Steno3D project (irregular-spaced surface)
example3 = steno3d.surface([0:5:25 26:74 75:5:100],          ...
                           [25:2:45 46:54 55:2:75]);
steno3d.surface(                                             ...
    example3, 'Z', [0:10], [0.3 1 0], [0:100], [0 0 5]       ...
);

%%%image /images/surface-examples-images/surface-example-3.png

%   Example 4: Create Project with vertical Surface and Peaks topography
Z = peaks(20);
example4 = steno3d.surface('X', [0:2:10 11:18 19:2:29],      ...
                           'Z', [0:2:10 11:18 19:2:29],      ...
                           [0 0 0], Z);
                       
%%%image /images/surface-examples-images/surface-example-4.png


%   Example 5: Add node data, cell-center data, and an image to the Surface
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
example5.upload();
clear mySurface Z pngFile

%%%image /images/surface-examples-images/surface-example-5.png
