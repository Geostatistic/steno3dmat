%Steno3D line plotting examples
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso STENO3D.LINE, STENO3D.CORE.LINE, STENO3D.CORE.PROJECT
%


%Example 1: Plot a Steno3D %%%ref[Project](steno3d.core.Project) with a %%%ref[Line](steno3d.core.Line) from array input
x = 0:pi/10:4*pi;
example1 = steno3d.line(x, cos(x+0.2), sin(x));
clear x;

%Example 2: Plot Project with red Line from segments and vertices
x = (0:pi/10:4*pi)';
verts = [x cos(x+0.2) sin(x); x zeros(length(x), 2)];
segs = [1:length(x); length(x) + (1:length(x))]';
example2 = steno3d.line(segs, verts, 'r');
clear x verts segs;

%Example 3: Plot Project with two Lines with data
x = 0:pi/10:4*pi;
example3 = steno3d.line(                                     ...
    x(:), cos(x(:)+0.2), sin(x(:)),                          ...
    'Vertex Data', x,                                        ...
    'Segment Data', (x(1:end-1) + x(2:end))/2                ...
);
steno3d.line(                                                ...
    example3, x, sin(x+0.2), cos(x), 'k',                    ...
    'Cosine Data', cos(x)                                    ...
);
clear x;

%Example 4: Plot Project and Line, then edit the Line properties
x = 0:pi/10:4*pi;
[example4, lin] = steno3d.line(x, cos(x+0.2), sin(x), 'b');
example4.Title = 'Example 4 Project';
lin.Title = 'Blue Line';
lin.Opts.Opacity = .75;
example4.plot();
clear myLine x segs verts;
