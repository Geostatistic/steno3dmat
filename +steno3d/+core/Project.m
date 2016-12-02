classdef Project < steno3d.core.UserContent
%PROJECT Container of related Steno3D resources for plotting and uploading
%   Creating projects is the reason the Steno3D MATLAB toolbox exists. A
%   PROJECT contains one or more related <a href="matlab:
%   help steno3d.core.Point">Point</a>, <a href="matlab:
%   help steno3d.core.Line">Line</a>, <a href="matlab:
%   help steno3d.core.Surface">Surface</a>, or <a href="matlab:
%   help steno3d.core.Volume">Volume</a>
%   resources. They can be created and edited using the high-level plotting
%   interface or the low-level command line interface.
%
%   Once a PROJECT is created, it can be plotted in MATLAB with the PLOT()
%   function. This allows an initial visualization to verify the PROJECT is
%   constructed correctly. After the PROJECT is complete in MATLAB, it can
%   be uploaded to steno3d.com with the UPLOAD() function. This validates
%   the PROJECT, checks user quotas, and uploads the PROJECT. The URL of
%   the uploaded PROJECT is returned and can also be accessed with the
%   URL() function.
%
%   PROJECT implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       Public (<a href="matlab: help props.Bool">props.Bool</a>)
%           Public visibility on steno3d.com
%           Default: false
%
%       Resources (<a href="matlab: help props.Repeated
%       ">props.Repeated</a>)
%           Composite resources the project contains
%           Type: props.Instance (Class: <a href="matlab:
%           help steno3d.core.CompositeResource">CompositeResource</a>)
%
%   OPTIONAL PROPERTIES:
%       Title (<a href="matlab: help props.String">props.String</a>)
%           Content title
%
%       Description (<a href="matlab: help props.String">props.String</a>)
%           Content description
%
% 
%   See the <a href="matlab: help steno3d.examples.core.project
%   ">EXAMPLES</a>
%
%   See also STENO3D.CORE.COMPOSITERESOURCE, STENO3D.CORE.USERCONTENT
%


    properties (Hidden, SetAccess = immutable)
        ProjProps = {                                                   ...
            struct(                                                     ...
                'Name', 'Public',                                       ...
                'Type', @props.Bool,                                    ...
                'Doc', 'Public visibility on steno3d.com',              ...
                'DefaultValue', false,                                  ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Resources',                                    ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Composite resources the project contains',      ...
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
        PR__url = ''
    end

    methods
        function obj = Project(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end

        function appURL = upload(obj)
        %UPLOAD Validate and upload the project to steno3d.com
        %   P.UPLOAD() validates project P, uploads it to steno3d.com
        %
        %   URL = P.UPLOAD() returns the URL of the uploaded project
        %   
            if ~steno3d.utils.User.isLoggedIn()
                error('steno3d:projectError', 'Please "steno3d.login()"');
            end
            obj.validate();
            obj.quotaCheck(obj.Public);
            obj.uploadContent('');
            user = steno3d.utils.User.currentUser();
            uidsplit = strsplit(obj.PR__uid, ':');
            appURL = strjoin([user.Endpoint 'app/' uidsplit(2)], '');
            fprintf(['<a href="matlab: '                                ...
                    'web(''' appURL ''', ''-browser'')"'                ...
                    '>View Project</a>\n']);
            obj.PR__url = appURL;
        end
        
        function appURL = url(obj)
        %URL Return the URL of the project if it has been uploaded
        %   P.URL() returns the URL of an uploaded project P and errors if
        %   the project isn't uploaded
        %
            if isempty(obj.PR__url)
                error('steno3d:projectError', 'Project not uploaded');
            end
            appURL = obj.PR__url;
        end

        function ax = plot(obj, ax)
        %PLOT Locally plot the project in a MATLAB axes
        %   P.PLOT() plots the project P in a new figure window
        %
        %   P.PLOT(AX) plots the project P in an existing axes AX
        %
        %   AX = P.PLOT(...) returns the axes handle of the plot
        %
        %   It is recommended to call PLOT with no arguments (not provide 
        %   AX). This prevents loss of graphics objects unrelated to the
        %   project and ensures that uploading the axes will correctly
        %   upload the project.
        %
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
            if steno3d.utils.User.isLoggedIn()
                user = steno3d.utils.User.currentUser();
                if length(obj.Resources) > user.FigCompLimit
                    error('steno3d:projectError',                       ...
                          [num2str(length(obj.Resources)) ' resources ' ...
                           'in project exceeds limit of '               ...
                           num2str(user.FigCompLimit)]);
                end
                sz = 0;
                for i = 1:length(obj.Resources)
                    sz = sz + obj.Resources{i}.nbytes();
                end
                if sz > user.FigSizeLimit
                    error('steno3d:projectError',                       ...
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

