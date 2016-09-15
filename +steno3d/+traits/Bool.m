classdef Bool < steno3d.traits.BaseTrait
    %BOOL Summary of this class goes here
    %   Detailed explanation goes here

    methods
        function obj = Bool(varargin)
            args = steno3d.traits.BaseTrait.setTraitDefaults(varargin,  ...
                'DefaultValue', true,                                   ...
                'TraitInfo', 'true or false');
            obj = obj@steno3d.traits.BaseTrait(args{:});
        end

        function val = validate(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:traitError', '%s must be %s',            ...
                      obj.Name, obj.TraitInfo)
            end
        end
    end
end

