
steno3d.login;

x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
tris = convhull(x, y, z);
[proj, sfc] = steno3d.trisurf(tris, x, y, z, 'r');
steno3d.addData(sfc, 'Cell Center Data', rand(4, 1));
proj.plot;

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
proj.upload();
