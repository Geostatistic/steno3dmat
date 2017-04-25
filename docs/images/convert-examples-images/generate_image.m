
steno3d.login;

fig = figure;
subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
example4 = steno3d.convert(fig, 'CombineAxes', true,         ...
                           'CombineResources', true);
example4.plot;
close; clear fig x y;


% fig = figure;
% subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
% subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
% subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
% subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
% example3 = steno3d.convert(fig, 'CombineAxes', true);
% example3.plot;
% close; clear fig x y;

% xlim([0 100])
% ylim([0 100])
% zlim([-8 8])
% ax = gca;
% ax.FontWeight = 'bold';
% ax.FontSize = 12;
% ax.LineWidth = 1.5;
% ax.XGrid = 'on';
% ax.YGrid = 'on';
% ax.ZGrid = 'on';
% ax.XLabel.String = 'X axis';
% ax.XLabel.FontSize = 14;
% ax.YLabel.String = 'Y axis';
% ax.YLabel.FontSize = 14;
% ax.ZLabel.String = 'Z axis';
% ax.ZLabel.FontSize = 14;
% ax.Color = [1 1 1];
% ax.TickLength = [0.02 0.02];
% ax.Box = 'on';
legend('hide')
% xticks([0 5 10 15 20])
campos([44.1127  -12.0908   10.8531])
print('-dpng','-r500','image')

example4.upload();


