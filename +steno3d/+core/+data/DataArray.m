classdef DataArray < steno3d.core.UserContent
%DATAARRAY Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        DataArrayTraits = {                                             ...
            struct(                                                     ...
                'Name', 'Array',                                        ...
                'Type', @steno3d.traits.Array,                          ...
                'Doc', 'Data corresponding to points on the mesh',      ...
                'Shape', {{1, '*'}},                                    ...
                'Serial', true,                                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Order',                                        ...
                'Type', @steno3d.traits.String,                         ...
                'Doc', 'Data array order, for data on grid meshes',     ...
                'Choices', struct(                                      ...
                    'c', {{'c-style', 'numpy', 'row-major', 'row'}},    ...
                    'f', {{'fortran', 'matlab', 'column-major',         ...
                           'column', 'col'}}                            ...
                ),                                                      ...
                'DefaultValue', 'f',                                    ...
                'Lowercase', true,                                      ...
                'Required', true                                        ...
            )                                                           ...
        }
    end

    methods
    end

    methods (Hidden)
        function rc = resourceClass(obj)
            rc = 'array';
        end

        function mapi = modelAPILocation(obj)
            mapi = ['resource/' obj.ResourceClass];
        end
    end

end

