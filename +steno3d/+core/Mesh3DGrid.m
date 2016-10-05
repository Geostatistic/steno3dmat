classdef Mesh3DGrid < steno3d.core.UserContent
%MESH3DGRID Mesh for steno3d Volume

    properties (Hidden, SetAccess = immutable)
        M3DProps = {                                                    ...
            struct(                                                     ...
                'Name', 'H1',                                           ...
                'Type', @props.Array,                                   ...
                'Doc', 'Mesh2D grid cell widths, x-direction',          ...
                'Shape', {{1, '*'}},                                    ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'H2',                                           ...
                'Type', @props.Array,                                   ...
                'Doc', 'Mesh2D grid cell widths, y-direction',          ...
                'Shape', {{1, '*'}},                                    ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'H3',                                           ...
                'Type', @props.Array,                                   ...
                'Doc', 'Mesh2D grid cell widths, z-direction',          ...
                'Shape', {{1, '*'}},                                    ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'O',                                           ...
                'Type', @props.Vector,                                  ...
                'Doc', 'Origin vector',                                 ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Mesh3D options',                                ...
                'Class', @steno3d.core.opts.Mesh3DOptions,              ...
                'Required', false                                       ...
            )                                                           ...

        }
    end

    methods
        function obj = Mesh3DGrid(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end
        
        function n = nN(obj)
            n = (length(obj.H1) + 1) * (length(obj.H2) + 1) *           ...
                (length(obj.H3) + 1);
        end
        
        function n = nC(obj)
            n = length(obj.H1) * length(obj.H2) * length(obj.H3);
        end
        function n = nbytes(obj)
            n = length(obj.H1)*8 + length(obj.H2)*8 + length(obj.H3)*8;
        end
    end

    methods (Hidden)
        
        function validator(obj)
            if steno3d.utils.User.isLoggedIn()
                user = steno3d.utils.User.currentUser();
                sz = max([obj.([obj.PROP_PREFIX 'H1']).nbytes           ...
                          obj.([obj.PROP_PREFIX 'H2']).nbytes           ...
                          obj.([obj.PROP_PREFIX 'H3']).nbytes]);
                if sz > user.FileSizeLimit
                    error('steno3d:validationError',                    ...
                          ['File size ' num2str(sz) ' bytes exceeds '   ...
                           'file limit of ' num2str(user.FileSizeLimit) ...
                           ' bytes']);
                end
            end
        end
        
        function args = uploadArgs(obj)

            args = {'tensors', ['{"h1": ' obj.PR_H1.serialize()         ...
                                ', "h2": ' obj.PR_H2.serialize()        ...
                                ', "h3": ' obj.PR_H3.serialize()        ...
                                '}'],                                   ...
                    'OUVZ', ['{"O": ' obj.PR_O.serialize()             ...
                             ', "U": [' num2str(sum(obj.H1)) ', 0, 0]'  ...
                             ', "V": [0, ' num2str(sum(obj.H2)) ', 0]'  ...
                             ', "Z": [0, 0, ' num2str(sum(obj.H3)) ']'  ...
                             '}']};

            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end

end

