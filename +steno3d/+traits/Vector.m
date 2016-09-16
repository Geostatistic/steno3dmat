classdef Vector < steno3d.traits.Array
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    methods
        function obj = Vector(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,      ...
                'Shape', {{1, 3}},                                      ...
                'DefaultValue', [0, 0, 0],                              ...
                'ValidateDefault', true,                                ...
                'TraitInfo', 'a vector of length 3');
            obj = obj@steno3d.traits.Array(args{:});
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
            val = validate@steno3d.traits.Array(obj, val);
        end
    end

end
