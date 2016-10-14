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
% Plotting Functions: a MATLAB-esque way to create Steno3D projects
%   scatter  - Create and plot a Steno3D Point resource
%   line     - Create and plot a Steno3D Line resource
%   surface  - Create and plot a gridded Steno3D Surface resource
%   trisurf  - Create and plot a triangulated Steno3D Surface resource
%   volume   - Create and plot a Steno3D Volume resource
%
% Helper Functions: simple functions to manipulate Steno3D projects
%   addData  - Add a dataset to an existing Steno3d resource
%   addImage - Add a PNG image to an existing Steno3d resource
%   combine  - Combine a list of Steno3D Projects into one Project
%   convert  - Convert MATLAB figure or axes into a Steno3D Project
%
% Communicate with steno3d.com:
%   login    - Log in to steno3d.com to allow Steno3D Project uploads
%   upload   - Upload a figure, axes, or Steno3D Project to steno3d.com
%   logout   - Log out of current session on steno3d.com
%
% Additional Packages
%   examples - Example scripts to demonstrate Steno3D
%   core     - Command-line tools for building Steno3D objects from scratch
%   utils    - Supplemental utilities for figure conversion and web comms
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