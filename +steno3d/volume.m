function [proj, vol] = volume(varargin)
%VOLUME Create and plot a Steno3D Volume resource
%   STENO3D.VOLUME(Data) creates a Steno3D Project with a Volume resource
%   defined by Data, an m x n x p matrix. The Data values are plotted on
%   cell-centers with unit widths. Cell boundaries are defined by x = 0:m,
%   y = 0:n, and z = 0:p.
%
%   STENO3D.VOLUME(Origin, Data) creates a Steno3D Project with a Volume
%   resource as above, offset by 1 x 3 Origin vector. Cell boundaries are
%   defined by x = Origin(1) + (0:m), y = Origin(2) + (0:n), and
%   z = Origin(3) + (0:p).
%
%   STENO3D.VOLUME(X, Y, Z, Data) creates a Steno3D Project with a Volume
%   resource as above. X, Y, and Z are vectors of cell boundaries (with
%   sizes n x 1, m x 1, and p x 1, respectively) OR of cell widths (with
%   sizes (n-1) x 1, (m-1) x 1, and (p-1) x 1, respectively). Since the
%   volume dimensions are given by X, Y, and Z in this case, Data may also
%   be a m*n*p x 1 vector.
%
%   STENO3D.VOLUME(X, Y, Z, Origin, Data) creates a Steno3D Project with a
%   Volume resource as above, offset by 1 x 3 Origin vector. This is
%   useful when X, Y, and Z are cell widths.
%
%   STENO3D.VOLUME(..., Title1, Data1, ..., TitleN, DataN) adds any number
%   of titled datasets to the Volume resource. Title must be a string and
%   Data must be a matrix of size m x n x p (or m*n*p x 1 if X, Y, and Z
%   are provided). Title/Data pairs may replace the standalone Data
%   matrices above. (For more details see <a href="matlab:
%   help steno3d.addData">steno3d.addData</a>)
%
%   STENO3D.VOLUME(Proj, ...) adds the Volume resource to Proj, an
%   existing Steno3D Project. Proj may also be a figure or axes handle that
%   was created by a Steno3D plotting function.
%
%   Proj = STENO3D.VOLUME(...) returns Proj, the Steno3D Project that
%   contains the new Volume resource.
%
%   [Proj, Vol] = STENO3D.VOLUME(...) returns Proj, the Steno3D Project,  
%   Vol, the new Volume resource.
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
%       [xvals, yvals, zvals] = ndgrid(1:5, 1:10, 1:20);
%       [myProject, myVolume] = STENO3D.VOLUME(                         ...
%           4*ones(5, 1), 2*ones(10, 1), ones(20, 1), [-10 -10 -10],    ...
%           'X-Values', xvals, 'Y-Values', yvals, 'Z-Values', zvals     ...
%       );
%       myVolume.Title = 'Example Volume';
%       myVolume.Description = 'Volume with x, y, and z data';
%       myProject.Title = 'Project with one Volume';
%       myProject.Public = true;
%       steno3d.upload(myProject);
%
%   See also STENO3D.CORE.VOLUME, STENO3D.UPLOAD, STENO3D.ADDDATA,      ...
%   STENO3D.CORE.PROJECT
%   


    if isempty(varargin)
        error('steno3d:volumeError', 'Not enough input arguments');
    end

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

