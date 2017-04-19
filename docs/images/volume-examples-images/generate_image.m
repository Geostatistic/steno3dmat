
steno3d.login;

xedge = [-20:2:-10 -9:9 10:2:20]; yedge = xedge; zedge = -10:10;
xcent = (xedge(1:end-1) + xedge(2:end))/2;
ycent = (yedge(1:end-1) + yedge(2:end))/2;
zcent = (zedge(1:end-1) + zedge(2:end))/2;
[X, Y, Z] = ndgrid(xcent, ycent, zcent);
dist = sqrt(X.*X + Y.*Y + Z.*Z*4);
example3 = steno3d.volume(xedge, yedge, zedge, dist);
clear xedge yedge zedge xcent ycent zcent X Y Z dist;


% [xvals, yvals, zvals] = ndgrid(-8:4:8, -9:2:9, -9.5:9.5);
% example4 = steno3d.volume(                                   ...
%     4*ones(5, 1), 2*ones(10, 1), ones(20, 1), [-10 -10 -10], ...
%     'X-Values', xvals, 'Y-Values', yvals, 'Z-Values', zvals  ...
% );
% [~, vol] = steno3d.volume(                                   ...
%     example4, ones(20, 1), ones(20, 1), 2*ones(10, 1),       ...
%     [-10 -10 15], 'Random Data', rand(20, 20, 10)            ...
% );
% vol.Opts.Opacity = 0.75;
% vol.Mesh.Opts.Wireframe = true;
% example4.plot();
% clear xvals yvals zvals vol;
% 
% [xvals, yvals, zvals] = ndgrid(-8:4:8, -9:2:9, -9.5:9.5);
% [proj, vol] = steno3d.volume(                                   ...
%   4*ones(5, 1), 2*ones(10, 1), ones(20, 1), [-10 -10 -10],    ...
%   'X-Values', xvals, 'Y-Values', yvals, 'Z-Values', zvals     ...
% );
% vol.Title = 'Example Volume';
% vol.Description = 'Volume with x, y, and z data';
% vol.Title = 'Project with one Volume';
% proj.Public = true;


% xlim([0 25])
% ylim([-10 10])
% zlim([0 30])
ax = gca;
ax.FontWeight = 'bold';
ax.FontSize = 12;
ax.LineWidth = 1.5;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.ZGrid = 'on';
ax.XLabel.String = 'X axis';
ax.XLabel.FontSize = 14;
ax.YLabel.String = 'Y axis';
ax.YLabel.FontSize = 14;
ax.ZLabel.String = 'Z axis';
ax.ZLabel.FontSize = 14;
ax.Color = [1 1 1];
ax.TickLength = [0.02 0.02];
ax.Box = 'on';
legend('hide')
% xticks([0 5 10 15 20])
campos([44.1127  -12.0908   10.8531])
print('-dpng','-r500','image')
example3.upload();




