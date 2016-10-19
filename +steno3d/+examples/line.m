%Steno3D line plotting examples
%
%   Example 1:
%       % Create Steno3D Project with Line resource from x, y, and z
%       x = 0:pi/10:4*pi;
%       example1 = steno3d.line(x(:), cos(x(:)+0.2), sin(x(:)));
%
%   Example 2:
%       % Create Project with red Line from segments and vertices
%       x = 0:pi/10:4*pi;
%       verts = [x(:) cos(x(:)+0.2) sin(x(:));                       ...
%                   x(:) zeros(length(x), 2)];
%       segs = [1:length(x); length(x) + (1:length(x))]';
%       example2 = steno3d.line(segs, verts, 'r');
%
%   Example 3:
%       % Create Project with Line resource with 2 datasets
%       x = 0:pi/10:4*pi;
%       example3 = steno3d.line(                                     ...
%              x(:), cos(x(:)+0.2), sin(x(:)),                          ...
%              'Vertex Data', x,                                        ...
%              'Segment Data', (x(1:end-1) + x(2:end))/2                ...
%          );
%       % Add another Line resource to that project
%       steno3d.line(                                                ...
%              example3, x(:), sin(x(:)+0.2), cos(x(:)),                ...
%              'Cosine Data', cos(x(:))                                 ...
%          );
%
%   Example 4:
%       % Return handle to Project and Line resource for editing
%       x = 0:pi/10:4*pi;
%       [example4, myLine] = steno3d.line(x(:), cos(x(:)+0.2),       ...
%                                            sin(x(:)), 'turquoise');
%       % Change properties of the Project and the Line
%       example4.Title = 'Example 4 Project';
%       example4.plot();
%       myLine.Title = 'Turquoise Line';
%       myLine.Opts.Opacity = .75;
%       clear myLine x segs verts
%       % Note: myLine is always accessable using:
%       example4.Resources{1};
%
%   You can <a href="matlab: steno3d.examples.line
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.line
%   Then plot the projects with:
%       example1.plot(); % etc...
%
% Additional Examples:
%   <a href="matlab: help steno3d.examples.core.line
%   ">line resources</a>, <a href="matlab:
%   help steno3d.examples.core.project
%   ">projects</a>, <a href="matlab: help steno3d.examples.upload
%   ">uploading</a>, <a href="matlab: help steno3d.examples.plotting
%   ">other plotting functions</a>
%
%   See also steno3d.line, steno3d.core.Line, steno3d.core.Project
%


% Example 1:
% Create Steno3D Project with Line resource from x, y, and z
x = 0:pi/10:4*pi;
example1 = steno3d.line(x(:), cos(x(:)+0.2), sin(x(:)));

% Example 2:
% Create Project with red Line from segments and vertices
x = 0:pi/10:4*pi;
verts = [x(:) cos(x(:)+0.2) sin(x(:));                       ...
         x(:) zeros(length(x), 2)];
segs = [1:length(x); length(x) + (1:length(x))]';
example2 = steno3d.line(segs, verts, 'r');

% Example 3:
% Create Project with Line resource with 2 datasets
x = 0:pi/10:4*pi;
example3 = steno3d.line(                                     ...
    x(:), cos(x(:)+0.2), sin(x(:)),                          ...
    'Vertex Data', x,                                        ...
    'Segment Data', (x(1:end-1) + x(2:end))/2                ...
);
% Add another Line resource to that project
steno3d.line(                                                ...
    example3, x(:), sin(x(:)+0.2), cos(x(:)),                ...
    'Cosine Data', cos(x(:))                                 ...
);

% Example 4:
% Return handle to Project and Line resource for editing
x = 0:pi/10:4*pi;
[example4, myLine] = steno3d.line(x(:), cos(x(:)+0.2),       ...
sin(x(:)), 'turquoise');
% Change properties of the Project and the Line
example4.Title = 'Example 4 Project';
myLine.Title = 'Turquoise Line';
myLine.Opts.Opacity = .75;
example4.plot();
clear myLine x segs verts
% Note: myLine is always accessable using:
example4.Resources{1};
