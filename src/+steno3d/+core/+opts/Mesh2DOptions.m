classdef Mesh2DOptions < steno3d.core.opts.Options
%MESH2DOPTIONS Options for Steno3D Mesh2D and Mesh2DGrid objects
%   For usage details, see the %%%ref[options help](steno3d.core.opts).
%
%   %%%properties
%
%   See the surface %%%ref[EXAMPLES](steno3d.examples.core.surface)
%
%   %%%seealso steno3d.core.opts, steno3d.core.Mesh2D, steno3d.core.Mesh2DGrid
%


    properties (Hidden, SetAccess = immutable)
        M2DOptProps = {                                                 ...
            struct(                                                     ...
                'Name', 'Wireframe',                                    ...
                'Type', @props.Bool,                                    ...
                'Doc', 'Display 2D mesh wireframe',                     ...
                'DefaultValue', false,                                  ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Mesh2DOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
    end
end


