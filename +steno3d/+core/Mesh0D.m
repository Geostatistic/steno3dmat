 classdef Mesh0D < steno3d.core.UserContent
%MESH0D Mesh for steno3d Point

    properties (Hidden, SetAccess = immutable)
        M0DProps = {                                                    ...
            struct(                                                     ...
                'Name', 'Vertices',                                     ...
                'Type', @props.Array,                                   ...
                'Doc', 'Mesh0D vertices',                               ...
                'Shape', {{'*', 3}},                                    ...
                'Binary', true,                                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Mesh0D options',                                ...
                'Class', @steno3d.core.opts.Mesh0DOptions,              ...
                'Required', false                                       ...
            )                                                           ...

        }
    end

    methods
        function obj = Mesh0D(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end
        function n = nN(obj)
            n = size(obj.Vertices, 1);
        end
        function n = nC(obj)
            n = obj.nN();
        end
        function n = nbytes(obj)
            n = length(obj.Vertices(:))*8;
        end
    end

    methods (Hidden)
        
        function validator(obj)
            if steno3d.utils.User.isLoggedIn()
                user = steno3d.utils.User.currentUser();
                sz = obj.([obj.PROP_PREFIX 'Vertices']).nbytes;
                if sz > user.FileSizeLimit
                    error('steno3d:validationError',                    ...
                          ['File size ' num2str(sz) ' bytes exceeds '   ...
                           'file limit of ' num2str(user.FileSizeLimit) ...
                           ' bytes']);
                end
            end
        end
        
        function args = uploadArgs(obj)

            vStruct = obj.PR_Vertices.serialize();
            args = {'vertices', vStruct.FileID,                         ...
                    'verticesType', vStruct.DType};

            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end

    end

end

