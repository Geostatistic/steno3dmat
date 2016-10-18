classdef (Abstract) UserContent < props.HasProps
%USERCONTENT Base class for all uploadable Steno3D content
%   The main purpose of the Steno3D MATLAB Toolbox is uploading plots and
%   projects to <a href="matlab: web('https://steno3d.com/','-browser')
%   ">steno3d.com</a>. USERCONTENT provides upload functionality
%   to Steno3D objects. It also inherits behaviour from <a href="matlab:
%   help props.HasProps">HasProps</a>, providing
%   dynamically created, type-checked properties.
%
%   See also steno3d.core.CompositeResource, steno3d.core.Project
%


    properties (Hidden, SetAccess = immutable)
        UCProps = {                                                     ...
            struct(                                                     ...
                'Name', 'Title',                                        ...
                'Type', @props.String,                                  ...
                'Doc', 'Content title',                                 ...
                'DefaultValue', '',                                     ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Description',                                  ...
                'Type', @props.String,                                  ...
                'Doc', 'Content description',                           ...
                'DefaultValue', '',                                     ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    properties (Hidden, Access = private)
        PR__upload = false
    end

    properties (Hidden)
        PR__uid = ''
    end

    methods
        function obj = UserContent(varargin)
            steno3d.utils.matverchk();
            obj = obj@props.HasProps(varargin{:});
        end
    end

    methods (Hidden)
        function rc = resourceClass(obj)
            mc = metaclass(obj);
            rcfull = strsplit(mc.Name, '.');
            rc = lower(rcfull{end});
        end

        function mapi = modelAPILocation(obj)
            mapi = ['resource/' obj.resourceClass];
        end

        function uploadContent(obj, tabLevel)
            uploading = [obj.PROP_PREFIX '_upload'];
            if obj.(uploading)
                return
            end
            ME = [];
            try
                fprintf([tabLevel 'Uploading ' obj.resourceClass ': '   ...
                         obj.Title '\n']);
                obj.(uploading) = true;
                obj.validate();
                obj.uploadChildren([tabLevel '    ']);
                args = obj.uploadArgs();
                resp = steno3d.utils.post(                              ...
                    ['api/' obj.modelAPILocation()], args{:}            ...
                );
                obj.PR__uid = resp.longUid;
                fprintf([tabLevel '... Complete\n']);
            catch ME
            end
            obj.(uploading) = false;
            if ~isempty(ME)
                rethrow(ME);
            end
        end

        function uploadChildren(obj, tabLevel)
        end

        function args = uploadArgs(obj)
            args = {'title', obj.Title, 'description', obj.Description};
            opts = obj.findprop('Opts');
            if length(opts) == 1
                args = [args {'meta', obj.Opts.toJSON()}];
            end
        end
    end
end

