classdef Texture2DImage < steno3d.core.UserContent
%TEXTURE2DIMAGE Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        TextureTraits = {                                               ...
            struct(                                                     ...
                'Name', 'O',                                            ...
                'Type', @steno3d.traits.Vector,                         ...
                'Doc', 'Origin of the texture',                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'U',                                            ...
                'Type', @steno3d.traits.Vector,                         ...
                'Doc', 'U axis of the texture',                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'V',                                            ...
                'Type', @steno3d.traits.Vector,                         ...
                'Doc', 'V axis of the texture',                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Image',                                        ...
                'Type', @steno3d.traits.Image,                          ...
                'Doc', 'Texture image file',                            ...
                'Required', true                                        ...
            )                                                           ...

        }
    end

    methods
    end

end

