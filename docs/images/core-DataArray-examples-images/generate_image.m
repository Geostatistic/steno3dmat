
steno3d.login;

sfc = steno3d.core.Surface;
sfc.Mesh = steno3d.core.Mesh2DGrid;
sfc.Mesh.H1 = ones(5, 1);
sfc.Mesh.H2 = ones(10, 1);
ccValues = rand(5, 10);
datCC = steno3d.core.DataArray;
datCC.Title = 'Random Cell-Centered Data';
datCC.Array = ccValues(:);
nValues = rand(6, 11);
datN = steno3d.core.DataArray;
datN.Title = 'Random Node Data';
datN.Array = nValues(:);
sfc.Data{1} = {                                              ...
    'Location', 'CC',                                        ...
    'Data', datCC                                            ...
};
sfc.Data{2} = {                                              ...
    'Location', 'N',                                         ...
    'Data', datN                                             ...
};
example2 = steno3d.core.Project(                             ...
    'Title', 'Data: Example 2',                              ...
    'Resources', sfc                                         ...
);
example2.plot;
clear sfc datCC datN ccValues nValues

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

example2.upload();


