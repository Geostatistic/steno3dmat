function res = image(ih, tabLevel)
%IMAGE MATLAB image to Steno3D Surface conversion

    if ~isgraphics(ih) || ~strcmp(ih.Type, 'image')
        error('steno3d:convertError', ['steno3d.utils.convert.image '   ...
              'requires graphics input of type "image"']);
    end
    
    res = {};
    
    data = mean(ih.CData, 3);
    
    if length(ih.XData) == 1
        deltax = 1;
    elseif size(data, 2) == 1
        deltax = 3*(ih.XData(2)-ih.XData(1));
    else
        deltax = (ih.XData(2)-ih.XData(1))/(size(data,2)-1);
    end
    
    if length(ih.YData) == 1
        deltay = 1;
    elseif size(data, 1) == 1
        deltax = 3*(ih.YData(2)-ih.YData(1));
    else
        deltay = (ih.YData(2)-ih.YData(1))/(size(data,1)-1);
    end
    
    origin = [ih.XData(1)-deltax/2 ih.YData(1)-deltay/2 0];
    h1 = ones(size(data, 2), 1)*deltax;
    h2 = ones(size(data, 1), 1)*deltay;
    
    data = data';
    data = data(:);
    
    if length(ih.AlphaData) == 1
        alpha = ih.AlphaData;
    else
        alpha = 1;
    end

    if strcmp(ih.Visible, 'on')
        res = [res {                                                    ...
            steno3d.core.Surface(                                       ...
                'Title', ih.Tag,                                        ...
                'Mesh', steno3d.core.Mesh2DGrid(                        ...
                    'H1', h1,                                           ...
                    'H2', h2,                                           ...
                    'O', origin                                         ...
                ),                                                      ...
                'Data', {'Location', 'CC', 'Data', data},               ...
                'Opts', {'Opacity', alpha}                              ...
            )                                                           ...
        }];
    end
end

