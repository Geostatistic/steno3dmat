classdef SurfaceOptions < steno3d.core.opts.Options
%SURFACEOPTIONS Options for Steno3D Surface objects
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   SURFACEOPTIONS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   OPTIONAL PROPERTIES:
%       Color (<a href="matlab: help props.Color">props.Color</a>)
%           Solid surface color
%           Default: 'random'
%
%       Opacity (<a href="matlab: help props.Float">props.Float</a>)
%           Surface opacity
%           Minimum: 0, Maximum: 1
%           Default: 1
%
%
%   See the surface <a href="matlab: help steno3d.core.examples.surface
%   ">EXAMPLES</a>
%
%   See also STENO3D.CORE.OPTS, STENO3D.CORE.SURFACE
%


    properties (Hidden, SetAccess = immutable)
        SOptProps = {                                                   ...
            struct(                                                     ...
                'Name', 'Color',                                        ...
                'Type', @props.Color,                                   ...
                'Doc', 'Solid surface color',                           ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Opacity',                                      ...
                'Type', @props.Float,                                   ...
                'Doc', 'Surface opacity',                               ...
                'MinValue', 0,                                          ...
                'MaxValue', 1,                                          ...
                'Required', false,                                      ...
                'DefaultValue', 1                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = SurfaceOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
    end
end


