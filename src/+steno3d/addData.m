function addData(varargin)
%ADDDATA Add a dataset to an existing Steno3d resource
%   `steno3d.addData(resource, data)` adds matrix or vector `data` to the
%   Steno3D `resource` (%%%ref[Point](steno3d.core.Point), %%%ref[Line](steno3d.core.Line), %%%ref[Surface](steno3d.core.Surface), or %%%ref[Volume](steno3d.core.Volume)). This function first
%   attempts to assign `data` to cell centers then to nodes. If the length of
%   the data does not match either of these, this function errors.
%
%   `steno3d.addData(resource, title, data)` adds `data` to the `resource` with a
%   given `title` string.
%
%   Example:
%   %%%codeblock
%       x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
%       tris = convhull(x, y, z);
%       [proj, sfc] = steno3d.trisurf(tris, x, y, z, 'r');
%       steno3d.addData(sfc, 'Cell Center Data', rand(4, 1));
%
%   %%%note
%       If the number of cell centers matches the number of nodes (as is
%       the case in the example above), this function will default to locating
%       data on cell centers. However, this can be changed programatically:
%       %%%codeblock
%           mySurface.Data{end}.Location = 'N';
%
%       and change the title accordingly:
%       %%%codeblock
%           mySurface.Data{end}.Data.Title = 'Node Data';
%
%   See more %%%ref[EXAMPLES](steno3d.examples.adddata)
%
%   %%%seealso steno3d.core.DataArray, steno3d.addImage, steno3d.trisurf
%


    steno3d.utils.matverchk();
    narginchk(2, 3);
    res = varargin{1};
    if ~isa(res, 'steno3d.core.CompositeResource')
        error('steno3d:addDataError', ['Data can only be added to '     ...
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

