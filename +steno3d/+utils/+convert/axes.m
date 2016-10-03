function proj = axes(ah, combineRes, tabLevel)
%FIG2STENO Summary of this function goes here
%   Detailed explanation goes here
    if ~isgraphics(ah) || ~strcmp(ah.Type, 'axes')
        error('steno3d:convertError', ['steno3d.utils.convert.axes '    ...
              'requires graphics input of type "axes"']);
    end
    
    title = ah.Title.String;
    if ~isempty(title)
        temptitle = [' "' title '"'];
    else
        temptitle = '';
    end
    fprintf([tabLevel 'Converting MATLAB Axis' temptitle '... ']);
    if isempty(ah.Children)
        fprintf(['No graphics objects discovered.\n' tabLevel           ...
                 '... Nothing to do.\n']);
        proj = [];
        return
    end

    fprintf([num2str(length(ah.Children)) ' graphics '                  ...
             'object(s) discovered.\n']);
    if isempty(title)
        title = 'MATLAB Project';
    end

    proj = steno3d.core.Project('Title', title);
    
    proj.Resources = steno3d.utils.convert.group(ah, [tabLevel '    ']);
    
    if combineRes
        proj.Resources = steno3d.utils.consolidate(proj.Resources,      ...
                                                   [tabLevel '    ']);
    end
    
    if isempty(proj.Resources)
        proj = [];
        fprintf([tabLevel '... No supported graphics objects.\n'])
    else
        fprintf([tabLevel '... Axis conversion complete!\n'])
    end

end

