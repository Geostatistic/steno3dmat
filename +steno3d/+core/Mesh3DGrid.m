classdef Mesh3DGrid < steno3d.core.UserContent
%MESH3DGRID Summary of this class goes here
%   Detailed explanation goes here

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
                'Name', 'x0',                                           ...
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
    end

    methods (Hidden)
        function args = uploadArgs(obj)

            args = {'tensors', ['{"h1": "' obj.PR_H1.serialize()        ...
                                '", "h2": "' obj.PR_H2.serialize()      ...
                                '", "h3": "' obj.PR_H3.serialize()      ...
                                '"}'],                                  ...
                    'OUVZ', ['{"O": "' obj.PR_x0.serialize()            ...
                             '", "U": "[' num2str(sum(obj.H1)) ', 0, 0]'...
                             '", "V": "[0, ' num2str(sum(obj.H2)) ', 0]'...
                             '", "Z": "[0, 0, ' num2str(sum(obj.H3)) ']'...
                             '"}']};

            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end

end
