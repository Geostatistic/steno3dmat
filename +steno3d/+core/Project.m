classdef Project < steno3d.core.UserContent
%PROJECT Steno3D Project contains composite resources and can be uploaded

    properties (Hidden, SetAccess = immutable)
        ProjProps = {                                                   ...
            struct(                                                     ...
                'Name', 'Public',                                       ...
                'Type', @props.Bool,                                    ...
                'Doc', 'Public visibility of the project',              ...
                'DefaultValue', false,                                  ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Resources',                                    ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Project Resources',                             ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.CompositeResource,           ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', true                                        ...
            )                                                           ...
        }
    end
    
    properties (Hidden)
        PR__ax = []
    end

    methods
        function obj = Project(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end

        function url = upload(obj)
            obj.validate()
            obj.quotaCheck(obj.Public);
            obj.uploadContent('');
            user = steno3d.utils.User.currentUser();
            uidsplit = strsplit(obj.PR__uid, ':');
            url = strjoin([user.Endpoint 'app/' uidsplit(2)], '');
            fprintf(['<a href="matlab: '                                ...
                    'web(''' url ''', ''-browser'')"'...
                    '>View Project</a>\n'])
        end

        function fig = plot(obj, ax)
            obj.validate();
            if nargin < 2
                ax = obj.PR__ax;
                if ~isempty(ax) && isgraphics(ax) &&                    ...
                        strcmp(ax.Type,'axes') && ax.UserData == obj
                    cla(ax);
                else
                    fig = figure('NumberTitle', 'off',                  ...
                                 'Name', 'Steno3D Project');
                    fig.UserData = obj;
                    ax = axes;
                    ax.UserData = obj;
                end
            end
            
            obj.PR__ax = ax;
            hold(ax, 'on');
            title(ax, obj.Title);
            legendStr = {};
            legendHandle = [];
            for i = 1:length(obj.Resources)
                obj.Resources{i}.plot(ax);
                legendHandle(i) = ax.Children(1);
                t = obj.Resources{i}.Title;
                if isempty(t)
                    t = 'Untitled';
                end
                dtstr = [num2str(length(obj.Resources{i}.Data))         ...
                         ' Dataset(s)'];
                if length(obj.Resources{i}.findprop('Textures')) == 1
                    dtstr = [dtstr ', '                                 ...
                             num2str(length(obj.Resources{i}.Textures)) ...
                             ' Texture(s)'];
                    for j = 1:length(obj.Resources{i}.Textures)
                        tex = obj.Resources{i}.Textures{j};
                        rect = [tex.O;                                  ...
                                tex.O + tex.U;                          ...
                                tex.O + tex.U + tex.V;                  ...
                                tex.O + tex.V;                          ...
                                tex.O];
                        plot3(rect(:, 1), rect(:, 2), rect(:, 3), 'k--');
                    end
                end
                
                mc = metaclass(obj.Resources{i});
                cls = strsplit(mc.Name, '.');
                cls = cls{end};
                legendStr{i} = [t ' (' cls '): ' dtstr];
                
            end
            legend(legendHandle, legendStr{:});
        end
    end

    methods (Hidden)
        function mapi = modelAPILocation(obj)
            mapi = 'project/steno3d';
        end

        function validator(obj)
            for i = 1:length(obj.Resources)
                mc = metaclass(obj.Resources{i});
                if strcmp(mc.Name, 'steno3d.core.CompositeResource')
                    error('steno3d:projectError', ['Project Resources ' ...
                          'cannot be instances of CompositeResource - ' ...
                          'they must be subclasses'])
                end
            end
            if steno3d.utils.User.isLoggedIn()
                user = steno3d.utils.User.currentUser();
                if length(obj.Resources) > user.FigCompLimit
                    error('steno3d:validationError',                    ...
                          [num2str(length(obj.Resources)) ' resources ' ...
                           'in project exceeds limit of '               ...
                           num2str(user.FigCompLimit)]);
                end
                sz = 0;
                for i = 1:length(obj.Resources)
                    sz = sz + obj.Resources{i}.nbytes();
                end
                if sz > user.FigSizeLimit
                    error('steno3d:validationError',                    ...
                          ['Project size ' num2str(sz) ' bytes exceeds '...
                           'project limit of '                          ...
                           num2str(user.FigSizeLimit) ' bytes']);
                end
            end
        end



        function uploadChildren(obj, tabLevel)
            for i = 1:length(obj.Resources)
                obj.Resources{i}.uploadContent(tabLevel);
            end
        end

        function args = uploadArgs(obj)
            args = {'public', obj.PR_Public.serialize()};

            res = '';
            for i = 1:length(obj.Resources)
                res = [res obj.Resources{i}.PR__uid ','];
            end
            args = [args, {'resourceUids', res(1:end-1)}];


            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end

        function quotaCheck(obj, public)
            if public
                privacy = 'public';
            else
                privacy = 'private';
            end
            fprintf(['Verifying your quota for ' privacy                ...
                     ' projects...\n']);
            resp = steno3d.utils.get('api/check/quota', 'test',         ...
                                     'ProjectSteno3D');
            resp = resp.(privacy);
            if strcmp(resp.quota, 'Unlimited')
                return
            elseif str2double(resp.count) >= str2double(resp.quota)
                error('steno3d:quotaException',                         ...
                      ['Uploading this ' pirvacy ' project will put '   ...
                       'you over your quota of ' resp.quota ' ' privacy ...
                       ' project(s). For more projects and space, '     ...
                       'consider upgrading your account: '              ...
                       '<a href="matlab: web(''https://steno3d.com/'    ...
                       'settings/plan'', ''-browser'')">'               ...
                       'https://steno3d.com/settings/plan</a>'])
            elseif (str2double(resp.quota) - str2double(resp.count) - 1)...
                    < 4
                fprintf( ...
                    ['After this project, you may upload '              ...
                     num2str((str2double(resp.quota)                    ...
                              - str2double(resp.count) - 1))            ...
                     'more ' privacy ' project(s)\n before reaching '   ...
                     'your ' privacy ' project quota. For more '        ...
                     'projects and space consider upgrading your '      ...
                     'account: \n'                                      ...
                     '<a href="matlab: web(''https://steno3d.com/'      ...
                     'settings/plan'', ''-browser'')">'                 ...
                     'https://steno3d.com/settings/plan</a>'])
            end
            if public
                fprintf(['This PUBLIC project will be viewable by '     ...
                         'everyone.\n'])
            end
        end
    end

end

