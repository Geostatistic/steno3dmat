classdef Int < steno3d.traits.Float
%INT Summary of this class goes here
%   Detailed explanation goes here

    methods
        function obj = Int(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,      ...
                'TraitInfo', 'a single integer',                        ...
                'IsInteger', true);
            obj = obj@steno3d.traits.Float(args{:});
        end
    end
end

