function proj = figure(fh, combineAxes, combineRes, tabLevel)
%FIGURE MATLAB figure to Steno3D Project conversion

    if ~isgraphics(fh) || ~strcmp(fh.Type, 'figure')
        error('steno3d:convertError', ['steno3d.utils.convert.figure '  ...
              'requires graphics input of type "figure"']);
    end
    fprintf([tabLevel 'Converting MATLAB Figure... ']);
    axes = [];
    for i = 1:length(fh.Children)
        if strcmp(fh.Children(i).Type, 'axes')
            axes = [axes fh.Children(i)];
        end
    end
    proj = [];
    if isempty(axes)
        fprintf(['No axes discovered.\n'                                ...
                 tabLevel '... Nothing to do.\n']);
        return
    end
    fprintf([num2str(length(axes)) ' set(s) of axes discovered.\n']);
    
    for i = 1:length(fh.Children)
        if ~strcmp(fh.Children(i).Type, 'axes')
            fprintf([tabLevel 'Ignoring unsupported graphics type: '    ...
                     fh.Children(i).Type '\n'])
        end
    end

    for i = 1:length(axes)
        p = steno3d.utils.convert.axes(axes(i), combineRes,             ...
                                       [tabLevel '    ']);
        proj = [proj p];
    end
    
    if combineAxes && length(proj) > 1
        proj = steno3d.combine(proj, tabLevel);
        if combineRes
            proj.Resources = steno3d.utils.consolidate(proj.Resources,  ...
                                                       [tabLevel '    ']);
        end
    end

    
    fprintf([tabLevel '... Figure conversion complete!\n']);

end

