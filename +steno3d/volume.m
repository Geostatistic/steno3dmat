function [proj, vol] = volume(varargin)
%VOLUME Create and plot a Steno3D Volume resource
%   STENO3D.VOLUME(DATA) creates a Steno3D Project with a Volume resource
%   defined by DATA, an m x n x p matrix. The data values are plotted on
%   cell-centers with unit widths. Cell boundaries are defined by x = 0:m,
%   y = 0:n, and z = 0:p.
%
%   STENO3D.VOLUME(ORIGIN, DATA) creates a Steno3D Project with a Volume
%   resource as above, offset by 1 x 3 ORIGIN vector. Cell boundaries are
%   defined by x = ORIGIN(1) + (0:m), y = ORIGIN(2) + (0:n), and
%   z = ORIGIN(3) + (0:p).
%
%   STENO3D.VOLUME(X, Y, Z, DATA) creates a Steno3D Project with a Volume
%   resource as above. X, Y, and Z are vectors of cell boundaries (with
%   sizes n x 1, m x 1, and p x 1, respectively) OR of cell widths (with
%   sizes (n-1) x 1, (m-1) x 1, and (p-1) x 1, respectively). Since the
%   volume dimensions are given by X, Y, and Z in this case, DATA may also
%   be a m*n*p x 1 vector.
%
%   STENO3D.VOLUME(X, Y, Z, ORIGIN, DATA) creates a Steno3D Project with a
%   Volume resource as above, offset by 1 x 3 ORIGIN vector. This is
%   useful when X, Y, and Z are cell widths.
%
%   STENO3D.VOLUME(..., TITLE1, DATA1, ..., TITLEN, DATAN) adds any number
%   of titled datasets to the Volume resource. TITLE must be a string and
%   DATA must be a matrix of size m x n x p (or m*n*p x 1 if X, Y, and Z
%   are provided). TITLE/DATA pairs may replace the standalone DATA
%   matrices above. (For more details see <a href="matlab:
%   help steno3d.addData">steno3d.addData</a>)
%
%   STENO3D.VOLUME(PROJECT, ...) adds the Volume resource to PROJECT, an
%   existing Steno3D Project. PROJECT may also be a figure or axes handle
%   that was created by a Steno3D plotting function.
%
%   PROJECT = STENO3D.VOLUME(...) returns PROJECT, the Steno3D Project that
%   contains the new Volume resource.
%
%   [PROJECT, VOLUME] = STENO3D.VOLUME(...) returns PROJECT, the Steno3D 
%   Project, and VOLUME, the new Volume resource.
%
%   STENO3D.VOLUME does not have a MATLAB builtin counterpart. When
%   plotting a Steno3D Volume locally, its boundaries are displayed in a
%   similar way as <a href="matlab: help slice
%   ">slice</a>, but when uploaded to steno3d.com, the entire
%   volume is available for plotting, slicing, and isosurfacing. After
%   creating a Volume resource with STENO3D.VOLUME, properties of the
%   Volume object can be directly modified.
%
%   Example:
%       [xvals, yvals, zvals] = ndgrid(-7.5:4:7.5, -9:2:9, -9.5:9.5);
%       [proj, vol] = STENO3D.VOLUME(                                   ...
%           4*ones(5, 1), 2*ones(10, 1), ones(20, 1), [-10 -10 -10],    ...
%           'X-Values', xvals, 'Y-Values', yvals, 'Z-Values', zvals     ...
%       );
%       vol.Title = 'Example Volume';
%       vol.Description = 'Volume with x, y, and z data';
%       vol.Title = 'Project with one Volume';
%       proj.Public = true;
%       steno3d.upload(proj);
%
%   See also STENO3D.CORE.VOLUME, STENO3D.UPLOAD, STENO3D.ADDDATA,
%   STENO3D.CORE.PROJECT
%   
    
    
    steno3d.utils.matverchk();
    narginchk(1, inf);
    if isa(varargin{1}, 'steno3d.core.Project')
        proj = varargin{1};
        varargin = varargin(2:end);
    else
        proj = steno3d.core.Project;
    end
    if isempty(varargin)
        error('steno3d:volumeError', 'Not enough input arguments');
    end
    xyzInput = false;
    origin = [0 0 0];
    if length(varargin) > 3
        x = varargin{1}; y = varargin{2}; z = varargin{3};
        if length(x) == length(x(:)) && length(y) == length(y(:)) && 	...
                length(z) == length(z(:))
            xyzInput = true;
            varargin = varargin(4:end);
        end
    end
    if isempty(varargin)
        error('steno3d:volumeError', 'Not enough input arguments');
    end
    if ismatrix(varargin{1}) && isnumeric(varargin{1}) &&               ...
            all(size(varargin{1}) == [1 3])
        origin = varargin{1};
        varargin = varargin(2:end);
    end
    if isempty(varargin)
        error('steno3d:volumeError', 'Not enough input arguments');
    end
    if isnumeric(varargin{1})
       varargin = [{''} varargin];
    end
    if ~isnumeric(varargin{2})
        error('steno3d:volumeError', 'Data must be numeric');
    end
    if xyzInput
        if validSize(length(x), length(y), length(z), varargin{2})
            h1 = x;
            h2 = y;
            h3 = z;
        elseif validSize(length(x)-1, length(y)-1, length(z)-1,         ...
                         varargin{2})
            h1 = diff(x);
            h2 = diff(y);
            h3 = diff(z);
            origin = origin + [x(1) y(1) z(1)];
        else
            error('steno3d:volumeError',                            ...
                  'x/y/z lengths and data size do not correspond');
        end
    else    
        if ndims(varargin{2}) ~= 3
            error('steno3d:volumeError',                            ...
                  'Data must have 3 dimensions');
        else
            h1 = ones(size(varargin{2}, 1), 1);
            h2 = ones(size(varargin{2}, 2), 1);
            h3 = ones(size(varargin{2}, 3), 1);
        end
    end
    data = {};
    for i = 1:2:length(varargin)
        if ~ischar(varargin{i})
            error('steno3d:volumeError', 'Data titles must be strings');
        end
        if ~isnumeric(varargin{i+1})
            error('steno3d:volumeError', 'Data must be numeric');
        end
        if ~validSize(length(h1), length(h2), length(h3), varargin{i+1})
            error('steno3d:volumeError', 'Data is not the correct size');
        end
        data{end+1} = {'Data', {'Title', varargin{i},                    ...
                                'Array', varargin{i+1}(:)}};
    end
    vol = steno3d.core.Volume(                                          ...
        'Mesh', steno3d.core.Mesh3DGrid(                                ...
            'H1', h1(:),                                                ...
            'H2', h2(:),                                                ...
            'H3', h3(:),                                                ...
            'O', origin                                                 ...
        ),                                                              ...
        'Data', data                                                    ...
    );
    proj.Resources = [proj.Resources {vol}];
    proj.plot();
end

function valid = validSize(lenx, leny, lenz, data)
    if ndims(data) == 3 &&                                              ...
            all([lenx leny lenz] == size(data))
        valid = true;
        return
    end
    if length(data) == length(data(:)) &&                               ...
            lenx * leny * lenz == length(data)
        valid = true;
        return
    end
    valid = false;
end

