function res = surface(sh, tabLevel)
%SURFACE Matlab surface to steno3d Surface conversion

    if ~isgraphics(sh) || ~strcmp(sh.Type, 'surface')
        error('steno3d:convertError', ['steno3d.utils.convert.surface ' ...
              'requires graphics input of type "surface"']);
    end

    res = {};
    xd = sh.XData;
    yd = sh.YData;
    zd = sh.ZData;
    cd = sh.CData;
    
    if isempty(cd)
        hascd = false;
    else
        hascd = true;
    end
    if ndims(cd) == 3
        cd = mean(cd, 3);
    end
    
%     uxd = unique(xd, 'rows');
%     uyd = unique(yd', 'rows');
%     if size(uxd, 1) == 1 && size(uyd, 1) == 1
%         xd = uxd;
%         yd = uyd;
%     end
% 
%     if length(xd) == length(xd(:)) && length(yd) == length(yd(:))
% 
%         mesh = steno3d.core.Mesh2DGrid(                                 ...
%             'H1', diff(xd(:)),                                          ...
%         	  'H2', diff(yd(:)),                                          ...
%             'O', [xd(1) yd(1) 0],                                       ...
%             'Z', zd(:)                                                  ...
%         );
%     
%         if strcmp(sh.FaceColor, 'flat') && hascd
%             cdsurf = cd(1:end-1, 1:end-1);
%             location = 'CC';
%         elseif hascd
%             cdsurf = cd;
%             location = 'N';
%         end
%         xdrect = xd(:)*ones(1, length(yd));
%         xdrect = xdrect';
%         ydrect = yd(:)*ones(1, length(xd));
%         vertices = [xdrect(:) ydrect(:) zd(:)];
%         keep = ones(length(vertices), 1);
%     else
        vertices = [xd(:) yd(:) zd(:)];
        shp = size(xd);
        triangles = zeros((shp(1)-1)*(shp(2)-1)*2, 3);
        ind = 0;
        for i = 1:shp(2)-1
            for j = 1:shp(1)-1
                
                ind = ind+1;
                triangles(ind, :) = [(i-1)*shp(1)+j,                    ...
                                     (i-1)*shp(1)+j+1,                  ...
                                     i*shp(1)+j];
                ind = ind+1;
                triangles(ind, :) = [(i-1)*shp(1)+j+1,                  ...
                                     i*shp(1)+j+1,                      ...
                                     i*shp(1)+j];
            end
        end
        
        % Remove nans for now?
        keep = ~sum(isnan(vertices), 2);
        keeptris = true(size(triangles, 1), 1);
        
        removeNans = false;
        
        if removeNans
            dontkeepind = find(~keep)-1;
            for i = 1:length(dontkeepind)
                keeptris = keeptris & ~sum(triangles == dontkeepind(i), 2);
            end
            triangles = triangles(keeptris, :);
        end
        
        mesh = steno3d.core.Mesh2D(                                     ...
            'Vertices', vertices,                                       ...
            'Triangles', triangles                                      ...
        );
    
        if strcmp(sh.FaceColor, 'flat') && hascd
            cdsurf = cd(1:end-1, 1:end-1);
            cdsurf = cdsurf(ceil(.5:.5:end));
            cdsurf = cdsurf(keeptris);
            location = 'CC';
        elseif hascd
            cdsurf = cd;
            location = 'N';
        end
%     end

    if ~strcmp(sh.EdgeColor, 'none')
        mesh.Opts.Wireframe = true;
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
                'Opts', {                                               ...
                    'Color', color,                                     ...
                    'Opacity', alpha                                    ...
                }                                                       ...
            )                                                           ...
        }];
        if hascd
            res{end}.Data = {                                           ...
                    'Location', location,                               ...
                    'Data', cdsurf(:)                                   ...
                };
            
        end
                
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
                'Opts', {'Color', mcol}                                 ...
            )                                                           ...
        }];
        if hascd
            res{end}.Data = {                                           ...
                    'Data', cd                                          ...
                };
            
        end
    end




end

