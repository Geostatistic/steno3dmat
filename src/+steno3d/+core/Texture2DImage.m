classdef Texture2DImage < steno3d.core.UserContent
%TEXTURE2DIMAGE Steno3D object to hold images and mapping to resources
%   Image textures are used to map data to a Steno3D resource in space
%   without requiring an array that corresponds to geometry. Images must be
%   PNG files (or MATLAB matrices that can be written as PNGs with
%   %%%matlabref[imwrite](imwrite)). In addion to the image, `Texture2DImage` contains spatial
%   location given by axes vectors U and V extending from an origin point.
%
%   The image is mapped on to the resource by projecting it out of the
%   plane defined by the origin, U, and V, in a U-cross-V direction. Only
%   %%%ref[Points](steno3d.core.Point) and %%%ref[Surfaces](steno3d.core.Surface) support `Texture2DImage`; Lines and Volumes do not.
%
%   A `Texture2DImage` can also be added to a resource through a high-level
%   functional interface with %%%func[steno3d.addImage](steno3d.addImage). The function
%   %%%func[steno3d.surface](steno3d.surface) also allows creation of a surface with an image.
%
%   %%%properties
%
%   See the %%%ref[EXAMPLES](steno3d.examples.core.texture)
%
%   %%%seealso steno3d.addImage, steno3d.surface, steno3d.core.Point, steno3d.core.Surface, steno3d.core.DataArray
%


    properties (Hidden, SetAccess = immutable)
        TextureProps = {                                                ...
            struct(                                                     ...
                'Name', 'U',                                            ...
                'Type', @props.Vector,                                  ...
                'Doc', 'Vector corresponding to the image x-axis',      ...
                'DefaultValue', 'X',                                    ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'V',                                            ...
                'Type', @props.Vector,                                  ...
                'Doc', 'Vector corresponding to the image y-axis',      ...
                'DefaultValue', 'Y',                                    ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'O',                                            ...
                'Type', @props.Vector,                                  ...
                'Doc', 'Origin point from which U- and V-axes extend',  ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Image',                                        ...
                'Type', @props.Image,                                   ...
                'Doc', 'PNG image file',                                ...
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
            args = {'OUV', ['{"O": ' obj.PR_O.serialize()               ...
                            ', "U": ' obj.PR_U.serialize()              ...
                            ', "V": ' obj.PR_V.serialize() '}']};
            imStruct = obj.PR_Image.serialize();
            args = [args, {'image', imStruct.FileID,                    ...
                           'imageType', imStruct.DType}];
            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end

end
