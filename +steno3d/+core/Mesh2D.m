classdef Mesh2D < steno3d.core.UserContent
%MESH2D Mesh for triangluated Steno3D Surface resources
%   This mesh provides the geometry for triangulated <a href="matlab:
%   help steno3d.core.Surface">Surface</a> resources. It
%   consists of an m x 3 array of spatial vertices and an n x 3 array of
%   vertex indices to define the triangles. Triangle values must be between
%   1 and m. MESH2D has additional <a href="matlab:
%   help steno3d.core.opts.Mesh2DOptions
%   ">options</a> to customize the appearance of
%   the surface.
%
%   For a demonstration of MESH2D, see the <a href="
%   matlab: help steno3d.examples.surface">EXAMPLES</a>.
%
%   MESH2D implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       Vertices (<a href="matlab: help props.Array">props.Array</a>)
%           Spatial coordinates of surface vertices
%           Shape: {*, 3}, DataType: float
%
%       Triangles (<a href="matlab: help props.Array">props.Array</a>)
%           Vertex indices of surface triangles
%           Shape: {*, 3}, DataType: int
%
%   OPTIONAL PROPERTIES:
%       Opts (<a href="matlab: help props.Instance">props.Instance</a>)
%           Options for the mesh
%           Class: <a href="matlab: help steno3d.core.opts.Mesh2DOptions
%           ">Mesh2DOptions</a>
%
%       Title (<a href="matlab: help props.String">props.String</a>)
%           Content title
%
%       Description (<a href="matlab: help props.String">props.String</a>)
%           Content description
%
%   
%   See the <a href="matlab: help steno3d.core.examples.surface
%   ">EXAMPLES</a>
%
%   See also STENO3D.CORE.SURFACE, STENO3D.CORE.OPTS.MESH2DOPTIONS
%


    properties (Hidden, SetAccess = immutable)
        M2DProps = {                                                    ...
            struct(                                                     ...
                'Name', 'Vertices',                                     ...
                'Type', @props.Array,                                   ...
                'Doc', 'Spatial coordinates of surface vertices',       ...
                'Shape', {{'*', 3}},                                    ...
                'Binary', true,                                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Triangles',                                    ...
                'Type', @props.Array,                                   ...
                'Doc', 'Vertex indices of surface triangles',           ...
                'Shape', {{'*', 3}},                                    ...
                'DataType', 'int',                                      ...
                'Binary', true,                                         ...
                'IndexArray', true,                                     ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Options for the mesh',                          ...
                'Class', @steno3d.core.opts.Mesh2DOptions,              ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Mesh2D(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end
        function n = nN(obj)
            n = length(obj.Vertices);
        end
        function n = nC(obj)
            n = length(obj.Triangles);
        end
        function n = nbytes(obj)
            n = length(obj.Vertices(:))*8 + length(obj.Triangles(:))*8;
        end
    end

    methods (Hidden)
        function validator(obj)
            if min(obj.Triangles(:)) < 1 ||                             ...
                    max(obj.Triangles(:)) > size(obj.Vertices, 1)
                error('steno3d:mesh2DError',                            ...
                      ['Triangles must be integers between 1 and '      ...
                       num2str(size(obj.Vertices, 1))                   ...
                       ' (length of vertices)'])
            end
            if steno3d.utils.User.isLoggedIn()
                user = steno3d.utils.User.currentUser();
                sz = max([obj.([obj.PROP_PREFIX 'Vertices']).nbytes     ...
                          obj.([obj.PROP_PREFIX 'Triangles']).nbytes]);
                if sz > user.FileSizeLimit
                    error('steno3d:mesh2DError',                        ...
                          ['File size ' num2str(sz) ' bytes exceeds '   ...
                           'file limit of ' num2str(user.FileSizeLimit) ...
                           ' bytes']);
                end
            end
        end
        function args = uploadArgs(obj)
            vStruct = obj.PR_Vertices.serialize();
            tStruct = obj.PR_Triangles.serialize();
            args = {'vertices', vStruct.FileID,                         ...
                    'verticesType', vStruct.DType,                      ...
                    'triangles', tStruct.FileID,                        ...
                    'trianglesType', tStruct.DType};
            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end
end

