classdef Float < props.Prop
%FLOAT Summary of this class goes here
%   Detailed explanation goes here

    properties (SetAccess = ?props.Prop)
        MinValue = -Inf
        MaxValue = Inf
        IsInteger = false
    end

    methods
        function obj = Float(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'DefaultValue', 0,                                      ...
                'PropInfo', 'a single number');
            obj = obj@props.Prop(args{:});
            if obj.MinValue > obj.MaxValue
                error('steno3d:propError',                              ...
                      'MinValue must be less than MaxValue');
            end
        end

        function obj = set.MinValue(obj, val)
            if ~isnumeric(val) || length(val(:)) ~= 1
                error('steno3d:propError',                              ...
                      'Prop property `MinValue` must be a number');
            end
            obj.MinValue = val;
        end

        function obj = set.MaxValue(obj, val)
            if ~isnumeric(val) || length(val(:)) ~= 1
                error('steno3d:propError',                              ...
                      'Prop property `MaxValue` must be a number');
            end
            obj.MaxValue = val;
        end

        function obj = set.IsInteger(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:propError',                              ...
                      'Prop property `IsInteger` must be true or false');
            end
            obj.IsInteger = val;
        end

        function val = validate(obj, val)
            if ~isnumeric(val) || length(val(:)) ~= 1
                error('steno3d:propError', '%s must be %s',             ...
                      obj.Name, obj.PropInfo)
            end
            if val < obj.MinValue || val > obj.MaxValue
                error('steno3d:propError',                              ...
                      '%s must be a number between %d and %d',          ...
                      obj.Name, obj.MinValue, obj.MaxValue)
            end
            if obj.IsInteger && val ~= round(val)
                error('steno3d:propError', '%s must be an integer',     ...
                      obj.Name)
            end
        end

        function output = serialize(obj)
            output = num2str(obj.Value);
        end
    end
end

