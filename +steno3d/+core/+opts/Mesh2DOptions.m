classdef Mesh2DOptions < steno3d.core.opts.Options
%MESH2DOPTIONS Options for Steno3D Mesh2D and Mesh2DGrid objects
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   MESH2DOPTIONS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   OPTIONAL PROPERTIES:
%       Wireframe (<a href="matlab: help props.Bool">props.Bool</a>)
%           Display 2D mesh wireframe
%           Default: false
%
%
%   See the surface <a href="matlab: help steno3d.core.examples.surface
%   ">EXAMPLES</a>
%
%   See also STENO3D.CORE.OPTS, STENO3D.CORE.MESH2D,
%   STENO3D.CORE.MESH2DGRID
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


