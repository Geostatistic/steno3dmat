function res = scatter(sh, tabLevel)
%SCATTER Summary of this function goes here
%   Detailed explanation goes here
    if ~isgraphics(sh) || ~strcmp(sh.Type, 'scatter')
        error('steno3d:convertError', ['steno3d.utils.convert.scatter ' ...
              'requires graphics input of type "scatter"']);
    end

    res = {};
    xdata = sh.XData;
    ydata = sh.YData;
    if isempty(sh.ZData)
        zdata = zeros(size(xdata));
    else
        zdata = sh.ZData;
    end
    vertices = [xdata; ydata; zdata]';

    cdata = sh.CData;
    if length(cdata) == 3 && length(xdata) ~= 3
        color = cdata;
        cdata = [];
    elseif length(cdata) == 3 && all(cdata >=0) && all(cdata <= 1)
        color = cdata;
    else
        color = 'random';
    end

    if ~strcmp(sh.Marker, 'none')
        pt = steno3d.core.Point(                                        ...
                'Title', sh.DisplayName,                                ...
                'Mesh', steno3d.core.Mesh0D(                            ...
                    'Vertices', vertices                                ...
                ),                                                      ...
                'Opts', {'Color', color}                                ...
            );
        if ~isempty(cdata)
            pt.Data = {'Data', cdata};
        end
        res = [res {pt}];
    end


end

