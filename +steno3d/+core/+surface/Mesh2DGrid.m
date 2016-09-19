classdef Mesh2DGrid < steno3d.core.UserContent
%MESH2DGRID Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        M2DTraits = {                                                   ...
            struct(                                                     ...
                'Name', 'H1',                                           ...
                'Type', @steno3d.traits.Array,                          ...
                'Doc', 'Mesh2D grid cell widths, U-direction',          ...
                'Shape', {{'*'}},                                       ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'H2',                                           ...
                'Type', @steno3d.traits.Array,                          ...
                'Doc', 'Mesh2D grid cell widths, V-direction',          ...
                'Shape', {{'*'}},                                       ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'O',                                            ...
                'Type', @steno3d.traits.Vector,                         ...
                'Doc', 'Origin vector',                                 ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'U',                                            ...
                'Type', @steno3d.traits.Vector,                         ...
                'Doc', 'Orientation of H1 axis',                        ...
                'DefaultValue', 'X',                                    ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'V',                                            ...
                'Type', @steno3d.traits.Vector,                         ...
                'Doc', 'Orientation of H2 axis',                        ...
                'DefaultValue', 'Y',                                    ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Z',                                            ...
                'Type', @steno3d.traits.Array,                          ...
                'Doc', 'Node topography',                               ...
                'Shape', {{'*'}},                                       ...
                'Serial', true,                                         ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @steno3d.traits.Instance,                       ...
                'Doc', 'Mesh2D options',                                ...
                'Klass', @steno3d.core.surface.Mesh2DOptions,           ...
                'Required', false                                       ...
            )                                                           ...

        }
    end

    methods
    end

end

