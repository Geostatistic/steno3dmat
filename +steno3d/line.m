function [proj, lin] = line(varargin)
%LINE Create and plot a Steno3D Line resource
%   STENO3D.LINE(X, Y, Z) creates a Steno3D <a href="matlab:
%   help steno3d.core.Project">Project</a> with a <a href="matlab:
%   help steno3d.core.Line">Line</a> resource
%   defined by vectors X, Y, and Z. If X, Y, and Z are matrices of the same
%   size, only one Line resource is created but separate columns are
%   disconnected.
%
%   STENO3D.LINE(SEGMENTS, VERTICES) creates a Steno3D Project with a Line
%   resource defined by SEGMENTS, n x 2 matrix of vertex indices, and
%   VERTICES, m x 3 matrix of spatial coordinates. 
%
%   STENO3D.LINE(..., COLOR) creates a Line resource of the given color,
%   where COLOR is a 1x3 RGB color, hex color string, named color string,
%   or 'random'.
%
%   STENO3D.LINE(..., TITLE1, DATA1, ..., TITLEN, DATAN) adds any number of
%   titled datasets to the Line resource. TITLE must be a string and DATA 
%   must be an n x 1 or an m x 1 vector, where n is the number of segments
%   and m is the number of vertices. If m == n, the data location will 
%   default to segments. Data may also be added with <a href="matlab:    
%   help steno3d.addData">steno3d.addData</a>.
%
%   STENO3D.LINE(PROJECT, ...) adds the Line resource to PROJECT, an
%   existing Steno3D Project. PROJECT may also be a figure or axes handle
%   that was created by a Steno3D plotting function.
%
%   PROJECT = STENO3D.LINE(...) returns PROJECT, the Steno3D Project that
%   contains the new Line resource.
%
%   [PROJECT, LINE] = STENO3D.LINE(...) returns PROJECT, the Steno3D
%   Project, and LINE, the new Line resource.
%
%   Unlike the MATLAB builtin <a href=
%   "matlab: help line">line</a> function, STENO3D.LINE requires 3D data
%   and does not support any additional property/value pairs. After
%   creating a Line resource with STENO3D.LINE, properties of the Line
%   object can be directly modified.
%
%   Example:
%       x = 0:pi/10:4*pi;
%       [proj, lin] = STENO3D.LINE(                                     ...
%           x, cos(x), sin(x), 'k', 'Cosine Vert Data', cos(x)          ...
%       );
%       lin.Title = 'Example Line';
%       lin.Description = 'Trig functions with random data';
%       proj.Title = 'Project with one Line';
%       proj.upload()
%
%
%   See more <a href="matlab: help steno3d.examples.line">EXAMPLES</a>
%
%   See also STENO3D.CORE.LINE, STENO3D.CORE.PROJECT, STENO3D.UPLOAD,
%   STENO3D.ADDDATA, STENO3D.CORE.PROJECT
%   


    steno3d.utils.matverchk();
    narginchk(2, inf);
    if isa(varargin{1}, 'steno3d.core.Project')
        proj = varargin{1};
        varargin = varargin(2:end);
    elseif isgraphics(varargin{1})
        if isa(varargin{1}.UserData, 'steno3d.core.Project')
            proj = varargin{1}.UserData;
            varargin = varargin(2:end);
        else
            error('steno3d:lineError',                                  ...
                  'No project associated with given graphics handle');
        end
    else
        proj = steno3d.core.Project;
    end
    if length(varargin) < 2
        error('steno3d:lineError', 'Not enough input arguments');
    end
    if ismatrix(varargin{1}) && size(varargin{1}, 2) == 2 &&            ...
            ismatrix(varargin{2}) && size(varargin{2}, 2) == 3
        segs = varargin{1};
        verts = varargin{2};
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
        data{end+1} = {'Location', loc,                                 ...
                       'Data', {'Title', varargin{i},                   ...
                                'Array', dat}};
    end
    lin = steno3d.core.Line(                                            ...
        'Mesh', steno3d.core.Mesh1D(                                    ...
            'Vertices', verts,                                          ...
            'Segments', segs                                            ...
        ),                                                              ...
        'Data', data,                                                   ...
        'Opts', {'Color', color}                                        ...
    );
    proj.Resources = [proj.Resources {lin}];
    proj.plot();
end
