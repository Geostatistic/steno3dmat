function [proj, lin] = line(varargin)
%STENO3D.LINE Summary of this function goes here
%
%   proj = STENO3D.LINE(x, y, z)
%   proj = STENO3D.LINE(vertices, segments)
%   proj = STENO3D.LINE(x, y, z, color)
%   proj = STENO3D.LINE(vertices, segments, color)
%   proj = STENO3D.LINE(..., title1, data1, ..., titleN, dataN)
%   STENO3D.LINE(proj, ...)
%   [proj, line] = STENO3D.LINE(...)

    

    if isempty(varargin)
        error('steno3d:lineError', 'Not enough input arguments');
    end
    
    if isa(varargin{1}, 'steno3d.core.Project')
        proj = varargin{1};
        varargin = varargin(2:end);
    else
        proj = steno3d.core.Project;
    end
    
    if length(varargin) < 2
        error('steno3d:lineError', 'Not enough input arguments');
    end
    
    if ismatrix(varargin{1}) && size(varargin{1}, 2) == 3 &&            ...
            ismatrix(varargin{2}) && size(varargin{2}, 2) == 2
        verts = varargin{1};
        segs = varargin{2};
        varargin = varargin(3:end);
    elseif length(varargin) > 2
        x = varargin{1}; y = varargin{2}; z = varargin{3};
        if ~(ismatrix(x) && ismatrix(y) && ismatrix(z) &&               ...
                all(size(x) == size(y)) && all(size(x) == size(z)))
            error('steno3d:lineError', ['x, y, and z must be vectors '  ...
                  'or matrices of the same size']);
        end
        if size(x, 1) == 1
            x = x(:); y = y(:); z = z(:);
        end
        verts = [x(:) y(:) z(:)];
        segs = zeros(0, 2);
        for i = 1:size(x, 2)
            segs = [segs; (i-1)*size(x, 1) +                            ...
                          [1:size(x, 1)-1; 2:size(x, 1)]'];
        end
        varargin = varargin(4:end);
    else
        error('steno3d:lineError', 'Not enough input arguments')
    end
    
    if ~all(segs(:) == round(segs(:)))
        error('steno3d:lineError', 'Segments must be integers');
    end
    if max(segs(:) > size(verts, 1)) || min(segs(:) < 1)
        error('steno3d:lineError', ['Segments must be integers between '...
              '1 and length(Vertices)']);
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
            error('steno3d:lineError', ['Data must be provided with '   ...
                  'title/value pairs']);
        end
        if ~isnumeric(varargin{i+1}) 
            error('steno3d:lineError', 'Data must be the numeric');
        end
        dat = varargin{i+1}(:);
        if length(dat) == size(segs, 1)
            loc = 'CC';
        elseif length(dat) == size(verts, 1)
            loc = 'N';
        else
            error('steno3d:lineError', ['Data must be the same length ' ...
                  'as either the number of Segments or Vertices']);
        end
        data{end+1} = {'Location', loc,                                  ...
                       'Data', {'Title', varargin{i},                    ...
                                'Array', dat}};
    end
    
    lin = steno3d.core.Line(                                            ...
        'Mesh', steno3d.core.Mesh1D(                                    ...
            'Vertices', verts,                                          ...
            'Segments', segs                                           ...
        ),                                                              ...
        'Data', data,                                                   ...
        'Opts', {'Color', color}                                        ...
    );

    proj.Resources = [proj.Resources {lin}];
    
    proj.plot();
end
