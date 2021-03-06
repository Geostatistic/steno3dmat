function res = patch(ph, tabLevel)
%PATCH MATLAB patch to Steno3D Surface conversion

    if ~isgraphics(ph) || ~strcmp(ph.Type, 'patch')
        error('steno3d:convertError', ['steno3d.utils.convert.patch '   ...
              'requires graphics input of type "patch"']);
    end

    res = {};
    if isempty(ph.Vertices)
        xd = ph.XData;
        yd = ph.YData;
        zd = ph.ZData;
        if isempty(zd)
            zd = zeros(size(xd));
        end
        vert = [xd(:) yd(:) zd(:)];
        faces = 1:length(xd);
        faces = reshape(faces, size(xd))';
    else
        vert = ph.Vertices;
        if size(vert, 2) == 2
            vert = [vert zeros(size(vert,1), 1)];
        end
        faces = ph.Faces;
    end
    
    color = 'random';
    cd = ph.FaceVertexCData;
    hascd = true;
    if isempty(cd)
        hascd = false;
    end
%     elseif size(cd, 1) == 1
%         color = cd;
%         hascd = false;
    if size(cd, 2) == 3
        cd = mean(cd, 2);
    end
    
    if strcmp(ph.FaceColor,'flat') && size(cd, 1) == size(vert, 1) && hascd
        cd = cd(faces(:, 1));
    end
    if size(cd, 1) == size(faces, 1) && size(faces, 2) > 3 && hascd
        cd = repmat(cd, 1, size(faces, 2)-2)';
        cd = cd(:);
    end
    if size(faces, 2) > 3
        ff = size(faces, 2)-2;
        newFaces = zeros(size(faces, 1)*ff, 3);
        for i = 1:size(faces, 1)
            newFaces((i-1)*ff+(1:ff), 1:3) = [                          ...
                faces(i, 1)*ones(ff, 1)                                 ...
                faces(i, 2:end-1)'                                      ...
                faces(i, 3:end)'                                        ...
            ];
        end
        faces = newFaces;
    end
    
    if strcmp(ph.FaceColor, 'flat') && hascd
        assert(length(cd) == size(faces, 1));
        location = 'CC';
    elseif hascd
        assert(length(cd) == size(vert, 1));
        location = 'N';
    end

    if strcmp(ph.EdgeColor, 'none')
        mesh.Opts.Wireframe = false;
    end

    if ~any(strcmp(ph.FaceColor, {'flat', 'interp', 'none'}))
        color = ph.FaceColor;
    end

    if any(strcmp(ph.FaceAlpha, {'flat', 'interp'}))
        alpha = 1;
    else
        alpha = ph.FaceAlpha;
    end
    if ~strcmp(ph.EdgeColor, 'none') || ~strcmp(ph.FaceColor, 'none')
        if size(faces, 2) == 3
            res = [res {                                                ...
                steno3d.core.Surface(                                   ...
                    'Title', ph.DisplayName,                            ...
                    'Mesh', steno3d.core.Mesh2D(                        ...
                        'Vertices', vert,                               ...
                        'Triangles', faces                              ...
                    ),                                                  ...
                    'Opts', {                                           ...
                        'Color', color,                                 ...
                        'Opacity', alpha                                ...
                    }                                                   ...
                )                                                       ...
            }];
        elseif size(faces, 2) == 2
            res = [res {                                                ...
                steno3d.core.Line(                                   ...
                    'Title', ph.DisplayName,                            ...
                    'Mesh', steno3d.core.Mesh1D(                        ...
                        'Vertices', vert,                               ...
                        'Segments', faces                               ...
                    ),                                                  ...
                    'Opts', {                                           ...
                        'Color', color,                                 ...
                        'Opacity', alpha                                ...
                    }                                                   ...
                )                                                       ...
            }];
        else
            res = [res {                                                ...
                steno3d.core.Points(                                    ...
                    'Title', ph.DisplayName,                            ...
                    'Mesh', steno3d.core.Mesh0D(                        ...
                        'Vertices', vert(faces, :)                      ...
                    ),                                                  ...
                    'Opts', {                                           ...
                        'Color', color,                                 ...
                        'Opacity', alpha                                ...
                    }                                                   ...
                )                                                       ...
            }];
        end
        
        if hascd
            res{end}.Data = {                                           ...
                'Location', location,                                   ...
                'Data', cd(:)                                           ...
            };  
        end
    end

    if strcmp(ph.MarkerFaceColor, 'none')
        mcol = ph.MarkerEdgeColor;
    else
        mcol = ph.MarkerFaceColor;
    end
    if strcmp(mcol, 'auto')
        mcol = 'random';
    end
    if ~strcmp(ph.Marker, 'none') && ~strcmp(mcol, 'none')
        res = [res {                                                    ...
            steno3d.core.Point(                                         ...
                'Title', ph.DisplayName,                                ...
                'Mesh', steno3d.core.Mesh0D(                            ...
                    'Vertices', vert                                    ...
                ),                                                      ...
                'Opts', {'Color', mcol}                                 ...
            )                                                           ...
        }];
    end
end

