classdef LineOptions < steno3d.core.opts.Options
%LINEOPTIONS Options for Steno3D Line objects
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   LINEOPTIONS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   OPTIONAL PROPERTIES:
%       Color (<a href="matlab: help props.Color">props.Color</a>)
%           Solid line color
%           Default: 'random'
%
%       Opacity (<a href="matlab: help props.Float">props.Float</a>)
%           Line opacity
%           Minimum: 0, Maximum: 1
%           Default: 1
%
%
%   See the line <a href="matlab: help steno3d.core.examples.line
%   ">EXAMPLES</a>
%
%   See also STENO3D.CORE.OPTS, STENO3D.CORE.LINE
%


    properties (Hidden, SetAccess = immutable)
        LOptProps = {                                                   ...
            struct(                                                     ...
                'Name', 'Color',                                        ...
                'Type', @props.Color,                                   ...
                'Doc', 'Solid line color',                              ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Opacity',                                      ...
                'Type', @props.Float,                                   ...
                'Doc', 'Line opacity',                                  ...
                'MinValue', 0,                                          ...
                'MaxValue', 1,                                          ...
                'Required', false,                                      ...
                'DefaultValue', 1                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = LineOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
    end
end


