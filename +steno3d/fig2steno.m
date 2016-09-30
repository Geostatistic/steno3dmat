function [proj, fail] = fig2steno(gh, public, combine, tabLevel)
%FIG2STENO Summary of this function goes here
%   Detailed explanation goes here
    
    if nargin < 2
        public = false;
    end
    if nargin < 3
        combine = false;
    end
    if nargin < 4
        tabLevel = '';
    end

    if ~isgraphics(gh)
        error('steno3d:matlabFigureError', ['Input to fig2steno must '  ...
              'be a graphics handle - ideally a figure or axis']);
    end
    fail = 0;
    if strcmp(gh.Type, 'figure')
        fprintf([tabLevel 'Converting MATLAB Figure... ']);
        axes = [];
        for i = 1:length(gh.Children)
            if strcmp(gh.Children(i).Type, 'axes')
                axes = [axes gh.Children(i)];
            end
        end
        proj = [];
        if isempty(axes)
            fprintf(['No axes discovered.\n'                            ...
                     tabLevel '... Nothing to do.\n']);
            fail = 1;
            return
        end
        fprintf([num2str(length(axes)) ' set(s) of axes discovered.\n']);
             
        for i = 1:length(axes)
            [p, f] = steno3d.fig2steno(axes(i), public, false,          ...
                                       [tabLevel '    ']);
            fail = fail + f;
            proj = [proj p];
        end
        
        if combine && length(proj) > 1
            fprintf([tabLevel 'Combining all axes into one project.\n'])
            combProj = steno3d.core.Project(                            ...
                'Title', 'Untitled MATLAB Project',                     ...
                'Public', public                                        ...
            );
            for i = 1:length(proj)
                if ~strcmp(proj(i).Title, 'Untitled MATLAB Project')
                    combProj.Description = [combProj.Description        ...
                                            proj(i).Description ', '];
                end
                combProj.Resources = [combProj.Resources                ...
                                      proj(i).Resources];
            end
            if ~isempty(combProj.Description)
                combProj.Description = ['Includes: '                    ...
                                        combProj.Description(1:end-2)];
            end
            proj = combProj;
        end
        
        fprintf([tabLevel '... Figure conversion complete!\n']);
        
    elseif strcmp(gh.Type, 'axes')
        title = gh.Title.String;
        if ~isempty(title)
            temptitle = ' "title"';
        else
            temptitle = '';
        end
        fprintf([tabLevel 'Converting MATLAB Axis' temptitle '... ']);
        if isempty(gh.Children)
            fprintf(['No graphics objects discovered.\n' tabLevel       ...
                     '... Nothing to do.\n']);
            proj = [];
            fail = 1;
            return
        end
        
        fprintf([num2str(length(gh.Children)) ' graphics '         ...
                 'object(s) discovered.\n']);
        if isempty(title)
            title = 'Untitled MATLAB Project';
        end
        
        proj = steno3d.core.Project('Title', title, 'Public', public);
        
        for i = 1:length(gh.Children)
            [res, f] = steno3d.utils.convert.toStenoRes(gh.Children(i), ...
                                                        [tabLevel '    ']);
            fail = fail + f;
            proj.Resources = [proj.Resources res];
        end
        if isempty(proj.Resources)
            proj = [];
            fprintf([tabLevel '... No supported graphics objects.\n'])
        else
            fprintf([tabLevel '... Axis conversion complete!\n'])
        end
        
    else
        fprintf([tabLevel 'Converting MATLAB graphics object to "'      ...
                 'Steno3D...\n']);
        [res, fail] = steno3d.utils.convert.toStenoRes(gh, '    ');
        if ~isempty(res) 
            proj = steno3d.core.Project('Title', 'MATLAB Graphic',      ...
                                        'Public', 'public',             ...
                                        'Resources', res);
        else
            proj = [];
        end
        
    end
    
    if fail > 0 && isempty(tabLevel)
        fprintf(['\nIf you would like to see additional support please' ...
                '\nsubmit an issue on <a href="matlab: web('            ...
                '''https://github.com/3ptscience/steno3dmat/issues'','  ...
                '''-browser'')">github</a> or consider <a href="matlab:'...
                ' web(''https://github.com/3ptscience/steno3dmat'','    ...
                '''-browser'')">contributing</a>.\n'])
    end


end

