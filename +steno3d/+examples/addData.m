% Example:
%       x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
%       tris = convhull(x, y, z);
%       [myProject, mySurface] = steno3d.trisurf(tris, x, y, z, 'r');
%       STENO3D.ADDDATA(mySurface, 'Cell Center Data', rand(4, 1));
%
%   If the number of cell centers matches the number of nodes (as is the
%   case in the example above), this function will default to locating
%   data on cell centers. However, this can be changed programatically:
%
%       mySurface.Data{end}.Location = 'N';
%
%   and change the title accordingly:
%
%       mySurface.Data{end}.Data.Title = 'Node Data';
%