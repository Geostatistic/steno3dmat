function [proj, surf] = surface(varargin)
%SURFACE Summary of this function goes here
%
%   proj = STENO3D.SURFACE(Z)
%   proj = STENO3D.SURFACE(origin, Z)
%
%   proj = STENO3D.SURFACE(x, y)
%   proj = STENO3D.SURFACE(dir1, ax1, dir2, ax2, origin)
%   proj = STENO3D.SURFACE(..., Z)
%
%   proj = STENO3D.SURFACE(..., color)
%   proj = STENO3D.SURFACE(..., title1, data1, ..., titleN, dataN)
%   proj = STENO3D.SURFACE(..., title1, png1, ..., titleN, pngN)
%   STENO3D.SURFACE(proj, ...)
%   [proj, surf] = STENO3D.SURFACE(...)
%
%   Note - the ordring here differs from MATLAB's builtin surface function.
%   Here, we follow ordering similar to ndgrid rather than meshgrid

    if isempty(varargin)
        error('steno3d:surfaceError', 'Not enough input arguments');
    end

    if isa(varargin{1}, 'steno3d.core.Project')
        proj = varargin{1};
        varargin = varargin(2:end);
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
    elseif length(varargin) > 4 &&                                          ...
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
        'hi'
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


