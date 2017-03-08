classdef Float < props.Prop
%FLOAT Float prop
%   This is a type of %%%ref[props.Prop](props.Prop) that can be used when a %%%ref[props.HasProps](props.HasProps)
%   class needs a float property.
%
%   %%%bold[Attributes] (in addition to those inherited from %%%ref[props.Prop](props.Prop)):
%
%   MinValue:
%       The minimum allowed value for the property. The default
%       is -Inf (no minimum).
%
%   MaxValue:
%       The maximum allowed value for the property. The default
%       is Inf (no maximum).
%
%   Example:
%   %%%codeblock
%       ...
%       class HasFloatProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               FloatPropStruct = {                                     ...
%                   struct(                                             ...
%                       'Name', 'PositiveFloat',                        ...
%                       'Type', @props.Float,                           ...
%                       'Doc', 'A positive number',                     ...
%                       'MinValue', 0                                   ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   %%%seealso props.Prop, props.HasProps, props.Int, props.Array
%


    properties (SetAccess = ?props.Prop)
        MinValue = -Inf
        MaxValue = Inf
    end

    methods
        function obj = Float(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'DefaultValue', 0);
            obj = obj@props.Prop(args{:});
            if obj.MinValue > obj.MaxValue
                error('props:floatError',                               ...
                      'MinValue must be less than MaxValue');
            end
        end

        function obj = set.MinValue(obj, val)
            if ~isnumeric(val) || length(val(:)) ~= 1
                error('props:floatError',                               ...
                      'Prop property `MinValue` must be a number');
            end
            obj.MinValue = val;
        end

        function obj = set.MaxValue(obj, val)
            if ~isnumeric(val) || length(val(:)) ~= 1
                error('props:floatError',                               ...
                      'Prop property `MaxValue` must be a number');
            end
            obj.MaxValue = val;
        end

        function val = validate(obj, val)
            if ~isnumeric(val) || length(val(:)) ~= 1
                error('props:floatError', '%s must be a number',        ...
                      obj.Name)
            end
            if val < obj.MinValue || val > obj.MaxValue
                error('props:floatError',                               ...
                      '%s must be a number between %d and %d',          ...
                      obj.Name, obj.MinValue, obj.MaxValue)
            end
        end

        function output = serialize(obj)
            output = num2str(obj.Value);
        end

        function doc = dynamicDoc(obj, doctype)
            doc = '';
            if obj.MinValue ~= -inf
                doc = [doc 'Minimum: ' num2str(obj.MinValue)];
            end
            if obj.MaxValue ~= inf
                if ~isempty(doc)
                    doc = [doc ', '];
                end
                doc = [doc 'Maximum: ' num2str(obj.MaxValue)];
            end
        end
    end
end

