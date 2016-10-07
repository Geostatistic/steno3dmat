function addImage(varargin)
%ADDIMAGE Summary of this function goes here
%
%   ADDIMAGE(res, png, width, height)
%   ADDIMAGE(res, png, dir1, dim1, dir2, dim2)
%   ADDIMAGE(..., origin)
%   ADDIMAGE(..., title)

    narginchk(4, 8);
    
    res = varargin{1};
    if ~isa(res, 'steno3d.core.Surface') && ~isa(res, 'steno3d.core.Point')
        error('steno3d:addImageError', ['Images can only be applied to '...
              'Steno3D Surface or Point resources']);
    end
    
    pngfile = varargin{2};
    if ~exist(pngfile, 'file') || length(pngfile) < 4 ||                ...
            ~strcmp(pngfile(end-3:end), '.png')
        error('steno3d:addImageError', 'Image must be vaild png file');
    end
    
    if nargin < 6 || ischar(varargin(6))
        w = varargin{3}; h = varargin{4};
        u = 'X'; v = 'Y';
        varargin = varargin(5:end);
    else
        w = varargin{4}; h = varargin{6};
        u = varargin{3}; v = varargin{5};
        varargin = varargin(7:end);
    end
    
    if ~isempty(varargin) && isnumeric(varargin{1}) &&               ...
            all(size(varargin{1}) == [1 3])
        origin = varargin{1};
        varargin = varargin(2:end);
    else
        origin = [0 0 0];
    end
    
    if ~isempty(varargin) && ischar(varargin{1})
        title = varargin{1};
        varargin = varargin(2:end);
    else
        title = '';
    end
    
    if ~isempty(varargin)
        error('steno3d:addImageError', 'Invalid input - unused arguments')
    end
    
    tex = steno3d.core.Texture2DImage('Image', pngfile, 'U', u,         ...
                                      'V', v, 'O', origin, 'Title', title);
    if all(tex.U == 0) || all(tex.V == 0)
        error('steno3d:addImageError', 'Direction vectors cannot be 0');
    end
    tex.U = w*tex.U/sqrt(sum(tex.U.*tex.U));
    tex.V = h*tex.V/sqrt(sum(tex.V.*tex.V));
    
    res.Textures{end+1} = tex;

end

