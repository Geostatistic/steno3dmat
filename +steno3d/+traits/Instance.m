classdef Instance < steno3d.traits.Trait
    %BOOL Summary of this class goes here
    %   Detailed explanation goes here

    properties (SetAccess = ?steno3d.traits.Trait)
        Initialize = true
        Klass
        Args
    end

    methods
        function obj = Instance(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,  ...
                'Args', {},                                             ...
                'TraitInfo', 'an instance');
            obj = obj@steno3d.traits.Trait(args{:});
            if isempty(obj.Klass)
                error('steno3d:traitError',                             ...
                      'Instance traits must specify a Klass')
            end
        end

        function val = validate(obj, val)
            if isempty(val) && ~obj.Required
                return
            end
            klassInfo = functions(obj.Klass);
            if ~isa(val, klassInfo.function)
                error('steno3d:traitError',                             ...
                      '%s must be an instance of %s',                   ...
                      obj.Name, klassInfo.function)
            end
        end

        function obj = set.Initialize(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:traitError',                             ...
                      'Trait property `Initialize` must be true or false');
            end
            obj.Initialize = val;
            if ~val
                obj.ValidateDefault = false;
            end
        end

        function obj = set.Klass(obj, val)
            if ~isa(val, 'function_handle')
                error('steno3d:traitError',                             ...
                      ['Trait property `Klass` must be class '          ...
                       'constructor function handle']);
            end
            obj.Klass = val;
        end

        function obj = set.Args(obj, val)
            if ~iscell(val)
                error('steno3d:traitError',                             ...
                      ['Trait property `Args` must be a cell array of ' ...
                       'Klass constructor arguments.']);
            end
            obj.Args = val;
        end


        function val = DynamicDefault(obj)
            if obj.Initialize
                val = obj.Klass(obj.Args{:});
            else
                val = obj.DefaultValue;
            end
        end

    end
end

