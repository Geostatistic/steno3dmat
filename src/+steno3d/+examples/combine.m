%Steno3D combine project examples
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso STENO3D.COMBINE, STENO3D.CONVERT, STENO3D.SCATTER,
%   STENO3D.LINE, STENO3D.VOLUME
%


%Example 1: Combine three Steno3D %%%ref[Projects](steno3d.core.Project)
pointProj = steno3d.scatter(rand(100, 3)); close;
lineProj = steno3d.line(-10:.1:0, sin(-10:.1:0), cos(-10:.1:0));
volProj = steno3d.volume([1 1 1], rand(5, 7, 10)); close; close;
example1 = steno3d.combine(pointProj, lineProj, volProj);
clear pointProj lineProj volProj;

%Example 2: Combine two Projects converted from MATLAB figures
figure; peaks; peaksProj = steno3d.convert(gca); close;
figure; sphere; sphereProj = steno3d.convert(gca); close;
example2 = steno3d.combine(peaksProj, sphereProj);
example2.Title = 'Two-Surface Project';
clear peaksProj sphereProj;

%Example 3: Combine four Projects converted from a multi-axes figure
fig = figure;
subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
projs = steno3d.convert(fig);
example3 = steno3d.combine(projs);
close; clear fig x y projs;
