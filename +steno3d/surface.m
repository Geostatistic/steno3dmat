function [proj, surf] = surface(varargin)
%SURFACE Create and plot a gridded Steno3D Surface resource
%   STENO3D.SURFACE(Z) creates a Steno3D Project with a Surface grid
%   resource. Heights are defined by Z, an m x n matrix. Values are plotted
%   with unit spacing, where x and y values equal 0:m-1 and 0:n-1,
%   respectively.
%
%   STENO3D.SURFACE(Origin, Z) creates a Steno3D Project with a Surface
%   resource. Origin is a 1 x 3 vector offset; x and y values correspond to
%   Origin(1) + (0:m-1) and Origin(2) + (0:n-1), and heights equal to
%   Z + Origin(3).
%
%
%   STENO3D.SURFACE(X, Y) creates a Steno3D Project with a flat grid
%   Surface in the horizontal plane with x and y node values corresponding
%   to vectors X and Y, respectively.
%
%   STENO3D.SURFACE(Dir1, H1, Dir2, H2, Origin) creates a Steno3D Project
%   with a flat grid Surface in an arbitrary plane. The plane is defined by
%   1 x 3 axes vectors, Dir1 and Dir2, node locations along those axes, H1
%   and H2, and a 1 x 3 Origin vector. Dir1 and Dir2 may also be 'X', 'Y',
%   or 'Z' in addition to 1 x 3 axes. For example, the following all
%   produce the same result:
%       STENO3D.SURFACE(0:10, 0:20)
%       STENO3D.SURFACE([1 0 0], 0:10, [0 1 0], 0:20, [0 0 0])
%       STENO3D.SURFACE('X', 0:10, 'Y', 0:20, [0 0 0])
%
%   STENO3D.SURFACE(..., Z) creates a Steno3D Project and Surface grid with
%   node heights Z, an n x m matrix, where m is the length of X/H1 and n is
%   the length of Y/H2. Z may also be a length m*n vector.
%
%
%   STENO3D.SURFACE(..., Color) creates a Surface resource of the given
%   color, where Color is a 1x3 RGB color, hex color string, named color
%   string, or 'random'.
%
%   STENO3D.SURFACE(..., Title1, Data1, ..., TitleN, DataN) adds any number
%   of titled datasets to the Surface resource. Title must be a string and
%   Data must be a matrix of size m x n or m*n x 1 for node data or a
%   matrix of size (m-1) x (n-1) or (m-1)*(n-1) x 1 for face data, where n
%   is the length(X), length(H1), or size(Z, 1) and m is the length(Y),
%   length(H2), or size(Z, 2). (For more details see <a href="matlab:    
%   help steno3d.addData">steno3d.addData</a>)
%
%   STENO3D.SURFACE(..., Title1, Png1, ..., TitleN, PngN) adds any number
%   of titled images to the Surface resource. Title must be a string and 
%   Png must be a png file. The image will be stretched to span the 
%   entire grid surface. Any number of datasets and textures may be applied
%   to an individual Surface. (For more details see <a href="matlab:    
%   help steno3d.addImage">steno3d.addImage</a>)
%
%   STENO3D.SURFACE(Proj, ...) adds the Surface resource to Proj, an
%   existing Steno3D Project. Proj may also be a figure or axes handle that
%   was created by a Steno3D plotting function.
%
%   Proj = STENO3D.SURFACE(...) returns Proj, the Steno3D Project that
%   contains the new Surface resource.
%
%   [Proj, Surf] = STENO3D.SURFACE(...) returns Proj, the Steno3D Project,  
%   Surf, the new Surface resource.
%
%   An important difference between STENO3D.SURFACE the MATLAB builtin
%   <a href="matlab: help surface
%   ">surface</a> function is data ordering. This function uses ordering produced
%   by the function <a href="matlab: help ndgrid
%   ">ndgrid</a>, where size(Z) == [length(x) length(y)].
%   The builtin surface function uses ordering produced by the function
%   <a href="matlab: help meshgrid
%   ">meshgrid</a>, where size(Z) = [length(y) length(x)]. Also,
%   STENO3D.SURFACE does not support additional property/value pairs; after
%   creating the Surface, its properties may be directly modified.
%
%   Example:
%       pngFile = [tempname '.png'];
%       imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
%       [myProject, mySurface] = STENO3D.SURFACE(                       ...
%           'X', 0:20, 'Z', 0:25, [0 0 -25], rand(21, 26), 'k',         ...
%           'Increasing Numbers', 1:20*25, 'Space Image', pngFile       ...
%       );
%       mySurface.Title = 'Space Image';
%       mySurface.Description = ['Vertical surface with some random '   ...
%                                'bumps and a space image'];
%       myProject.Title = 'Project with one Surface';
%       myProject.Pulbic = true;
%       steno3d.upload(myProject);
%
%   See also STENO3D.CORE.SURFACE, STENO3D.UPLOAD, STENO3D.ADDDATA,
%   STENO3D.ADDIMAGE, STENO3D.CORE.PROJECT
%


    if isempty(varargin)
        error('steno3d:surfaceError', 'Not enough input arguments');
    end

    if isa(varargin{1}, 'steno3d.core.Project')
        proj = varargin{1};
        varargin = varargin(2:end);
    elseif isgraphics(varargin{1})
        if isa(varargin{1}.UserData, 'steno3d.core.Project')
            proj = varargin{1}.UserData;
            varargin = varargin(2:end);
        else
            error('steno3d:surfaceError',                               ...
                  'No project associated with given graphics handle');
        end
    else
        proj = steno3d.core.Project;
    end

    if isempty(varargin)
        error('steno3d:surfaceError', 'Not enough input arguments');
    end
    
    x = [];
    y = [];
    Z = [];
    
    origin = [0 0 0];
    u = 'X';
    v = 'Y';
    
    if length(varargin) > 1 &&                                          ...
            ismatrix(varargin{2}) && all(size(varargin{2}) > 1)
        origin = varargin{1};
        if ismatrix(origin) || all(size(origin) == [1 3])
            varargin = varargin(2:end);
        else
            error('steno3d:surfaceError', 'Invalid origin');
        end
    end
    if isempty(varargin)
        error('steno3d:surfaceError', 'Not enough input arguments');
    end
    
    if ismatrix(varargin{1}) && all(size(varargin{1}) > 1)
        x = 0:size(varargin{1}, 1)-1;
        y = 0:size(varargin{1}, 2)-1;
    elseif length(varargin) > 4 &&                                      ...
            validDir(varargin{1}) &&  validDir(varargin{3}) &&          ...
            validAx(varargin{2}) && validAx(varargin{4})
        if isempty(varargin{5})
            origin = [0 0 0];
        else
            origin = varargin{5};
        end
        if ismatrix(origin) || all(size(origin) == [1 3])
            u = varargin{1}; v = varargin{3};
            x = varargin{2}; y = varargin{4};
            varargin = varargin(6:end);
        else
            error('steno3d:surfaceError', 'Invalid origin');
        end
    elseif length(varargin) > 1 &&                                      ...
            validAx(varargin{1}) && validAx(varargin{2})
        x = varargin{1}; y = varargin{2};
        varargin = varargin(3:end);
    end
    
    if isempty(x)
        error('steno3d:surfaceError', 'Invalid input arguments');
    end
    
    if ~isempty(varargin) && validSize(length(x), length(y), varargin{1})
        Z = varargin{1};
        varargin = varargin(2:end);
    end
    
    if rem(length(varargin), 2) == 1
        if ~props.Color.isValid(varargin{1})
            error('steno3d:surfaceError', 'Invalid color')
        end
        color = varargin{1};
        varargin = varargin(2:end);
    else
        color = 'random';
    end
    
    if ~isempty(varargin) && ~ischar(varargin{1})
        error('steno3d:surfaceError', ['Invalid input arguments - '     ...
              'possibly Z matrix is incorrect size']);
    end
    
    mesh = steno3d.core.Mesh2DGrid(                                     ...
        'H1', diff(x(:)),                                               ...
        'H2', diff(y(:)),                                               ...
        'U', u,                                                         ...
        'V', v                                                          ...
    );
    mesh.O = origin + x(1)*mesh.U/sqrt(sum(mesh.U.*mesh.U))             ...
                    + y(1)*mesh.V/sqrt(sum(mesh.V.*mesh.V));            ...
    if ~isempty(Z)
        mesh.Z = Z(:);
    end
    
    
    data = {};
    textures = {};
    for i = 1:2:length(varargin)
        if ~ischar(varargin{i})
            error('steno3d:surfaceError', 'Data titles must be strings');
        end
        if ischar(varargin{i+1})
            pngfile = varargin{i+1};
            
            if ~exist(pngfile, 'file') || length(pngfile) < 4 ||        ...
                    ~strcmp(pngfile(end-3:end), '.png')
                error('steno3d:surfaceError',                           ...
                      'Image must be vaild png file');
            end
            textures{end+1} = {                                         ...
                'Image', pngfile,                                       ...
                'O', mesh.O,                                            ...
                'U', sum(mesh.H1)*mesh.U/sqrt(sum(mesh.U.*mesh.U)),     ...
                'V', sum(mesh.H2)*mesh.V/sqrt(sum(mesh.V.*mesh.V))      ...
            };
            
        elseif isnumeric(varargin{i+1})
            dat = varargin{i+1}(:);
            if validSize(length(x), length(y), dat)
                loc = 'N';
            elseif validSize(length(x)-1, length(y)-1, dat)
                loc = 'CC';
            else
                error('steno3d:surfaceError', ['Data must be the same ' ...
                      'length as either the number of Vertices or Faces']);
            end
            data{end+1} = {'Location', loc,                              ...
                           'Data', {'Title', varargin{i},                ...
                                    'Array', dat}};
        else
            error('steno3d:volumeError', 'Data must be numeric');
        end
        
    end
    
    
    surf = steno3d.core.Surface(                                        ...
        'Mesh', mesh,                                                   ...
        'Data', data,                                                   ...
        'Textures', textures,                                           ...
        'Opts', {'Color', color}                                        ...
    );

    proj.Resources = [proj.Resources {surf}];
    
    proj.plot();
end

function valid = validDir(dir)
    if any(strcmpi(dir, {'X', 'Y', 'Z'}))
        valid = true;
        return
    end
    if ismatrix(dir) && all(size(dir) == [1 3])
        valid = true;
        return
    end
    valid = false;
end

function valid = validAx(ax)
    if ismatrix(ax) && length(ax) == length(ax(:)) && length(ax) > 1 && ...
            any(ax(:) ~= 0)
        valid = true;
        return
    end
    valid = false;
end
    
function valid = validSize(lenx, leny, data)
    if ismatrix(data) && all([lenx leny] == size(data))
        valid = true;
        return
    end
    
    if length(data) == length(data(:)) &&                               ...
            lenx * leny == length(data)
        valid = true;
        return
    end
    valid = false;
end


