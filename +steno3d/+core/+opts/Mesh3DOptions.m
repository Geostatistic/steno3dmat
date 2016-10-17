classdef Mesh3DOptions < steno3d.core.opts.Options
%MESH3DOPTIONS Options for to Steno3D MESH3DGRID objects
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   MESH3DOPTIONS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   OPTIONAL PROPERTIES:
%       Wireframe (<a href="matlab: help props.Bool">props.Bool</a>)
%           Display 3D mesh wireframe
%           Default: false
%
%   See also steno3d.core.opts, steno3d.core.Mesh3DGrid
%


    properties (Hidden, SetAccess = immutable)
        M3DOptProps = {                                                 ...
            struct(                                                     ...
                'Name', 'Wireframe',                                    ...
                'Type', @props.Bool,                                    ...
                'Doc', 'Display 3D mesh wireframe',                     ...
                'DefaultValue', false,                                  ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Mesh3DOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
    end

end

