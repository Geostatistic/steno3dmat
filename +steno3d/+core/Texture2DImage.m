classdef Texture2DImage < steno3d.core.UserContent
%TEXTURE2DIMAGE Steno3D object to hold images and mapping to resources
%   Image textures are used to map data to a Steno3D resource in space
%   without requiring an array that corresponds to geometry. Images must be
%   PNG files (or MATLAB matrices that can be written as PNGs with
%   <a href="matlab: help imwrite
%   ">imwrite</a>). In addion to the image, TEXTURE2DIMAGE contains spatial
%   location given by axes vectors U and V extending from an origin point.
%
%   The image is mapped on to the resource by projecting it out of the
%   plane defined by the origin, U, and V, in a U-cross-V direction. Only
%   <a href="matlab: help steno3d.core.CompositeResource
%   ">Points</a> and <a href="matlab:
%   help steno3d.core.CompositeResource
%   ">Surfaces</a> support TEXTURE2DIMAGE; Lines and Volumes do not.
%
%   A TEXTURE2DIMAGE can also be added to a resource through a high-level
%   functional interface with <a href="matlab: help steno3d.addImage
%   ">steno3d.addImage</a>. The function
%   <a href="matlab: help steno3d.surface
%   ">steno3d.surface</a> also allows creation of a surface with an image.
%
%   TEXTURE2DIMAGE implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       U (<a href="matlab: help props.Vector">props.Vector</a>)
%           Vector corresponding to the image x-axis
%           Shape: {1, 3}, DataType: float
%           Default: 'X' or [1 0 0] (values are equivalent)
%
%       V (<a href="matlab: help props.Vector">props.Vector</a>)
%           Vector corresponding to the image y-axis
%           Shape: {1, 3}, DataType: float
%           Default: 'Y' or [0 1 0] (values are equivalent)
%
%       O (<a href="matlab: help props.Vector">props.Vector</a>)
%           Origin point from which U- and V-axes extend
%           Shape: {1, 3}, DataType: float
%           Default: [0 0 0]
%
%       Image (<a href="matlab: help props.Image">props.Image</a>)
%           PNG image file
%
%   OPTIONAL PROPERTIES:
%       Title (<a href="matlab: help props.String">props.String</a>)
%           Content title
%
%       Description (<a href="matlab: help props.String">props.String</a>)
%           Content description
%
%
%   See the <a href="matlab: help steno3d.core.examples.texture
%   ">EXAMPLES</a>
%
%   See also STENO3D.ADDIMAGE, STENO3D.SURFACE, STENO3D.CORE.POINT,
%   STENO3D.CORE.SURFACE, STENO3D.CORE.DATAARRAY
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

