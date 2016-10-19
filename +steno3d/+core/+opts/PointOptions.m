classdef PointOptions < steno3d.core.opts.Options
%POINTOPTIONS Options for Steno3D Point objects
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   POINTOPTIONS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   OPTIONAL PROPERTIES:
%       Color (<a href="matlab: help props.Color">props.Color</a>)
%           Point color
%           Default: 'random'
%
%       Opacity (<a href="matlab: help props.Float">props.Float</a>)
%           Point opacity
%           Minimum: 0, Maximum: 1
%           Default: 1
%
%
%   See the point <a href="matlab: help steno3d.core.examples.point
%   ">EXAMPLES</a>
%
%   See also STENO3D.CORE.OPTS, STENO3D.CORE.POINT
%


    properties (Hidden, SetAccess = immutable)
        POptProps = {                                                   ...
            struct(                                                     ...
                'Name', 'Color',                                        ...
                'Type', @props.Color,                                   ...
                'Doc', 'Point color',                                   ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Opacity',                                      ...
                'Type', @props.Float,                                   ...
                'Doc', 'Point opacity',                                 ...
                'MinValue', 0,                                          ...
                'MaxValue', 1,                                          ...
                'Required', false,                                      ...
                'DefaultValue', 1                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = PointOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
    end
end


