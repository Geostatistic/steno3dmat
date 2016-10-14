classdef DataArray < steno3d.core.UserContent
%DATAARRAY Steno3D object to hold resource data
%   Data is stored as an array. It is bound to a <a href="matlab:
%   help steno3d.core.CompositeResource">composite resource</a> using a
%   data <a href=" matlab: help steno3d.core.binders
%   ">binder</a> cell array. The length of the Array must correspond to the
%   specified mesh geometry location (nodes or cell centers). For some
%   types of meshes, this is straightforward (e.g. using <a href="
%   matlab: help steno3d.core.Mesh0D">Mesh0D</a>, the Array
%   must be equal in length to the Vertices). For gridded meshes
%   (<a href="matlab: help steno3d.core.Mesh2DGrid
%   ">Mesh2DGrid</a>, <a href="matlab: help steno3d.core.Mesh3DGrid
%   ">Mesh3DGrid</a>), the Array must be unwrapped in the correct
%   order. By default, if you have a matrix of the correct shape
%   [X-length, Y-length(, Z-length)], flattening with matrix(:) gives the
%   correct order.
%
%   A DATAARRAY can also be added to a resource through a high-level
%   functional interface with <a href="matlab: help
%   steno3d.addData">steno3d.addData</a>.
%
%   For a demonstration of DATAARRAY, see the <a href="
%   matlab: help steno3d.examples.data">EXAMPLES</a>.
%
%   DATAARRAY implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab: help
%   props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       Array (<a href="matlab: help props.Array">props.Array</a>)
%           Data corresponding to geometry of the mesh
%           Shape: {*, 1}, DataType: float
%
%       Order (<a href="matlab: help props.String">props.String</a>)
%           Data array order, for data on grid meshes
%           Choices: c, f
%           Default: 'f' (column-major, default for MATLAB and fortran)
%
%   OPTIONAL PROPERTIES:
%       Title (<a href="matlab: help props.String">props.String</a>)
%           Content title
%
%       Description (<a href="matlab: help props.String">props.String</a>)
%           Content description
%
%
%   See also steno3d.examples.data, steno3d.addData, steno3d.core.binders,
%   steno3d.core.CompositeResource, steno3d.core.Texture2DImage
%


    properties (Hidden, SetAccess = immutable)
        DataArrayProps = {                                              ...
            struct(                                                     ...
                'Name', 'Array',                                        ...
                'Type', @props.Array,                                   ...
                'Doc', 'Data corresponding to geometry of the mesh',    ...
                'Shape', {{'*', 1}},                                    ...
                'Binary', true,                                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Order',                                        ...
                'Type', @props.String,                                  ...
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
        function obj = DataArray(varargin)
            if rem(nargin, 2) == 1 && isnumeric(varargin{1})
                varargin = [{'Array'} varargin];
            end
            obj = obj@steno3d.core.UserContent(varargin{:});
        end
    end

    methods (Hidden)
        function rc = resourceClass(obj)
            rc = 'array';
        end

        function mapi = modelAPILocation(obj)
            mapi = ['resource/data/' obj.resourceClass];
        end

        function args = uploadArgs(obj)
            args = {'order', obj.Order};
            arrayStruct = obj.PR_Array.serialize();
            args = [args, {'array', arrayStruct.FileID,                 ...
                           'arrayType', arrayStruct.DType}];
            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end
end

