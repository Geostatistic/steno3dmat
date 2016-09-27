classdef Instance < steno3d.traits.Trait
%INSTANCE Summary of this class goes here
%   Detailed explanation goes here
%
% self instances can be defined with eval(@HasTraitsClass)

    properties (SetAccess = ?steno3d.traits.Trait)
        Initialize = true
        Class
        Args
    end

    methods
        function obj = Instance(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,      ...
                'Args', {},                                             ...
                'TraitInfo', 'an instance');
            obj = obj@steno3d.traits.Trait(args{:});
            if isempty(obj.Class)
                error('steno3d:traitError',                             ...
                      'Instance traits must specify a Class')
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
            error('steno3d:traitError',                                 ...
                  ['%s must be an instance of %s (or valid arguments '  ...
                   'to construct that class)'],                         ...
                  obj.Name, classInfo.function);
        end

        function obj = set.Initialize(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:traitError',                             ...
                      'Trait property `Initialize` must be true or false');
            end
            obj.Initialize = val;
        end

        function obj = set.Class(obj, val)
            if ~isa(val, 'function_handle')
                error('steno3d:traitError',                             ...
                      ['Trait property `Class` must be class '          ...
                       'constructor function handle']);
            end
            obj.Class = val;
        end

        function obj = set.Args(obj, val)
            if ~iscell(val)
                error('steno3d:traitError',                             ...
                      ['Trait property `Args` must be a cell array of ' ...
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

