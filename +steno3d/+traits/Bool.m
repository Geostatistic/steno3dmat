classdef Bool < steno3d.traits.Trait
%BOOL Summary of this class goes here
%   Detailed explanation goes here

    methods
        function obj = Bool(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,      ...
                'DefaultValue', true,                                   ...
                'TraitInfo', 'true or false');
            obj = obj@steno3d.traits.Trait(args{:});
        end

        function val = validate(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:traitError', '%s must be %s',            ...
                      obj.Name, obj.TraitInfo)
            end
        end
        
        function output = serialize(obj)
            if obj.Value
                output = 'True';
            else
                output = 'False';
            end
        end
    end
end

