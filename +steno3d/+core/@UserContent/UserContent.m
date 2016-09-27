classdef UserContent < steno3d.traits.HasTraits
%USERCONTENT Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        UCTraits = {                                                    ...
            struct(                                                     ...
                'Name', 'Title',                                        ...
                'Type', @steno3d.traits.String,                         ...
                'Doc', 'Content title',                                 ...
                'DefaultValue', '',                                     ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Description',                                  ...
                'Type', @steno3d.traits.String,                         ...
                'Doc', 'Content description',                           ...
                'DefaultValue', '',                                     ...
                'Required', false                                       ...
            )                                                           ...
        }
    end
    
    properties (Hidden, Access = private)
        TR__upload = false
    end
    
    properties (Hidden)
        TR__uid = []
    end
    
    methods
        
        function obj = UserContent(varargin)
            obj = obj@steno3d.traits.HasTraits(varargin{:});
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
            uploading = [obj.TRAIT_PREFIX '_upload'];
            if obj.(uploading)
                return
            end
            ME = [];
            try
                fprintf([tabLevel 'Uploading ' obj.resourceClass ': '    ...
                         obj.Title '\n']);
                obj.(uploading) = true;
                obj.validate();
                obj.uploadChildren([tabLevel '    ']);
                args = obj.uploadArgs();
                resp = steno3d.utils.post(                              ...
                    ['api/' obj.modelAPILocation()], args{:}            ...
                );
            
                obj.TR__uid = resp.longUid;
                
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
                args = [args, {'meta', obj.Opts.toJSON()}];
            end
        end



    end

end

