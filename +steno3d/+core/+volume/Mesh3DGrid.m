classdef Mesh3DGrid < steno3d.core.UserContent
%MESH3DGRID Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        M3DTraits = {                                                   ...
            struct(                                                     ...
                'Name', 'H1',                                           ...
                'Type', @steno3d.traits.Array,                          ...
                'Doc', 'Mesh2D grid cell widths, x-direction',          ...
                'Shape', {{'*'}},                                       ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'H2',                                           ...
                'Type', @steno3d.traits.Array,                          ...
                'Doc', 'Mesh2D grid cell widths, y-direction',          ...
                'Shape', {{'*'}},                                       ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'H3',                                           ...
                'Type', @steno3d.traits.Array,                          ...
                'Doc', 'Mesh2D grid cell widths, z-direction',          ...
                'Shape', {{'*'}},                                       ...
                'Serial', false,                                        ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'x0',                                           ...
                'Type', @steno3d.traits.Vector,                         ...
                'Doc', 'Origin vector',                                 ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @steno3d.traits.Instance,                       ...
                'Doc', 'Mesh3D options',                                ...
                'Class', @steno3d.core.volume.Mesh3DOptions,            ...
                'Required', false                                       ...
            )                                                           ...

        }
    end

    methods
    end

end

