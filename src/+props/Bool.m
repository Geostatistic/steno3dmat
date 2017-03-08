classdef Bool < props.Prop
%BOOL Boolean prop
%   This is a type of %%%ref[props.Prop](props.Prop) that can be used when a %%%ref[props.HasProps](props.HasProps)
%   class needs a boolean property.
%
%   %%%bold[Attributes] - No properties besides those inherited from %%%ref[props.Prop](props.Prop)
%
%   Example:
%   %%%codeblock
%       ...
%       class HasBoolProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               BoolPropStruct = {                                      ...
%                   struct(                                             ...
%                       'Name', 'IsSomething',                          ...
%                       'Type', @props.Bool,                            ...
%                       'Doc', 'Is it something?',                      ...
%                       'DefaultValue', true                            ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   %%%seealso props.Prop, props.HasProps, props.Int
%

    methods
        function obj = Bool(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'DefaultValue', true);
            obj = obj@props.Prop(args{:});
        end

        function val = validate(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('props:boolError', '%s must be true or false',    ...
                      obj.Name)
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

