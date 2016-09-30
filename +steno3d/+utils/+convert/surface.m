function res = surface(sh)
%SCATTER Summary of this function goes here
%   Detailed explanation goes here
    if ~isgraphics(sh) || ~strcmp(sh.Type, 'surface')
        error('steno3d:convertError', ['steno3d.utils.covnert.surface '       ...
              'requires graphics input of type "surface"']);
    end

    res = {};
    xd = sh.XData;
    yd = sh.YData;
    zd = sh.ZData;
    cd = sh.CData;

    if ndims(cd) == 3
        cd = mean(cd, 3);
    end

    uxd = unique(xd, 'rows');
    uyd = unique(yd', 'rows');
    if size(uxd, 1) == 1 && size(uyd, 1) == 1
        xd = uxd;
        yd = uyd;
    end

    if length(xd) == length(xd(:)) && length(yd) == length(yd(:))

        mesh = steno3d.core.Mesh2DGrid(                                 ...
            'H1', diff(xd(:)),                                          ...
        	'H2', diff(yd(:)),                                          ...
            'O', [xd(1) yd(1) 0],                                       ...
            'Z', zd(:)                                                  ...
        );
        if strcmp(sh.FaceColor, 'flat')
            cdsurf = cd(1:end-1, 1:end-1);
            location = 'CC';
        else
            cdsurf = cd;
            location = 'N';
        end
        xdrect = xd(:)*ones(1, length(yd));
        xdrect = xdrect';
        ydrect = yd(:)*ones(1, length(xd));
        vertices = [xdrect(:) ydrect(:) zd(:)];
        keep = ones(length(vertices), 1);
    else
        vertices = [xd(:) yd(:) zd(:)];
        shp = size(xd);
        triangles = zeros((shp(1)-1)*(shp(2)-1)*2, 3);
        ind = 0;
        for i = 1:shp(2)-1
            for j = 1:shp(1)-1
                
                ind = ind+1;
                triangles(ind, :) = [(i-1)*shp(1)+j-1,                  ...
                                     (i-1)*shp(1)+j,                    ...
                                     i*shp(1)+j-1];
                ind = ind+1;
                triangles(ind, :) = [(i-1)*shp(1)+j,                    ...
                                     i*shp(1)+j,                        ...
                                     i*shp(1)+j-1];
            end
        end
        
        % Remove nans for now
        keep = ~sum(isnan(vertices), 2);
        
        dontkeepind = find(~keep)-1;
        keeptris = true(size(triangles, 1), 1);
        for i = 1:length(dontkeepind)
            keeptris = keeptris & ~sum(triangles == dontkeepind(i), 2);
        end
        triangles = triangles(keeptris, :);
        
        mesh = steno3d.core.Mesh2D(                                     ...
            'Vertices', vertices,                                       ...
            'Triangles', triangles                                      ...
        );
    
        if strcmp(sh.FaceColor, 'flat')
            cdsurf = cd(1:end-1, 1:end-1);
            cdsurf = cdsurf(ceil(.5:.5:end));
            cdsurf = cdsurf(keeptris);
            location = 'CC';
        else
            cdsurf = cd;
            location = 'N';
        end

    end

    if strcmp(sh.EdgeColor, 'none')
        mesh.Opts.Wireframe = false;
    end

    if any(strcmp(sh.FaceColor, {'flat', 'interp', 'none', 'texturemap'}))
        color = 'random';
    else
        color = sh.FaceColor;
    end

    if any(strcmp(sh.FaceAlpha, {'flat', 'interp', 'texturemap'}))
        alpha = 1;
    else
        alpha = sh.FaceAlpha;
    end
    if ~strcmp(sh.EdgeColor, 'none') || ~strcmp(sh.FaceColor, 'none')
        res = [res {                                                    ...
            steno3d.core.Surface(                                       ...
                'Title', sh.DisplayName,                                ...
                'Mesh', mesh,                                           ...
                'Data', {                                               ...
                    'Location', location,                               ...
                    'Data', cdsurf(:)                                   ...
                },                                                      ...
                'Opts', {                                               ...
                    'Color', color,                                     ...
                    'Opacity', alpha                                    ...
                }                                                       ...
            )                                                           ...
        }];
    end




    if strcmp(sh.MarkerFaceColor, 'none')
        mcol = sh.MarkerEdgeColor;
    else
        mcol = sh.MarkerFaceColor;
    end
    if strcmp(mcol, 'auto')
        mcol = 'random';
    end
    if ~strcmp(sh.Marker, 'none') && ~strcmp(mcol, 'none')
        res = [res {                                                    ...
            steno3d.core.Point(                                         ...
                'Title', sh.DisplayName,                                ...
                'Mesh', steno3d.core.Mesh0D(                            ...
                    'Vertices', vertices(keep, :)                       ...
                ),                                                      ...
                'Data', {'Data', cd},                                   ...
                'Opts', {'Color', mcol}                                 ...
            )                                                           ...
        }];
    end




end

