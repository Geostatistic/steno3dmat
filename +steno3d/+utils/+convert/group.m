function res = group(gh, tabLevel)
%GROUP MATLAB group to Steno3D Resources conversion

    if ~isgraphics(gh) || ~any(strcmp(gh.Type, {'axes', 'hggroup'}))
        error('steno3d:convertError', ['steno3d.utils.convert.axes '    ...
            'requires graphics input of type "axes" or "hggroup"']);
    end
    res = [];

    for i = 1:length(gh.Children)
        fprintf([tabLevel 'Converting ' gh.Children(i).Type '...\n']);
        switch gh.Children(i).Type
            case 'line'
                r = steno3d.utils.convert.line(gh.Children(i),          ...
                                               [tabLevel '    ']);
            case 'scatter'
                r = steno3d.utils.convert.scatter(gh.Children(i),       ...
                                                  [tabLevel '    ']);
            case 'surface'
                r = steno3d.utils.convert.surface(gh.Children(i),       ...
                                                  [tabLevel '    ']);
            case 'patch'
                r = steno3d.utils.convert.patch(gh.Children(i),         ...
                                                [tabLevel '    ']);
            case 'hggroup'
                r = steno3d.utils.convert.group(gh.Children(i),         ...
                                                [tabLevel '    ']);
            case 'contour'
                r = steno3d.utils.convert.contour(gh.Children(i),       ...
                                                  [tabLevel '    ']);
            case 'image'
                r = steno3d.utils.convert.image(gh.Children(i),         ...
                                                [tabLevel '    ']);
            otherwise
                r = [];
                fprintf([tabLevel '... unsupported type - please see '  ...
                         '"help convert"\n']);
        end
        res = [res r];
    end

end

