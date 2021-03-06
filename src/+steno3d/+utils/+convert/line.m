function res = line(lh, tabLevel)
%LINE MATLAB line to Steno3D Line conversion

    if ~isgraphics(lh) || ~strcmp(lh.Type, 'line')
        error('steno3d:convertError', ['steno3d.utils.convert.line requires ' ...
              'graphics input of type "line"']);
    end

    res = {};
    xdata = lh.XData;
    ydata = lh.YData;
    if isempty(lh.ZData)
        zdata = zeros(size(xdata));
    else
        zdata = lh.ZData;
    end
    if length(xdata) == 1
        xdata = [xdata; xdata];
        ydata = [ydata; ydata];
        zdata = [zdata; zdata];
    end
    vertices = [xdata(:) ydata(:) zdata(:)];
    segments = [1:length(xdata)-1;2:length(xdata)]';

    % Remove nans for now
    keep = ~sum(isnan(vertices), 2);
    keep = keep(1:end-1) & keep(2:end);
    segments = segments(keep, :);


    if ~strcmp(lh.LineStyle, 'none') && ~strcmp(lh.Color, 'none')
        res = [res {                                                    ...
            steno3d.core.Line(                                          ...
                'Title', lh.DisplayName,                                ...
                'Mesh', steno3d.core.Mesh1D(                            ...
                    'Vertices', vertices,                               ...
                    'Segments', segments                                ...
                ),                                                      ...
                'Opts', {'Color', lh.Color}                             ...
            )                                                           ...
        }];
    end

    if strcmp(lh.MarkerFaceColor, 'none')
        mcol = lh.MarkerEdgeColor;
    else
        mcol = lh.MarkerFaceColor;
    end
    if strcmp(mcol, 'auto')
        mcol = lh.Color;
    end
    if ~strcmp(lh.Marker, 'none') && ~strcmp(mcol, 'none')
        res = [res {                                                    ...
            steno3d.core.Point(                                         ...
                'Title', lh.DisplayName,                                ...
                'Mesh', steno3d.core.Mesh0D(                            ...
                    'Vertices', vertices(keep, :)                       ...
                ),                                                      ...
                'Opts', {'Color', mcol}                                 ...
            )                                                           ...
        }];
    end
end

