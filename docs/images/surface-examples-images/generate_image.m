
steno3d.login;

Z = peaks(20);
example1 = steno3d.surface(Z);

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

example1.upload();


