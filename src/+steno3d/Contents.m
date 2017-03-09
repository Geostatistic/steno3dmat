%Steno3D MATLAB Package:
%
%   The Steno3D MATLAB package contains tools to build Steno3D resources
%   through plotting functions or at the command line, convert existing
%   MATLAB figures to Steno3D resources, and upload these resources
%   to %%%link[steno3d.com](https://steno3d.com).
%
%   %%%bold[Plotting Functions]: a MATLAB-esque way to create Steno3D projects
%   %%%func[scatter](steno3d.scatter)  - Create and plot a Steno3D Point resource
%   %%%func[line](steno3d.line)     - Create and plot a Steno3D Line resource
%   %%%func[surface](steno3d.surface)  - Create and plot a gridded Steno3D Surface resource
%   %%%func[trisurf](steno3d.trisurf)  - Create and plot a triangulated Steno3D Surface resource
%   %%%func[volume](steno3d.volume)   - Create and plot a Steno3D Volume resource
%
%   %%%bold[Helper Functions]: simple functions to manipulate Steno3D projects
%   %%%func[addData](steno3d.addData)  - Add a dataset to an existing Steno3d resource
%   %%%func[addImage](steno3d.addImage) - Add a PNG image to an existing Steno3d resource
%   %%%func[combine](steno3d.combine)  - Combine a list of Steno3D Projects into one Project
%   %%%func[convert](steno3d.convert)  - Convert MATLAB figure or axes into a Steno3D Project
%
%   %%%bold[Communicate with steno3d.com]:
%   %%%func[login](steno3d.login)    - Log in to steno3d.com to allow Steno3D Project uploads
%   %%%func[upload](steno3d.upload)   - Upload a figure, axes, or Steno3D Project to steno3d.com
%   %%%func[logout](steno3d.logout)   - Log out of current session on steno3d.com
%
%   %%%bold[Additional Packages]:
%   %%%ref[Examples](steno3d.examples) - Example scripts to demonstrate Steno3D
%   %%%ref[Core](steno3d.core)     - Command-line tools for building Steno3D objects from scratch
%   %%%ref[Utils](steno3d.utils)    - Supplemental utilities for figure conversion and web comms
%
%   %%%note
%       Steno3D requires MATLAB R2014b or greater %%%versioncheck
%       and the %%%ref[props](props) package that comes bundled in the steno3dmat
%       distribution.
%
%   %%%tree scatter line surface trisurf volume addData addImage combine convert login upload logout version examples/Contents core/Contents utils/Contents
