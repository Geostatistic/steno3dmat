classdef Mesh2DGrid < steno3d.core.UserContent
%MESH2DGRID Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        M2DProps = {                                                    ...
            struct(                                                     ...
                'Name', 'H1',                                           ...
                'Type', @props.Array,                                   ...
                'Doc', 'Mesh2D grid cell widths, U-direction',          ...
                'Shape', {{'*', 1}},                                    ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'H2',                                           ...
                'Type', @props.Array,                                   ...
                'Doc', 'Mesh2D grid cell widths, V-direction',          ...
                'Shape', {{'*', 1}},                                    ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'O',                                            ...
                'Type', @props.Vector,                                  ...
                'Doc', 'Origin vector',                                 ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'U',                                            ...
                'Type', @props.Vector,                                  ...
                'Doc', 'Orientation of H1 axis',                        ...
                'DefaultValue', 'X',                                    ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'V',                                            ...
                'Type', @props.Vector,                                  ...
                'Doc', 'Orientation of H2 axis',                        ...
                'DefaultValue', 'Y',                                    ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Z',                                            ...
                'Type', @props.Array,                                   ...
                'Doc', 'Node topography',                               ...
                'Shape', {{'*', 1}},                                    ...
                'Serial', true,                                         ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'ZOrder',                                       ...
                'Type', @props.String,                                  ...
                'Doc', 'Z array order',                                 ...
                'Choices', struct(                                      ...
                    'c', {{'c-style', 'numpy', 'row-major', 'row'}},    ...
                    'f', {{'fortran', 'matlab', 'column-major',         ...
                           'column', 'col'}}                            ...
                ),                                                      ...
                'DefaultValue', 'f',                                    ...
                'Lowercase', true,                                      ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Mesh2D options',                                ...
                'Class', @steno3d.core.opts.Mesh2DOptions,              ...
                'Required', false                                       ...
            )                                                           ...

        }
    end

    methods
        function obj = Mesh2DGrid(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end
        
        function n = nN(obj)
            n = (length(obj.H1) + 1) * (length(obj.H2) + 1);
        end
        
        function n = nC(obj)
            n = length(obj.H1) * length(obj.H2);
        end
        function n = nbytes(obj)
            n = length(obj.H1)*8 + length(obj.H2)*8 + length(obj.Z(:))*8;
        end
    end

    methods (Hidden)
        
        function validator(obj)
            if ~isempty(obj.Z) && length(obj.Z) ~= obj.nN
                error('steno3d:validationError', ['Length of Z '        ...
                      '(currently ' num2str(length(obj.Z)) ') must '    ...
                      'equal number of nodes (' num2str(obj.nN) ')']);
            end
            if steno3d.utils.User.isLoggedIn()
                user = steno3d.utils.User.currentUser();
                sz = max([obj.([obj.PROP_PREFIX 'H1']).nbytes           ...
                          obj.([obj.PROP_PREFIX 'H2']).nbytes           ...
                          obj.([obj.PROP_PREFIX 'Z']).nbytes]);
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
                                '}'],                                   ...
                    'OUV', ['{"O": ' obj.PR_O.serialize()               ...
                            ', "U": ' obj.PR_U.serialize()              ...
                            ', "V": ' obj.PR_V.serialize() '}'],        ...
                    'order', obj.ZOrder};

            zStruct = obj.PR_Z.serialize();
            args = [args, {'Z', zStruct.FileID,                         ...
                           'ZType', zStruct.DType}];

            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end

end

