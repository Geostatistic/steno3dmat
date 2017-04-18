
steno3d.login;

x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
tris = convhull(x, y, z);
[myProject, mySurface] = steno3d.trisurf(                       ...
  tris, x, y, z, 'r', 'Face Data', rand(4, 1)                 ...
);
mySurface.Title = 'Triangulated Surface';
mySurface.Description = 'Convex hull triangles';
myProject.Title = 'Project with one Surface';
myProject.Public = true;


% xlim([0 100])
% ylim([0 100])
% zlim([-8 8])
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

steno3d.upload(myProject);


