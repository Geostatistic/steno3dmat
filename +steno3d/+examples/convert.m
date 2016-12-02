%Steno3D MATLAB figure/axes conversion examples
%
%   Example 1: Convert MATLAB axes to Steno3D <a href="matlab:
%   help steno3d.core.Project">Project</a>
%       figure; peaks;
%       example1 = steno3d.convert(gca);
%       close;
%
%   Example 2: Convert figure with multiple graphics to Steno3D
%       figure; peaks; hold on; sphere; cylinder
%       example2 = steno3d.convert(gcf);
%       close;
%
%   Example 3: Combine four axes into one project with multiple resources
%       fig = figure;
%       subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
%       subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
%       subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
%       subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
%       example3 = steno3d.convert(fig, 'CombineAxes', true);
%       close; clear fig x y;
%
%   Example 4: Combine four axes and combine all their graphics
%       fig = figure;
%       subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
%       subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
%       subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
%       subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
%       example4 = steno3d.convert(fig, 'CombineAxes', true,         ...
%                                  'CombineResources', true);
%       close; clear fig x y; example4.plot();
%
%   You can <a href="matlab: steno3d.examples.convert
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.convert
%   Then plot the projects with:
%       example1.plot(); % etc...
%
%
%   See also STENO3D.CONVERT
%


% Example 1: Convert MATLAB axes to Steno3D
figure; peaks;
example1 = steno3d.convert(gca);
close;

% Example 2: Convert figure with multiple graphics to Steno3D
figure; peaks; hold on; sphere; cylinder
example2 = steno3d.convert(gcf);
close;

% Example 3: Combine four axes into one project with multiple resources
fig = figure;
subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
example3 = steno3d.convert(fig, 'CombineAxes', true);
close; clear fig x y;

% Example 4: Combine four axes and combine all their graphics
fig = figure;
subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
example4 = steno3d.convert(fig, 'CombineAxes', true,         ...
                           'CombineResources', true);
close; clear fig x y; example4.plot();