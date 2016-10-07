function [proj, pts] = scatter(varargin)
%SCATTER Summary of this function goes here
%
%   proj = SCATTER(XYZ)
%   proj = SCATTER(X, Y, Z)
%   proj = SCATTER(XYZ, color)
%   proj = SCATTER(X, Y, Z, color)
%   proj = SCATTER(..., title1, data1, ..., titleN, dataN)
%   SCATTER(proj, ...)
%   [proj, pts] = SCATTER(...)

    if isempty(varargin)
        error('steno3d:scatterError', 'Not enough input arguments');
    end
    
    if isa(varargin{1}, 'steno3d.core.Project')
        proj = varargin{1};
        varargin = varargin(2:end);
    else
        proj = steno3d.core.Project;
    end
    
    if isempty(varargin)
        error('steno3d:scatterError', 'Not enough input arguments');
    end
    
    if ~isnumeric(varargin{1})
        error('steno3d:scatterError', 'Must provide numeric x/y/z values');
    end
    
    
    if length(varargin) > 2 && ~ischar(varargin{2}) && ~ischar(varargin{3})
        x = varargin{1}; y = varargin{2}; z = varargin{3};
        if any(size(x) ~= size(y)) || any(size(x) ~= size(z))
            error('steno3d:scatterError',                               ...
                  'X, Y, and Z must be the same size');
        end
        xyz = [x(:) y(:) z(:)];
        varargin = varargin(4:end);
    else
        xyz = varargin{1};
        if ~ismatrix(xyz)
            error('steno3d:scatterError', 'XYZ matrix must by n x 3');
        end
        if size(xyz, 2) ~= 3 && size(xyz, 1) == 3;
            xyz = xyz';
        end
        if size(xyz, 2) ~= 3
            error('steno3d:scatterError', 'XYZ matrix must by n x 3');
        end
        varargin = varargin(2:end);
    end
    
    if length(varargin) == 1 ||                                         ...
            (length(varargin) > 1 && ischar(varargin{2}))
        color = varargin{1};
        varargin = varargin(2:end);
    else
        color = 'random';
    end
    
    data = {};
    for i = 1:2:length(varargin)
        if ~ischar(varargin{i})
            error('steno3d:scatterError', ['Data must be provided with '...
                  'title/value pairs']);
        end
        if ~isnumeric(varargin{i+1}) ||                                 ...
                length(varargin{i+1}(:)) ~= size(xyz, 1)
            error('steno3d:scatterError', ['Data must be the same '     ...
                  'length as x/y/z values']);
        end
        data{end+1} = {'Data', {'Title', varargin{i},                    ...
                                'Array', varargin{i+1}(:)}};
    end
    
    pts = steno3d.core.Point(                                          ...
        'Mesh', steno3d.core.Mesh0D(                                    ...
            'Vertices', xyz                                             ...
        ),                                                              ...
        'Data', data,                                                   ...
        'Opts', {'Color', color}                                        ...
    );

    proj.Resources = [proj.Resources {pts}];
    
    proj.plot();
end

