classdef Project < steno3d.core.UserContent
%PROJECT Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        ProjTraits = {                                                  ...
            struct(                                                     ...
                'Name', 'Public',                                       ...
                'Type', @steno3d.traits.Bool,                           ...
                'Doc', 'Public visibility of the project',              ...
                'DefaultValue', false,                                  ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Resources',                                    ...
                'Type', @steno3d.traits.Repeated,                       ...
                'Doc', 'Project Resources',                             ...
                'TraitType', struct(                                    ...
                    'Type', @steno3d.traits.Instance,                   ...
                    'Class', @steno3d.core.CompositeResource,           ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Project(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end

        function url = upload(obj)
            obj.uploadContent('');
            user = steno3d.utils.User.currentUser();
            uidsplit = strsplit(obj.TR__uid, ':');
            url = strjoin([user.Endpoint 'app/' uidsplit(2)], '');
            fprintf(url)
        end
    end

    methods (Hidden)
        function mapi = modelAPILocation(obj)
            mapi = 'project/steno3d';
        end



        function uploadChildren(obj, tabLevel)
            for i = 1:length(obj.Resources)
                obj.Resources(i).uploadContent(tabLevel)
            end
        end

        function args = uploadArgs(obj)
            args = {'public', obj.TR_Public.serialize()};

            res = '';
            for i = 1:length(obj.Resources)
                res = [obj.Resources(i).TR__uid ','];
            end
            args = [args, {'resourceUids', res(1:end-1)}];


            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end

end

