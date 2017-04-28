
steno3d.login;

fig = figure; [x, y, z] = sphere; surf(x, y, z);
h = findobj('Type', 'surface');
load earth; hemisphere = [ones(257,125),X,ones(257,125)];
set(h,'CData',flipud(hemisphere),'FaceColor','texturemap');
colormap(map); axis equal; view([90 0]);
fig.Position = [fig.Position(1:3) fig.Position(3)];
ax = gca; ax.Position = [0 0 1 1];
pngFile = [tempname '.png'];
print(fig, '-dpng', pngFile);
close(fig);
clear map X h hemisphere fig ax;
sfc = steno3d.core.Surface(                                  ...
    'Title', 'Hemisphere',                                   ...
    'Mesh', {                                                ...
        'Triangles', convhull(x(:), y(:), z(:)),             ...
        'Vertices', [x(:) y(:) z(:)]                         ...
    },                                                       ...
    'Textures', {                                            ...
        'O', [-1 -1 -1],                                     ...
        'U', [2 0 0],                                        ...
        'V', [0 0 2],                                        ...
        'Image', pngFile                                     ...
    }                                                        ...
);
example3 = steno3d.core.Project(                             ...
    'Title', 'Textures: Example 3',                          ...
    'Resources', sfc                                         ...
);
example3.plot;
clear sfc x y z pngFile;

% xlim([0 1])
% ylim([0 1])
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

example3.upload();


