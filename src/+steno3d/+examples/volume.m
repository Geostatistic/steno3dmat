%volume plotting examples:
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso steno3d.volume, steno3d.core.Volume, steno3d.core.Project
%


%   Example 1: Create Steno3D %%%ref[Project](steno3d.core.Project) with a %%%ref[Volume](steno3d.core.Volume) resource from 3D matrix
V = flow;
example1 = steno3d.volume(V);
clear V;

%%%image /images/volume-examples-images/volume-example-1.png

%   Example 2: Create Volume resource with an offset of [-12.5 5 -12.5] from origin
example2 = steno3d.volume([-12.5 5 -12.5], flow);

%%%image /images/volume-examples-images/volume-example-2.png

%   Example 3: Create Project with irregularly spaced Volume resource where "dist" data are added to the cell-centers inside the Volume resource
xedge = [-20:2:-10 -9:9 10:2:20]; yedge = xedge; zedge = -10:10;
xcent = (xedge(1:end-1) + xedge(2:end))/2;
ycent = (yedge(1:end-1) + yedge(2:end))/2;
zcent = (zedge(1:end-1) + zedge(2:end))/2;
[X, Y, Z] = ndgrid(xcent, ycent, zcent);
dist = sqrt(X.*X + Y.*Y + Z.*Z*4);
example3 = steno3d.volume(xedge, yedge, zedge, dist);
clear xedge yedge zedge xcent ycent zcent X Y Z dist;

%%%image /images/volume-examples-images/volume-example-3.png

%   Example 4: Create Project with a new Volume resource added to it
[xvals, yvals, zvals] = ndgrid(-8:4:8, -9:2:9, -9.5:9.5);
example4 = steno3d.volume(                                   ...
    4*ones(5, 1), 2*ones(10, 1), ones(20, 1), [-10 -10 -10], ...
    'X-Values', xvals, 'Y-Values', yvals, 'Z-Values', zvals  ...
);
[~, vol] = steno3d.volume(                                   ...
    example4, ones(20, 1), ones(20, 1), 2*ones(10, 1),       ...
    [-10 -10 15], 'Random Data', rand(20, 20, 10)            ...
);
vol.Opts.Opacity = 0.75;
vol.Mesh.Opts.Wireframe = true;
example4.plot();
clear xvals yvals zvals vol;

%%%image /images/volume-examples-images/volume-example-4.png
