%Steno3D MATLAB figure/axes conversion examples
%
%   Example 1:
%       % Create MATLAB plot
%       figure; peaks;
%       % Convert the axes into a Steno3D Project
%       example1 = steno3d.convert(gca);
%       close; example1.plot();
%
%   Example 2:
%       % Create MATLAB plot with multiple graphics
%       figure; peaks; hold on; sphere; cylinder
%       % Convert the figure (which converts its axes children)
%       example2 = steno3d.convert(gcf);
%       close; example2.plot();
%
%   Example 3:
%       % Create a MATLAB figure with four plots
%       fig = figure;
%       subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
%       subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
%       subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
%       subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
%       % Convert this figure and combine all the axes into one Project
%       example3 = steno3d.convert(fig, 'CombineAxes', true);
%       close; clear fig x y; example3.plot();
%
%   Example 4:
%       % Create a MATLAB figure with four plots
%       fig = figure;
%       subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
%       subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
%       subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
%       subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
%       % Convert this figure, combine the axes, and attempt to
%       % consolidate all the resources
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
% Additional Examples:
%   <a href="matlab: help steno3d.examples.combine
%   ">combining projects</a>, <a href="matlab:
%   help steno3d.examples.core.project
%   ">projects</a>, <a href="matlab: help steno3d.examples.upload
%   ">uploading</a>,
%   <a href="matlab: help steno3d.examples.plotting
%   ">plotting functions</a>
%
%   See also steno3d.convert, steno3d.core.Project, steno3d.combine
%


% Example 1:
% Create MATLAB plot
figure; peaks;
% Convert the axes into a Steno3D Project
example1 = steno3d.convert(gca);
close; example1.plot();

% Example 2:
% Create MATLAB plot with multiple graphics
figure; peaks; hold on; sphere; cylinder
% Convert the figure (which converts its axes children)
example2 = steno3d.convert(gcf);
close; example2.plot();

% Example 3:
% Create a MATLAB figure with four plots
fig = figure;
subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
% Convert this figure and combine all the axes into one Project
example3 = steno3d.convert(fig, 'CombineAxes', true);
close; clear fig x y; example3.plot();

% Example 4:
% Create a MATLAB figure with four plots
fig = figure;
subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
% Convert this figure, combine the axes, and attempt to
% consolidate all the resources
example4 = steno3d.convert(fig, 'CombineAxes', true,         ...
                           'CombineResources', true);
close; clear fig x y; example4.plot();
