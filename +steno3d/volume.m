function [proj, vol] = volume(varargin)
%VOLUME Summary of this function goes here
%
%   proj = VOLUME(data)
%   proj = VOLUME(origin, data)
%   proj = VOLUME(x, y, z, data)
%   proj = VOLUME(x, y, z, origin, data)
%   proj = VOLUME(..., title1, data1, ..., titleN, dataN)
%   VOLUME(proj, ...)
%   [proj, vol] = VOLUME(...)

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
    
    if ismatrix(varargin{1}) && all(size(varargin{1}) == [1 3])
        origin = varargin{1};
        varargin = varargin(2:end);
    end
    
    
    if length(varargin) == 1
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

