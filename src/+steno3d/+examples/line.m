%line plotting examples:
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso steno3d.line, steno3d.core.Line, steno3d.core.Project
%


%   Example 1: Create a Steno3D %%%ref[Project](steno3d.core.Project) with a %%%ref[Line](steno3d.core.Line) from array input
x = 0:pi/10:4*pi;
example1 = steno3d.line(x, cos(x+0.2), sin(x));
clear x;

%%%image /images/line-examples-images/line-example-1.png

%   Example 2: Create Project with red Line from segments and vertices
x = (0:pi/10:4*pi)';
verts = [x cos(x+0.2) sin(x); x zeros(length(x), 2)];
segs = [1:length(x); length(x) + (1:length(x))]';
example2 = steno3d.line(segs, verts, 'b');
clear x verts segs;

%%%image /images/line-examples-images/line-example-2.png

%   Example 3: Create Project with two titled datasets added to a Line resource
x = 0:pi/10:4*pi;
example3 = steno3d.line(                                     ...
    x(:), cos(x(:)+0.2), sin(x(:)),                          ...
    'Vertex Data', x,                                        ...
    'Segment Data', (x(1:end-1) + x(2:end))/2                ...
);

%%%image /images/line-examples-images/line-example-3.png

%   Example 4: Added a Line resource to an existing Steno3D Project (example3)
example4 = steno3d.line(                                                ...
    example3, x, sin(x+0.2), cos(x), 'k',                    ...
    'Cosine Data', cos(x)                                    ...
);
clear x;

%%%image /images/line-examples-images/line-example-4.png

%   Example 5: Create Project and Line, then edit the Line properties
x = 0:pi/10:4*pi;
[example5, lin] = steno3d.line(x, cos(x+0.2), sin(x), 'b');
example5.Title = 'Example 5 Project';
lin.Title = 'Blue Line';
lin.Opts.Opacity = .75;
example5.plot();
clear myLine x segs verts;

%%%image /images/line-examples-images/line-example-5.png


