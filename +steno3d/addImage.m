function addImage(varargin)
%ADDIMAGE Add a PNG image to an existing Steno3d resource
%   STENO3D.ADDIMAGE(RESOURCE, PNGFILE, WIDTH, HEIGHT) scales PNG image
%   PNGFILE to size WIDTH x HEIGHT, then projects it in a direction
%   perpendicular to the horizontal plane onto the Steno3D RESOURCE (Point
%   or Surface).
%
%   STENO3D.ADDIMAGE(RESOURCE, PNGFILE, DIR1, DIM1, DIR2, DIM2) scales and
%   reshapes the PNG image PNGFILE so its x-axis lies along DIR1 with
%   length DIM1 and its y-axis lies along DIR2 with length DIM2. DIR1 and
%   DIR2 are either a 1 x 3 vector or 'X', 'Y' or 'Z'. The image is then
%   projected in a direction perpendicular to DIR1 and DIR2 (the
%   DIR1-cross-DIR2 direction) onto the Steno3D RESOURCE.
%
%   STENO3D.ADDIMAGE(..., ORIGIN) shifts the origin of the image by 1 x 3
%   vector ORIGIN, prior to projection onto the RESOURCE.
%
%   STENO3D.ADDIMAGE(..., TITLE) gives the image a TITLE string. If no
%   TITLE is provided, the image will be titled based on the PNG file name.
%
%   Images can only be added to Points or Surfaces. Also, the images are
%   simply projected straight onto the Resource. This is different than
%   MATLAB's 'texturemap' face coloring that wraps the image based on the
%   underlying surface geometry. To map data to the geometry, use
%   <a href="matlab: help steno3d.addData">steno3d.addData</a> instead.
%
%   Example:
%       % Generate a png image
%       [x, y, z] = sphere; surf(x, y, z); h = findobj('Type','surface');
%       load earth; hemisphere = [ones(257,125),X,ones(257,125)];
%       set(h,'CData',flipud(hemisphere),'FaceColor','texturemap');
%       colormap(map); axis equal; view([90 0]);
%       fig = gcf; fig.Position = [fig.Position(1:3) fig.Position(3)];
%       ax = gca; ax.Position = [0 0 1 1];
%       tempFile = [tempname '.png'];
%       print(fig, '-dpng', tempFile);
%       % Create a surface
%       verts = [x(:) y(:) z(:)];
%       tris = convhull(x(:), y(:), z(:));
%       [myProject, mySurface] = steno3d.trisurf(tris, verts);
%       % Add the image
%       STENO3D.ADDIMAGE(mySurface, tempFile,                           ...
%                        'X', 2, 'Z', 2, [-1 -1 -1], 'Hemisphere');
%
%   See also STENO3D.CORE.TEXTURE2DIMAGE, STENO3D.ADDDATA, STENO3D.SCATTER,
%   STENO3D.TRISURF, STENO3D.SURFACE
%


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
        titlesplit = strsplit(pngfile, filesep);
        title = titlesplit{end}(1:end-4);
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

