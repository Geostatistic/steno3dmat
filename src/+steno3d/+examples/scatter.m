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

%%%image /images/scatter-examples-images/scatter-example-1.png

%   Example 2: Create Project with a blue Point resource defined by equal-sized vectors x, y,and z
x = 0:pi/10:4*pi;
example2 = steno3d.scatter([x(:), cos(x(:)+0.2), sin(x(:))], 'b');

%%%image /images/scatter-examples-images/scatter-example-2.png

%   Example 3: Create Project with 2 titled datasets added to a Point resource 
x = 0:pi/10:4*pi;
example3 = steno3d.scatter(                                  ...
    x(:), cos(x(:)+0.2), sin(x(:)),                          ...
    'Cosine Data', cos(x(:)), 'Sine Data', sin(x(:))         ...
);

%%%image /images/scatter-examples-images/scatter-example-3.png

%   Example 4: Add a point resource with a titled dataset to an existing steno3D project (example3)
steno3d.scatter(                                             ...
    example3, [x(:)+5*pi cos(x(:)+0.2) sin(x(:))],           ...
    'Arctangent Data', atan(x(:))                            ...
);

%%%image /images/scatter-examples-images/scatter-example-4.png

%   Example 5: Return handle to Project and Point resource for editing
x = 0:pi/10:4*pi;
[example5, myPoints] = steno3d.scatter(x(:), cos(x(:)+0.2),  ...
                                       sin(x(:)), 'green');
example5.Title = 'Example 5 Project';
myPoints.Title = 'Green Scatter';
myPoints.Opts.Opacity = .75;
example5.plot();
clear myPoints x

%%%image /images/scatter-examples-images/scatter-example-5.png
