function addData(varargin)
%ADDDATA Add a dataset to an existing Steno3d resource
%   STENO3D.ADDDATA(RESOURCE, DATA) adds matrix or vector DATA to the
%   Steno3D RESOURCE (Point, Line, Surface, or Volume). This function first
%   attempts to assign DATA to cell centers then to nodes. If the length of
%   the data does not match either of these, this function errors.
%
%   STENO3D.ADDDATA(RESOURCE, TITLE, DATA) adds DATA to the RESOURCE with a
%   given TITLE string.
%
%   Example:
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
%       mySurface.Data{end}.Title = 'Node Data';
%
%   See also STENO3D.CORE.DATAARRAY, STENO3D.ADDIMAGE, STENO3D.SCATTER,
%   STENO3D.LINE, STENO3D.TRISURF, STENO3D.SURFACE, STENO3D.VOLUME
%


    narginchk(2, 3);
    
    res = varargin{1};
    if ~isa(res, 'steno3d.core.CompositeResource')
        error('steno3d:addDataError', ['Data can only be added to '...
              'Steno3D composite resources']);
    end
    
    if nargin == 3
        title = varargin{2};
        data = varargin{3};
        if ~ischar(title)
            error('steno3d:addDataError', 'Data title must be a string');
        end
    else
        title = '';
        data = varargin{2};
    end
    
    if ~isnumeric(data)
        error('steno3d:addDataError', 'Data must be numeric');
    end
    data = data(:);
    
    if length(data) == res.Mesh.nC
        loc = 'CC';
    elseif length(data) == res.Mesh.nN
        loc = 'N';
    else
        error('steno3d:addDataError', ['Data length must equal the '    ...
              'number of nodes (%s) or cell centers(%s)'], res.Mesh.nN, ...
              res.Mesh.nC)
    end
    
    dat = {'Location', loc, 'Data', {'Array', data, 'Title', title}};
    
    res.Data{end+1} = dat;

end
