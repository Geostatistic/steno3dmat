% STENO3D: MATLAB Client for <a href=
% "matlab: web('https://steno3d.com/','-browser')">Steno3D</a> by <a href=
% "matlab: web('https://www.3ptscience.com','-browser')">3pt Science</a>
%
% Version 0.0.1
%
% The Steno3D MATLAB package contains tools to build Steno3D resources
% through plotting functions or at the command line, convert existing
% MATLAB figures to Steno3D resources, and upload these resources
% to <a href="matlab: web('https://steno3d.com/','-browser')"
% >steno3d.com</a>.
%
% Note: Steno3D requires MATLAB R2014b or greater (<a href="matlab:
%   fprintf('Required version: 2014b\n');
%   fprintf(['Your version: ' version('-release') '\n']);
%   if verLessThan('matlab', 'R2014b')
%   	fprintf('Please upgrade to the latest version of MATLAB.\n');
%   else
%       fprintf('MATLAB version is valid.\n');
%   end">Check your version</a>)
%       and the <a href="matlab: help props"
%       >props</a> package that comes bundled in the steno3dmat
%       distribution.
%
% Plotting Functions: a MATLAB-esque way to create Steno3D projects
%   scatter  - Summary of this function goes here
%   line     - STENO3D.LINE Summary of this function goes here
%   surface  - Summary of this function goes here
%   trisurf  - STENO3D.TRISURF Summary of this function goes here
%   volume   - Summary of this function goes here
%
% Helper Functions: simple functions to manipulate Steno3D projects
%   addData  - Summary of this function goes here
%   addImage - Summary of this function goes here
%   combine  - Combine a list of steno3d projects into one
%   convert  - Converts MATLAB figure or axes into a steno3d project
%
% Communicate with steno3d.com:
%   login    - Logs in to steno3d.com with your api developer key
%   upload   - Convert Matlab figure or axes to Steno3D project and upload
%   logout   - Logs user out of current steno3d session
%
% Additional Packages
%   core     - Command-line tools for building Steno3D objects from scratch
%   utils    - Supplemental utilities for figure conversion and web comms
