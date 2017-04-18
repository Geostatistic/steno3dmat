
steno3d.login;

x = 0:pi/10:4*pi;
[proj, lin] = steno3d.line(                                     ...
    x, cos(x), sin(x), 'k', 'Cosine Vert Data', cos(x)          ...
);
lin.Title = 'Example Line';
lin.Description = 'Trig functions with random data';
proj.Title = 'Project with one Line';


xlim([0 12.6])
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
xticks([0 2 4 6 8 10 12])
campos([44.1127  -12.0908   10.8531])
print('-dpng','-r500','image')

proj.upload()
% example5.upload()


