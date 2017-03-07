function addImage(varargin)
%ADDIMAGE Add a PNG image to an existing Steno3d resource
%   `steno3d.addImage(resource, pngfile, width, height)` scales PNG image
%   `pngfile` to size `width` x `height`, then projects it in a direction
%   perpendicular to the horizontal plane onto the Steno3D `resource`
%   (%%%ref[Point](steno3d.core.Point) or %%%ref[Surface](steno3d.core.Surface)).
%
%   `steno3d.addImage(resource, pngfile, dir1, dim1, dir2, dim2)` scales and
%   reshapes the PNG image `pngfile` so its x-axis lies along `dir1` with
%   length `dim1` and its y-axis lies along `dir2` with length dim2`. `dir1` and
%   `dir2` are either a 1 x 3 vector or 'X', 'Y' or 'Z'. The image is then
%   projected in a direction perpendicular to `dir1` and `dir2` (the
%   `dir1`-cross-`dir2` direction) onto the Steno3D `resource`.
%
%   `steno3d.addImage(..., origin)` shifts the origin of the image by 1 x 3
%   vector `origin`, prior to projection onto the `resource`.
%
%   `steno3d.addImage(..., title)` gives the image a `title` string. If no
%   `title` is provided, the image will be titled based on the PNG file name.
%
%   Images can only be added to Points or Surfaces. Also, the images are
%   simply projected straight onto the Resource. This is different than
%   MATLAB's 'texturemap' face coloring that wraps the image based on the
%   underlying surface geometry. To map data to the geometry, use
%   %%%func[steno3d.addData](steno3d.addData) instead.
%
%   Also, when plotting projects locally, images only show up as dashed
%   outlines at the position they are projected from. To see the result of
%   adding the image, you must upload the project and view it on
%   steno3d.com.
%
%   Example:
%   %%%codeblock
%       % Generate a png image
%       [x, y, z] = sphere; surf(x, y, z); h = findobj('Type', 'surface');
%       load earth; hemisphere = [ones(257,125), X, ones(257,125)];
%       set(h, 'CData', flipud(hemisphere), 'FaceColor', 'texturemap');
%       colormap(map); axis equal; view([90 0]);
%       fig = gcf; fig.Position = [fig.Position(1:3) fig.Position(3)];
%       ax = gca; ax.Position = [0 0 1 1];
%       pngFile = [tempname '.png'];
%       print(fig, '-dpng', tempFile);
%       % Create a surface
%       verts = [x(:) y(:) z(:)];
%       tris = convhull(x(:), y(:), z(:));
%       [proj, sfc] = steno3d.trisurf(tris, verts);
%       % Add the image
%       steno3d.addImage(sfc, pngFile, 'X', 2, 'Z', 2, [-1 -1 -1],      ...
%                        'Hemisphere');
%
%
%   See more %%%ref[EXAMPLES](steno3d.examples.addimage)
%
%   %%%seealso STENO3D.CORE.TEXTURE2DIMAGE, STENO3D.ADDDATA, STENO3D.TRISURF
%


    steno3d.utils.matverchk();
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
    if ~isempty(varargin) && isnumeric(varargin{1}) &&                  ...
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

