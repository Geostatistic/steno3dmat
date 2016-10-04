classdef Instance < props.Prop
%INSTANCE Property that must be an instance of a given class
%
% Note: If a HasProps class must contain an instance of itself, this
%       circular pointing can be achieved with Class = eval(@HasPropsClass)

    properties (SetAccess = ?props.Prop)
        Initialize = true
        Class
        Args
    end

    methods
        function obj = Instance(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'Args', {},                                             ...
                'PropInfo', 'an instance');
            obj = obj@props.Prop(args{:});
            if isempty(obj.Class)
                error('steno3d:propError',                              ...
                      'Instance props must specify a Class')
            end
        end

        function val = validate(obj, val)
            if isempty(val) && ~obj.Required
                return
            end
            classInfo = functions(obj.Class);
            if isa(val, classInfo.function)
                return
            end
            try
                val = obj.Class(val);
                return
            catch
            end
            try
                val = obj.Class(val{:});
                return
            catch
            end
            error('steno3d:propError',                                  ...
                  ['%s must be an instance of %s (or valid arguments '  ...
                   'to construct that class)'],                         ...
                  obj.Name, classInfo.function);
        end

        function obj = set.Initialize(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:propError',                              ...
                      'Prop property `Initialize` must be true or false');
            end
            obj.Initialize = val;
        end

        function obj = set.Class(obj, val)
            if ~isa(val, 'function_handle')
                error('steno3d:propError',                              ...
                      ['Prop property `Class` must be class '           ...
                       'constructor function handle']);
            end
            obj.Class = val;
        end

        function obj = set.Args(obj, val)
            if ~iscell(val)
                error('steno3d:propError',                              ...
                      ['Prop property `Args` must be a cell array of '  ...
                       'Class constructor arguments.']);
            end
            obj.Args = val;
        end


        function val = DynamicDefault(obj)
            if obj.Initialize
                val = obj.Class(obj.Args{:});
            else
                val = obj.DefaultValue;
            end
        end

    end
end

