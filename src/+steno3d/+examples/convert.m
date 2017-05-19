%convert figures/axes examples:
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso steno3d.convert
%


%   Example 1: Convert MATLAB axes to Steno3D %%%ref[Project](steno3d.core.Project)
figure; peaks;
example1 = steno3d.convert(gca);
example1.plot();
close;

%%%image /images/convert-examples-images/convert-example-1.png

%   Example 2: Convert figure with multiple graphics to Steno3D
figure; peaks; hold on; sphere; cylinder
example2 = steno3d.convert(gcf);
example2.plot;
close;

%%%image /images/convert-examples-images/convert-example-2.png

%   Example 3: Combine four axes into one project with multiple resources
fig = figure;
subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
example3 = steno3d.convert(fig, 'CombineAxes', true);
example3.plot();
close; clear fig x y;

%%%image /images/convert-examples-images/convert-example-3.png

%   Example 4: Combine four axes and combine all their graphics
fig = figure;
subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
example4 = steno3d.convert(fig, 'CombineAxes', true,         ...
                           'CombineResources', true);
example4.plot();
close; clear fig x y;

%%%image /images/convert-examples-images/convert-example-4.png

%  Example 5: Wind flow visualization in Matlab
load wind x y z u v w
spd = sqrt(u.*u + v.*v + w.*w);
figure
p = patch(isosurface(x, y, z, spd, 40));
isonormals(x, y, z, spd, p)
set(p, 'FaceColor', 'red', 'EdgeColor', 'none')
p2 = patch(isocaps(x, y, z, spd, 40));
set(p2, 'FaceColor', 'interp', 'EdgeColor', 'none')
daspect([1 1 1])
[f, verts] = reducepatch(isosurface(x, y, z, spd, 30), .2);
h = coneplot(x, y, z, u, v, w, verts(:, 1), verts(:, 2), verts(:, 3), 2);
set(h, 'FaceColor', 'cyan', 'EdgeColor', 'none')
[sx, sy, sz] = meshgrid(80, 20:10:50, 0:5:15);
h2 = streamline(x, y, z, u, v, w, sx, sy, sz);
set(h2, 'Color', [.4 1 .4])
example5 = steno3d.convert(gcf);
example5.plot();
close;
