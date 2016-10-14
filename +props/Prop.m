classdef Prop
%PROP Basic property with no given type
%   Used with subclasses of props.HasProps, a PROPS.PROP instance is
%   created dynamically on class instantiation based on a declarative,
%   immutable property of the props.HasProps class. For more information
%   about to use PROPS.PROP, see <a href="matlab: help props.HasProps
%   ">props.HasProps</a>, a <a href="matlab: help props.examples.CandyJar
%   ">simple example</a>, or the
%   specific types listed below.
%
%   PROPS.PROP PROPERTIES
%       Value: The saved value of the PROPS.PROP.
%
%       Name: The name used to access the value of PROPS.PROP from the
%             props.HasProps class.
%
%       Doc: A description of the specific PROPS.PROP on a props.HasProps
%            class.
%
%       Required: Whether or not the PROPS.PROP must be given a value for a
%                 props.HasProps instance to pass validation.
%
%       ValidateDefault: Whether or not the DefaultValue must pass
%                        validation.
%
%       DefaultValue: The default value when the PROPS.PROP is accessed
%                     prior to getting set.
%
%   See also PROPS.HASPROPS, PROPS.ARRAY, PROPS.BOOL, PROPS.COLOR,
%   PROPS.FLOAT, PROPS.IMAGE, PROPS.INSTANCE, PROPS.INT, PROPS.REPEATED,
%   PROPS.STRING, PROPS.UNION, PROPS.VECTOR
%


    properties
        Value
    end
    properties (SetAccess = protected)
        Name = ''
        Doc = ''
        Required = false
        ValidateDefault = true
        DefaultValue
    end

    methods
        function obj = Prop(varargin)
            % PROP Construct from property/value paris
            
            if rem(nargin, 2) ~= 0
                error('props:propError',                                ...
                      ['Props must be constructed with valid '          ...
                       '''PropertyName'', Value pairs'])
            end
            for i = 1:2:nargin
                obj.(varargin{i}) = varargin{i+1};
            end
            if obj.ValidateDefault
                obj.DefaultValue = obj.validate(obj.DynamicDefault);
            end
        end

        function value = validate(obj, value)
            % VALIDATE Check if a value is valid for the given Prop
        end

        function obj = set.Name(obj, val)
            if ~ischar(val)
                error('props:propError',                                ...
                      'Prop property `Name` must be a string');
            end
            obj.Name = val;
        end

        function obj = set.Doc(obj, val)
            if ~ischar(val)
                error('props:propError',                                ...
                      'Prop property `Doc` must be a string');
            end
            obj.Doc = val;
        end

        function obj = set.Required(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('props:propError',                                ...
                      'Prop property `Required` must be true or false');
            end
            obj.Required = val;
        end

        function obj = set.DefaultValue(obj, val)
            obj.DefaultValue = val;
        end

        function val = DynamicDefault(obj)
            val = obj.DefaultValue;
        end

        function val = get.Value(obj)
            if isempty(obj.Value)
                val = obj.DefaultValue;
            else
                val = obj.Value;
            end
        end

        function obj = set.Value(obj, val)
            val = obj.validate(val);
            obj.Value = val;
        end

        function output = serialize(obj)
            % SERIALIZE Convert the Prop value to a standard format
            mc = metaclass(obj);
            error('props:propError',                                    ...
                  'Cannot serialize prop %s of type %s',                ...
                  mc.Name, obj.Name)
            output = '';
        end
        
        function doc = dynamicDoc(obj)
            doc = '';
        end
    end

    methods (Static)
        function args = setPropDefaults(args, varargin)
        % SETPROPDEFAULTS Inspect input values and add additional defaults
        %   ARGS = SETPROPDEFAULTS(ARGS, VARARGIN) takes VARARGIN
        %   default parameter/value pairs and, if those parameters are not
        %   set to alternative values in cell array ARGS, appends them to
        %   ARGS.
        
            if rem(nargin, 2) ~= 1
                error('props:propError',                                ...
                      ['setPropDefaults requires the input arguments '  ...
                       'and additional default parameter, value pairs']);
            end
            for i = 1:2:nargin-1
                if all(~strcmp(varargin{i}, args))
                    args{end+1} = varargin{i};
                    args{end+1} = varargin{i+1};
                end
            end
        end
    end
end

