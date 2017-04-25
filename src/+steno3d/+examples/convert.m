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
example1.plot;
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
example3.plot;
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
