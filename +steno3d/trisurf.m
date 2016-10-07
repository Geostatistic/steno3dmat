function [proj, surf] = trisurf(varargin)
%STENO3D.TRISURF Summary of this function goes here
%
%   proj = STENO3D.TRISURF(vertices, triangles)
%   proj = STENO3D.TRISURF(vertices, triangles, color)
%   proj = STENO3D.TRISURF(..., title1, data1, ..., titleN, dataN)
%   STENO3D.TRISURF(proj, ...)
%   [proj, surf] = STENO3D.TRISURF(...)

    

    if isempty(varargin)
        error('steno3d:trisurfError', 'Not enough input arguments');
    end
    
    if isa(varargin{1}, 'steno3d.core.Project')
        proj = varargin{1};
        varargin = varargin(2:end);
    else
        proj = steno3d.core.Project;
    end
    
    if length(varargin) < 2
        error('steno3d:trisurfError', 'Not enough input arguments');
    end
    
    if ismatrix(varargin{1}) && size(varargin{1}, 2) == 3 &&            ...
            ismatrix(varargin{2}) && size(varargin{2}, 2) == 3
        verts = varargin{1};
        tris = varargin{2};
        varargin = varargin(3:end);
    else
        error('steno3d:trisurfError', ['Vertices and Triangles are the '...
              'wrong size']);
    end
    
    if ~all(tris(:) == round(tris(:)))
        error('steno3d:trisurfError', 'Triangles must be integers');
    end
    if max(tris(:) > size(verts, 1)) || min(tris(:) < 1)
        error('steno3d:trisurfError', ['Triangles must be integers '    ...
              'between 1 and length(Vertices)']);
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
            error('steno3d:trisurfError', ['Data must be provided with '...
                  'title/value pairs']);
        end
        if ~isnumeric(varargin{i+1}) 
            error('steno3d:trisurfError', 'Data must be the numeric');
        end
        dat = varargin{i+1}(:);
        if length(dat) == size(tris, 1)
            loc = 'CC';
        elseif length(dat) == size(verts, 1)
            loc = 'N';
        else
            error('steno3d:trisurfError', ['Data must be the same '     ...
                  'length as either the number of Triangles or Vertices']);
        end
        data{end+1} = {'Location', loc,                                  ...
                       'Data', {'Title', varargin{i},                    ...
                                'Array', dat}};
    end
    
    surf = steno3d.core.Surface(                                        ...
        'Mesh', steno3d.core.Mesh2D(                                    ...
            'Vertices', verts,                                          ...
            'Triangles', tris                                           ...
        ),                                                              ...
        'Data', data,                                                   ...
        'Opts', {'Color', color}                                        ...
    );

    proj.Resources = [proj.Resources {surf}];
    
    proj.plot();
end
