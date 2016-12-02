classdef Mesh1D < steno3d.core.UserContent
%MESH1D Mesh for Steno3D Line resources
%   This mesh provides the geometry for <a href="matlab:
%   help steno3d.core.Line">Line</a> resources. It consists of an
%   m x 3 array of spatial vertices and an n x 2 array of vertex indices to
%   define the line segments. Segment values must be between 1 and m.
%   Mesh1D has additional <a href="matlab:
%   help steno3d.core.opts.Mesh1DOptions
%   ">options</a> to customize the appearance of the line.
%
%   MESH1D implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       Vertices (<a href="matlab: help props.Array">props.Array</a>)
%           Spatial coordinates of line vertices
%           Shape: {*, 3}, DataType: float
%
%       Segments (<a href="matlab: help props.Array">props.Array</a>)
%           Endpoint vertex indices of line segments
%           Shape: {*, 2}, DataType: int
%
%   OPTIONAL PROPERTIES:
%       Opts (<a href="matlab: help props.Instance">props.Instance</a>)
%           Options for the mesh
%           Class: <a href="matlab: help steno3d.core.opts.Mesh1DOptions
%           ">Mesh1DOptions</a>
%
%       Title (<a href="matlab: help props.String">props.String</a>)
%           Content title
%
%       Description (<a href="matlab: help props.String">props.String</a>)
%           Content description
%
%   
%   See the <a href="matlab: help steno3d.core.examples.line">EXAMPLES</a>
%
%   See also STENO3D.CORE.LINE, STENO3D.CORE.OPTS.MESH1DOPTIONS
%


    properties (Hidden, SetAccess = immutable)
        M1DProps = {                                                    ...
            struct(                                                     ...
                'Name', 'Vertices',                                     ...
                'Type', @props.Array,                                   ...
                'Doc', 'Spatial coordinates of line vertices',          ...
                'Shape', {{'*', 3}},                                    ...
                'Binary', true,                                         ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Segments',                                     ...
                'Type', @props.Array,                                   ...
                'Doc', 'Endpoint vertex indices of line segments',      ...
                'Shape', {{'*', 2}},                                    ...
                'DataType', 'int',                                      ...
                'Binary', true,                                         ...
                'IndexArray', true,                                     ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Options for the mesh',                          ...
                'Class', @steno3d.core.opts.Mesh1DOptions,              ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Mesh1D(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end
        function n = nN(obj)
            n = length(obj.Vertices);
        end
        function n = nC(obj)
            n = length(obj.Segments);
        end
        function n = nbytes(obj)
            n = length(obj.Vertices(:))*8 + length(obj.Segments(:))*8;
        end
    end

    methods (Hidden)
        function validator(obj)
            if min(obj.Segments(:)) < 1 ||                              ...
                    max(obj.Segments(:)) > size(obj.Vertices, 1)
                error('steno3d:mesh1DError',                            ...
                      ['Segments must be integers between 1 and '       ...
                       num2str(size(obj.Vertices, 1))                   ...
                       ' (length of vertices)'])
            end
            if steno3d.utils.User.isLoggedIn()
                user = steno3d.utils.User.currentUser();
                sz = max([obj.([obj.PROP_PREFIX 'Vertices']).nbytes     ...
                          obj.([obj.PROP_PREFIX 'Segments']).nbytes]);
                if sz > user.FileSizeLimit
                    error('steno3d:mesh1DError',                        ...
                          ['File size ' num2str(sz) ' bytes exceeds '   ...
                           'file limit of ' num2str(user.FileSizeLimit) ...
                           ' bytes']);
                end
            end
        end
        
        function args = uploadArgs(obj)
            vStruct = obj.PR_Vertices.serialize();
            sStruct = obj.PR_Segments.serialize();
            args = {'vertices', vStruct.FileID,                         ...
                    'verticesType', vStruct.DType,                      ...
                    'segments', sStruct.FileID,                         ...
                    'segmentsType', sStruct.DType};
            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end

end

