%scatter plotting examples:
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso steno3d.scatter, steno3d.core.Point, steno3d.core.Project
%

%   Example 1: Create a Steno3D %%%ref[Project](steno3d.core.Project) Project with a %%%ref[Point](steno3d.core.Point) resource defined by n x 3 matrix
x = 0:pi/10:4*pi;
example1 = steno3d.scatter([x(:) cos(x(:)+0.2) sin(x(:))]);

%   Example 2: Create Project with a red Point resource defined by equal-sized vectors x, y,and z
x = 0:pi/10:4*pi;
example2 = steno3d.scatter([x(:), cos(x(:)+0.2), sin(x(:))], 'r');

%%%image /images/scatter-examples-images/scatter-example-2.png

%   Example 3: Create Project with 2 titled datasets added to a Point resource 
x = 0:pi/10:4*pi;
example3 = steno3d.scatter(                                  ...
    x(:), cos(x(:)+0.2), sin(x(:)),                          ...
    'Cosine Data', cos(x(:)), 'Sine Data', sin(x(:))         ...
);

%   Example 4: Add a point resource with a titled dataset to an existing steno3D project (example3)
steno3d.scatter(                                             ...
    example3, [x(:)+5*pi cos(x(:)+0.2) sin(x(:))],           ...
    'Arctangent Data', atan(x(:))                            ...
);

%   Example 5: Return handle to Project and Point resource for editing
x = 0:pi/10:4*pi;
[example5, myPoints] = steno3d.scatter(x(:), cos(x(:)+0.2),  ...
                                       sin(x(:)), 'turquoise');
example5.Title = 'Example 4 Project';
myPoints.Title = 'Turquoise Scatter';
myPoints.Opts.Opacity = .75;
example5.plot();
clear myPoints x


x = 0:pi/10:4*pi;
[myProject, myPoints] = steno3d.scatter(                        ...
    [x(:) cos(x(:)+0.2) sin(x(:))], [0 .5 .5],                  ...
    'Random Data', rand(size(x))                                ...
);
myPoints.Title = 'Example Points';
myPoints.Description = 'Trig functions with random data';
myProject.Title = 'Project with one set of Points';
myProject.Public = true;
steno3d.upload(myProject);
