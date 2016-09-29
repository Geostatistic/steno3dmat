classdef Bool < props.Prop
%BOOL Summary of this class goes here
%   Detailed explanation goes here

    methods
        function obj = Bool(varargin)
            args = props.Prop.setPropDefaults(varargin,      ...
                'DefaultValue', true,                                   ...
                'PropInfo', 'true or false');
            obj = obj@props.Prop(args{:});
        end

        function val = validate(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:propError', '%s must be %s',            ...
                      obj.Name, obj.PropInfo)
            end
        end

        function output = serialize(obj)
            if obj.Value
                output = 'true';
            else
                output = 'false';
            end
        end
    end
end

