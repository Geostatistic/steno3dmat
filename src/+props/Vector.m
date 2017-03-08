classdef Vector < props.Array
%VECTOR Three-component vector prop
%   This is a type of %%%ref[props.Prop](props.Prop) that can be used when a %%%ref[props.HasProps](props.HasProps)
%   class needs a vector property. PROPS.VECTOR is a props.Array with
%   different default values. Overriding these defaults is allowed but not
%   recommended; just use props.Array instead. PROPS.VECTOR also allows the
%   values 'X', 'Y', and 'Z'; these are converted to [1 0 0], [0 1 0], and
%   [0 0 1], respectively.
%
%   %%%bold[Attributes] - No properties besides those inherited from %%%ref[props.Array](props.Array)
%
%   Example:
%   %%%codeblock
%       ...
%       class HasVectorProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               VectorPropStruct = {                                    ...
%                   struct(                                             ...
%                       'Name', 'ViewDirection',                        ...
%                       'Type', @props.Vector,                          ...
%                       'Doc', 'Three-component view direction vector', ...
%                       'DefaultValue', 'Z'                             ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   %%%seealso props.Prop, props.HasProps, props.Array, props.Float
%


    methods
        function obj = Vector(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'Shape', {1, 3},                                        ...
                'DefaultValue', [0 0 0],                                ...
                'ValidateDefault', true);
            obj = obj@props.Array(args{:});
        end

        function val = validate(obj, val)
            if ischar(val)
                if strcmpi(val, 'x')
                    val = [1 0 0];
                elseif strcmpi(val, 'y')
                    val = [0 1 0];
                elseif strcmpi(val, 'z')
                    val = [0 0 1];
                end
            end
            val = validate@props.Array(obj, val);
        end
    end
end
