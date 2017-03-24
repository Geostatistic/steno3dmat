%scatter plotting examples:
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso steno3d.scatter, steno3d.core.Point, steno3d.core.Project
%

%   Example 2: Create Project with red Point resource from n x 3 matrix
x = 0:pi/10:4*pi;
example1 = steno3d.scatter([x(:) cos(x(:)+0.2) sin(x(:))]);

%   Example 1:  Create Steno3D %%%ref[Project](steno3d.core.Project) with %%%ref[Point](steno3d.core.Point) resource from x, y, and z
x = 0:pi/10:4*pi;
example2 = steno3d.scatter(x(:), cos(x(:)+0.2), sin(x(:)),'r');

%   Example 3: Create Project with Point resource with 2 datasets
x = 0:pi/10:4*pi;
example3 = steno3d.scatter(                                  ...
    x(:), cos(x(:)+0.2), sin(x(:)),                          ...
    'Cosine Data', cos(x(:)), 'Sine Data', sin(x(:))         ...
);
steno3d.scatter(                                             ...
    example3, [x(:)+5*pi cos(x(:)+0.2) sin(x(:))],           ...
    'Arctangent Data', atan(x(:))                            ...
);

%   Example 4: Return handle to Project and Point resource for editing
x = 0:pi/10:4*pi;
[example4, myPoints] = steno3d.scatter(x(:), cos(x(:)+0.2),  ...
                                       sin(x(:)), 'turquoise');
example4.Title = 'Example 4 Project';
myPoints.Title = 'Turquoise Scatter';
myPoints.Opts.Opacity = .75;
example4.plot();
clear myPoints x
