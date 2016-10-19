classdef Mesh0D < steno3d.core.UserContent
%MESH0D Mesh for Steno3D Point resources
%   This mesh provides the geometry for <a href="matlab:
%   help steno3d.core.Point">Point</a> resources, an n x 3 array of
%   spatial coordinates where n is the number of points. There are
%   currently no additional options available for this mesh.
%
%   For a demonstration of MESH0D, see the <a href="
%   matlab: help steno3d.examples.point">EXAMPLES</a>.
%
%   MESH0D implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       Vertices (<a href="matlab: help props.Array">props.Array</a>)
%           Spatial coordinates of points
%           Shape: {*, 3}, DataType: float
%
%   OPTIONAL PROPERTIES:
%       Opts (<a href="matlab: help props.Instance">props.Instance</a>)
%           Options for the mesh
%           Class: <a href="matlab: help steno3d.core.opts.Mesh0DOptions
%           ">Mesh0DOptions</a>
%
%       Title (<a href="matlab: help props.String">props.String</a>)
%           Content title
%
%       Description (<a href="matlab: help props.String">props.String</a>)
%           Content description
%
%   
%   See the <a href="matlab: help steno3d.core.examples.point">EXAMPLES</a>
%
%   See also STENO3D.CORE.POINT, STENO3D.CORE.MESH0DOPTIONS
%


    properties (Hidden, SetAccess = immutable)
        M0DProps = {                                                    ...
            struct(                                                     ...
                'Name', 'Vertices',                                     ...
                'Type', @props.Array,                                   ...
                'Doc', 'Spatial coordinates of points',                 ...
                'Shape', {{'*', 3}},                                    ...
                'Binary', true,                                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Options for the mesh',                          ...
                'Class', @steno3d.core.opts.Mesh0DOptions,              ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Mesh0D(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end
        function n = nN(obj)
            n = size(obj.Vertices, 1);
        end
        function n = nC(obj)
            n = obj.nN();
        end
        function n = nbytes(obj)
            n = length(obj.Vertices(:))*8;
        end
    end

    methods (Hidden)
        function validator(obj)
            if steno3d.utils.User.isLoggedIn()
                user = steno3d.utils.User.currentUser();
                sz = obj.([obj.PROP_PREFIX 'Vertices']).nbytes;
                if sz > user.FileSizeLimit
                    error('steno3d:mesh0DError',                        ...
                          ['File size ' num2str(sz) ' bytes exceeds '   ...
                           'file limit of ' num2str(user.FileSizeLimit) ...
                           ' bytes']);
                end
            end
        end
        
        function args = uploadArgs(obj)
            vStruct = obj.PR_Vertices.serialize();
            args = {'vertices', vStruct.FileID,                         ...
                    'verticesType', vStruct.DType};
            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end
end

