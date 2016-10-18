%Steno3D combine project examples
%
%   Example 1:
%       >> % Create three separate projects
%       >> pointProj = steno3d.scatter(rand(100, 3));
%       >> lineProj = steno3d.line(-10:.1:0, sin(-10:.1:0), cos(-10:.1:0));
%       >> volProj = steno3d.volume([1 1 1], rand(5, 7, 10));
%       >> close all
%       >> % Combine them all into one Project
%       >> example1 = steno3d.combine(pointProj, lineProj, volProj);
%       >> example1.plot();
%       >> clear pointProj lineProj volProj
%
%   Example 2:
%       >> % Create a MATLAB figure with four plots
%       >> fig = figure;
%       >> subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
%       >> subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
%       >> subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
%       >> subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
%       >> % Convert this figure into a list of four Steno3D Projects
%       >> projs = steno3d.convert(fig);
%       >> close; clear fig x y
%       >> % Combine the four Projects into one
%       >> example2 = steno3d.combine(projs);
%       >> example2.plot();
%       >> clear projs
%
%   You can <a href="matlab: steno3d.examples.combine
%   ">click here</a> to run the above examples or type:
%       >> steno3d.examples.combine
%   Then plot the projects with:
%       >> example1.plot(); % etc...
%
% Additional Examples:
%   <a href="matlab: help steno3d.examples.convert
%   ">converting MATLAB figures/axes</a>, <a href="matlab:
%   help steno3d.examples.core.project
%   ">projects</a>, <a href="matlab: help steno3d.examples.upload
%   ">uploading</a>,
%   <a href="matlab: help steno3d.examples.plotting
%   ">plotting functions</a>
%
%   See also steno3d.combine, steno3d.core.Project, steno3d.convert,
%   steno3d.scatter, steno3d.line, steno3d.volume
%


% Example 1:
% Create three separate projects
pointProj = steno3d.scatter(rand(100, 3));
lineProj = steno3d.line(-10:.1:0, sin(-10:.1:0), cos(-10:.1:0));
volProj = steno3d.volume([1 1 1], rand(5, 7, 10));
close all
% Combine them all into one project
example1 = steno3d.combine(pointProj, lineProj, volProj);
example1.plot();
clear pointProj lineProj volProj

% Example 2:
% Create a MATLAB figure with four plots
fig = figure;
subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
% Convert this figure into a list of four Steno3D projects
projs = steno3d.convert(fig);
close; clear fig x y
% Combine the four projects into one
example2 = steno3d.combine(projs);
example2.plot();
clear projs