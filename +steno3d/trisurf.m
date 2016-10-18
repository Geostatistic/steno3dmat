function [proj, surf] = trisurf(varargin)
%TRISURF Create and plot a triangulated Steno3D Surface resource
%   STENO3D.TRISURF(TRIANGLES, X, Y, Z) creates a Steno3D Project with a
%   Surface resource of triangulated faces. The surface is defined by
%   TRIANGLES, n x 3 matrix of vertex indices, and X, Y, and Z, equal-sized
%   vectors of vertex coordinates.
%
%   STENO3D.TRISURF(TRIANGLES, VERTICES) creates a Steno3D Project with a
%   Surface resource defined by TRIANGLES, n x 3 matrix of vertex indices,
%   and VERTICES, m x 3 matrix of spatial coordinates.
%
%   STENO3D.TRISURF(..., COLOR) creates a Surface resource of the given
%   color, where COLOR is a 1x3 RGB color, hex color string, named color
%   string, or 'random'.
%
%   STENO3D.TRISURF(..., TITLE1, DATA1, ..., TITLEN, DATAN) adds any number
%   of titled datasets to the Surface resource. TITLE must be a string and
%   DATA must be an n x 1 or an m x 1 vector, where n is the number of
%   triangles and m is the number of vertices. If m == n, the data location
%   will default to triangles (to override this see <a href="matlab:    
%   help steno3d.addData">steno3d.addData</a>).
%
%   STENO3D.TRISURF(PROJECT, ...) adds the Surface resource to PROJECT, an
%   existing Steno3D Project. PROJECT may also be a figure or axes handle
%   that was created by a Steno3D plotting function.
%
%   PROJECT = STENO3D.TRISURF(...) returns PROJECT, the Steno3D Project that
%   contains the new Surface resource.
%
%   [PROJECT, SURFACE] = STENO3D.TRISURF(...) returns PROJECT, the Steno3D
%   Project, and SURFACE, the new Surface resource.
%
%   STENO3D.TRISURF is useful in conjunction with MATLAB triangulation
%   functions like <a href="matlab: help convhull"
%   >convhull</a>. Unlike the MATLAB builtin <a
%   href="matlab: help trisurf">trisurf</a>,
%   STENO3D.TRISURF does not currently support triangulation objects, nor
%   does it support any additional property/value pairs. After creating a
%   Surface resource with STENO3D.TRISURF, properties of the Surface object
%   can be directly modified.
%
%   Example:
%       x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
%       tris = convhull(x, y, z);
%       [myProject, mySurface] = STENO3D.TRISURF(                       ...
%           tris, x, y, z, 'r', 'Face Data', rand(4, 1)                 ...
%       );
%       mySurface.Title = 'Triangulated Surface';
%       mySurface.Description = 'Convex hull triangles';
%       myProject.Title = 'Project with one Surface';
%       myProject.Public = true;
%       steno3d.upload(myProject)
%
%   See also STENO3D.CORE.SURFACE, STENO3D.UPLOAD, STENO3D.ADDDATA,
%   STENO3D.ADDIMAGE, STENO3D.CORE.PROJECT
%


    steno3d.utils.matverchk();
    
    if isempty(varargin)
        error('steno3d:trisurfError', 'Not enough input arguments');
    end
    if isa(varargin{1}, 'steno3d.core.Project')
        proj = varargin{1};
        varargin = varargin(2:end);
    elseif length(varargin{1}(:)) == 1 && isgraphics(varargin{1})
        if isa(varargin{1}.UserData, 'steno3d.core.Project')
            proj = varargin{1}.UserData;
            varargin = varargin(2:end);
        else
            error('steno3d:trisurfError',                               ...
                  'No project associated with given graphics handle');
        end
    else
        proj = steno3d.core.Project;
    end
    
    if length(varargin) < 2
        error('steno3d:trisurfError', 'Not enough input arguments');
    end
    
    if ismatrix(varargin{1}) && size(varargin{1}, 2) == 3 
        tris = varargin{1};
        varargin = varargin(2:end);
    else
        error('steno3d:trisurfError', 'Triangles is the wrong size');
    end
    
    if length(varargin) > 2 && isnumeric(varargin{1}) &&                ...
            isnumeric(varargin{2}) && isnumeric(varargin{3}) &&         ...
            length(varargin{1}(:)) == length(varargin{2}(:)) &&         ...
            length(varargin{1}(:)) == length(varargin{3}(:))
        verts = [varargin{1}(:) varargin{2}(:) varargin{3}(:)];
        varargin = varargin(4:end);
    elseif ismatrix(varargin{1}) && size(varargin{1}, 2) == 3
        verts = varargin{1};
        varargin = varargin(2:end);
    else
        error('steno3d:trisurfError', ['Triangles and Vertices are the '...
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
        data{end+1} = {'Location', loc,                                 ...
                       'Data', {'Title', varargin{i},                   ...
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
