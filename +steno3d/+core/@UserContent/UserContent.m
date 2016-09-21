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
        TR__longuid = ''
    end
    
    methods
    end

    methods (Hidden)
        function rc = resourceClass(obj)
            mc = metaclass(obj);
            rcfull = strsplit(mc.Name, '.');
            rc = rcfull{end};
        end

        function mapi = modelAPILocation(obj)
            mapi = ['resource/' obj.ResourceClass];
        end
        
        function uploadContent(obj, tabLevel)
            uploading = [obj.TRAIT_PREFIX '_upload'];
            if obj.(uploading)
                return
            end
            ME = [];
            try
                fprintf([tabLevel 'Uploading' obj.resourceClass ': '    ...
                         obj.Title '\n'])
                obj.(uploading) = true;
                obj.validate()
                obj.uploadChildren(tabLevel)
                args = obj.uploadArgs();
                steno3d.utils.post(['api/' obj.modelAPILocation()],     ...
                                   args{:})
            fprintf([tabLevel '... Complete'])
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
            
        end



    end

end

