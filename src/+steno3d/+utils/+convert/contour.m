function res = contour(ch, tabLevel, flatten)
%CONTOUR MATLAB contour to Steno3D Line conversion

    if ~isgraphics(ch) || ~strcmp(ch.Type, 'contour')
        error('steno3d:convertError', ['steno3d.utils.convert.contour ' ...
              'requires graphics input of type "contour"']);
    end
    
    if nargin < 3
        flatten = false;
    end
    
    res = {};
    cm = ch.ContourMatrix;
    pointer = 1;
    verts = zeros(0, 3);
    segs = zeros(0, 2);
    while true
        npts = cm(2, pointer);
        segs = [segs; size(verts, 1)+[(1:npts-1)' (2:npts)']];
        verts = [verts; [cm(:, pointer+(1:npts))'                       ...
                         ones(npts, 1)*cm(1, pointer)]];
        pointer = pointer + npts + 1;
        if pointer > size(cm, 2)
            break
        end
    end
    data = verts(:, 3);
    if flatten
        verts(:, 3) = 0;
    end
    
    if strcmp(ch.LineColor, 'flat') || strcmp(ch.LineColor, 'none')
        color = 'k';
    else
        color = ch.LineColor;
    end

    if ~strcmp(ch.LineStyle, 'none')
        res = [res {                                                    ...
            steno3d.core.Line(                                          ...
                'Title', ch.DisplayName,                                ...
                'Mesh', steno3d.core.Mesh1D(                            ...
                    'Vertices', verts,                                  ...
                    'Segments', segs                                    ...
                ),                                                      ...
                'Data', {'Location', 'N', 'Data', data},                ...
                'Opts', {'Color', color}                                ...
            )                                                           ...
        }];
    end
end

