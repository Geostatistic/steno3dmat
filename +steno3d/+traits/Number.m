classdef Number < steno3d.traits.Trait
    %INT Summary of this class goes here
    %   Detailed explanation goes here

    properties (SetAccess = ?steno3d.traits.Trait)
        MinValue = -Inf
        MaxValue = Inf
        IsInteger = false
    end

    methods
        function obj = Number(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,  ...
                'DefaultValue', 0,                                      ...
                'TraitInfo', 'a single number');
            obj = obj@steno3d.traits.Trait(args{:});
            if obj.MinValue > obj.MaxValue
                error('steno3d:traitError',                             ...
                      'MinValue must be less than MaxValue');
            end
        end

        function obj = set.MinValue(obj, val)
            if ~isnumeric(val) || length(val(:)) ~= 1
                error('steno3d:traitError',                             ...
                      'Trait property `MinValue` must be a number');
            end
            obj.MinValue = val;
        end

        function obj = set.MaxValue(obj, val)
            if ~isnumeric(val) || length(val(:)) ~= 1
                error('steno3d:traitError',                             ...
                      'Trait property `MaxValue` must be a number');
            end
            obj.MaxValue = val;
        end

        function obj = set.IsInteger(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:traitError',                             ...
                      'Trait property `IsInteger` must be true or false');
            end
            obj.IsInteger = val;
        end

        function val = validate(obj, val)
            if ~isnumeric(val) || length(val(:)) ~= 1
                error('steno3d:traitError', '%s must be %s',            ...
                      obj.Name, obj.TraitInfo)
            end
            if val < obj.MinValue || val > obj.MaxValue
                error('steno3d:traitError',                             ...
                      '%s must be a number between %d and %d',          ...
                      obj.Name, obj.MinValue, obj.MaxValue)
            end
            if obj.IsInteger && val ~= round(val)
                error('steno3d:traitError', '%s must be an integer',    ...
                      obj.Name)
            end
        end
    end
end

