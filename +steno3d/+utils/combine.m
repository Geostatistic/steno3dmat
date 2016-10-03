function proj = combine(proj)
%COMBINE Summary of this function goes here
%   Detailed explanation goes here

    if isempty(proj) || ~isa(proj(1), 'steno3d.core.Project')
        error('steno3d:convertError', ['steno3d.utils.combine requires '...
              'input of type "steno3d.core.Project"']);
    end

    fprintf([tabLevel 'Combining projects...\n'])
    combProj = steno3d.core.Project('Title', 'MATLAB Project');
    
    for i = 1:length(proj)
        if ~strcmp(proj(i).Title, 'MATLAB Project')
            combProj.Description = [combProj.Description proj(i).Title ', '];
        end
        combProj.Resources = [combProj.Resources proj(i).Resources];
    end
    
    if ~isempty(combProj.Description)
        combProj.Description = ['Includes: '                            ...
                                combProj.Description(1:end-2)];
    end
    proj = combProj;


end

