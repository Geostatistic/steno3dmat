classdef Texture2DImage < steno3d.core.UserContent
%TEXTURE2DIMAGE Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        TextureProps = {                                                ...
            struct(                                                     ...
                'Name', 'O',                                            ...
                'Type', @props.Vector,                                  ...
                'Doc', 'Origin of the texture',                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'U',                                            ...
                'Type', @props.Vector,                                  ...
                'Doc', 'U axis of the texture',                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'V',                                            ...
                'Type', @props.Vector,                                  ...
                'Doc', 'V axis of the texture',                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Image',                                        ...
                'Type', @props.Image,                                   ...
                'Doc', 'Texture image file',                            ...
                'Required', true                                        ...
            )                                                           ...

        }
    end

    methods

        function obj = Texture2DImage(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end
    end

    methods (Hidden)

        function rc = resourceClass(obj)
            rc = 'image';
        end

        function mapi = modelAPILocation(obj)
            mapi = ['resource/texture2d/' obj.resourceClass];
        end

        function args = uploadArgs(obj)

            args = {'OUV', ['{"O": ' obj.PR_O.serialize()              ...
                            ', "U": ' obj.PR_U.serialize()            ...
                            ', "V": ' obj.PR_V.serialize() '}']};

            imStruct = obj.PR_Image.serialize();
            args = [args, {'image', imStruct.FileID,                    ...
                           'imageType', imStruct.DType}];

            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end

end

