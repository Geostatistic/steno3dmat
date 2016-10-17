classdef VolumeOptions < steno3d.core.opts.Options
%VOLUMEOPTIONS Options for Steno3D Volume objects
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   VOLUMEOPTIONS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   OPTIONAL PROPERTIES:
%       Color (<a href="matlab: help props.Color">props.Color</a>)
%           Solid volume color
%           Default: 'random'
%
%       Opacity (<a href="matlab: help props.Float">props.Float</a>)
%           Volume opacity
%           Minimum: 0, Maximum: 1
%           Default: 1
%
%   See also steno3d.core.opts, steno3d.core.Volume
%


    properties (Hidden, SetAccess = immutable)
        VOptProps = {                                                   ...
            struct(                                                     ...
                'Name', 'Color',                                        ...
                'Type', @props.Color,                                   ...
                'Doc', 'Solid volume color',                            ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Opacity',                                      ...
                'Type', @props.Float,                                   ...
                'Doc', 'Volume opacity',                                ...
                'MinValue', 0,                                          ...
                'MaxValue', 1,                                          ...
                'Required', false,                                      ...
                'DefaultValue', 1                                       ...
            )                                                           ...
        }
    end

    methods

        function obj = VolumeOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
    end
end


