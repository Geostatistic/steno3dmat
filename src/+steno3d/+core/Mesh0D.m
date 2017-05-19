classdef Mesh0D < steno3d.core.UserContent
%MESH0D Mesh for Steno3D Point resources
%   This mesh provides the geometry for %%%ref[Point](steno3d.core.Point) 
%   resources, an n x 3 array of spatial coordinates where n is the number 
%   of points. 
%   
%   The first step to create points is to make 
%   a 0D mesh(in Steno3D, we refer to point mesh as 0D mesh). Point meshes 
%   are formed by vertices. A simple example of a point mesh is depicted in Figure1.
%   
%   %%%image/images/mesh0D.png
%
%   As shown in this figure, vertices are 3D points represented by (x, y, z)
%   coordinates.
%   
%   There are currently no additional options available for this mesh.
%
%   %%%properties
%
%   See the %%%ref[EXAMPLES](steno3d.examples.core.point)
%
%   %%%seealso steno3d.core.Point, steno3d.core.opts.Mesh0DOptions
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

