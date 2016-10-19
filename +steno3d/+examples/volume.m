%Steno3D volume plotting examples
%
%   Example 1:
%       % Create Steno3D Project with Volume resource from 3D matrix
%       V = flow;
%       example1 = steno3d.volume(V);
%       clear V
%
%   Example 2:
%       % Create Project with Volume offset from origin
%       example2 = steno3d.volume([-12.5 5 -12.5], flow);
%
%   Example 3:
%       % Create Project with irregularly spaced Volume from a function
%       xedge = [-20:2:-10 -9:9 10:2:20]; yedge = xedge; zedge = -10:10;
%       xcent = (xedge(1:end-1) + xedge(2:end))/2;
%       ycent = (yedge(1:end-1) + yedge(2:end))/2;
%       zcent = (zedge(1:end-1) + zedge(2:end))/2;
%       [X, Y, Z] = ndgrid(xcent, ycent, zcent);
%       dist = sqrt(X.*X + Y.*Y + Z.*Z*4);
%       example3 = steno3d.volume(xcent, ycent, zcent, dist);
%       clear xedge yedge zedge xcent ycent zcent X Y Z dist
%
%   Example 4:
%       % Create Project with titled, offset Volume resource
%       % Note: x, y, and z values correspond to spacing here since they
%       % equal the data dimensions
%       example4 = steno3d.volume(                                   ...
%           2*ones(20, 1), 2*ones(20, 1), 2*ones(10, 1),             ...
%           [-20 -20 -20], 'Random Volume', rand(20, 20, 10)         ...
%       );
%       % Add another Volume to that Project
%       [~, myVolume] = steno3d.volume(                              ...
%           example4, ones(40, 1), ones(40, 1), 2*ones(10, 1),       ...
%           [-20 -20 0], 'Another Random Volume', rand(40, 40, 10)   ...
%       );
%       % Modify the Volume directly
%       myVolume.Opts.Opacity = 0.75;
%       myVolume.Mesh.Opts.Wireframe = true;
%       example4.plot();
%       clear myVolume
%       % Note: myVolume is always accessable using:
%       example4.Resources{end};
%
%   You can <a href="matlab: steno3d.examples.volume
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.volume
%   Then plot the projects with:
%       example1.plot(); % etc...
%
% Additional Examples:
%   <a href="matlab: help steno3d.examples.core.volume
%   ">volume resources</a>, <a href="matlab:
%   help steno3d.examples.core.project
%   ">projects</a>, <a href="matlab: help steno3d.examples.upload
%   ">uploading</a>, <a href="matlab: help steno3d.examples.plotting
%   ">other plotting functions</a>
%
%   See also steno3d.volume, steno3d.core.Volume, steno3d.core.Project
%


% Example 1:
% Create Steno3D Project with Volume resource from 3D matrix
V = flow;
example1 = steno3d.volume(V);
clear V

% Example 2:
% Create Project with Volume offset from origin
example2 = steno3d.volume([-12.5 5 -12.5], flow);

% Example 3:
% Create Project with irregularly spaced Volume from a function
xedge = [-20:2:-10 -9:9 10:2:20]; yedge = xedge; zedge = -10:10;
xcent = (xedge(1:end-1) + xedge(2:end))/2;
ycent = (yedge(1:end-1) + yedge(2:end))/2;
zcent = (zedge(1:end-1) + zedge(2:end))/2;
[X, Y, Z] = ndgrid(xcent, ycent, zcent);
dist = sqrt(X.*X + Y.*Y + Z.*Z*4);
example3 = steno3d.volume(xedge, yedge, zedge, dist);
clear xedge yedge zedge xcent ycent zcent X Y Z dist

% Example 4:
% Create Project with titled, offset Volume resource
% Note: x, y, and z values correspond to spacing here since they
% equal the data dimensions
example4 = steno3d.volume(                                   ...
    2*ones(20, 1), 2*ones(20, 1), 2*ones(10, 1),             ...
    [-20 -20 -20], 'Random Volume', rand(20, 20, 10)         ...
);
% Add another Volume to that Project
[~, myVolume] = steno3d.volume(                              ...
    example4, ones(40, 1), ones(40, 1), 2*ones(10, 1),       ...
    [-20 -20 0], 'Another Random Volume', rand(40, 40, 10)   ...
);
% Modify the Volume directly
myVolume.Opts.Opacity = 0.75;
myVolume.Mesh.Opts.Wireframe = true;
example4.plot();
clear myVolume
% Note: myVolume is always accessable using:
example4.Resources{end};
