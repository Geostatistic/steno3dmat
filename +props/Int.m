classdef Int < props.Float
%INT Integer prop
%   This is a type of props.Prop that can be used when a props.HasProps
%   class needs an integer property.
%
%   PROPERTIES - No properties besides those inherited from props.Float
%
%   Example:
%       ...
%       class HasIntProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               IntPropStruct = {                                       ...
%                   struct(                                             ...
%                       'Name', 'Int0to10',                             ...
%                       'Type', @props.Int,                             ...
%                       'Doc', 'An integer between 0 and 10',           ...
%                       'MinValue', 0,                                  ...
%                       'MaxValue', 10                                  ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   See also props.Prop, props.HasProps, props.Float, props.Array,
%   props.Bool
%


    methods
        function obj = Int(varargin)
            args = props.Prop.setPropDefaults(varargin);
            obj = obj@props.Float(args{:});
        end
        
        function val = validate(obj, val)
            val = validate@props.Float(obj, val);
            if val ~= round(val)
                error('props:intError', '%s must be an integer',        ...
                      obj.Name)
            end
        end
    end
end

