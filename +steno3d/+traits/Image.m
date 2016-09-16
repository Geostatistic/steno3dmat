classdef Image < steno3d.traits.Trait
    %BOOL Summary of this class goes here
    %   Detailed explanation goes here

    methods
        function obj = Image(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,  ...
                'ValidateDefault', false,                                   ...
                'TraitInfo', 'a PNG image file or valid PNG matrix');
            obj = obj@steno3d.traits.Trait(args{:});
        end

        function val = validate(obj, val)
            try
                val = imread(val, 'png');
                return
            catch
            end
            try
                imwrite(val, [tempfile '.png'], 'png')
                return
            catch
            end
            error('steno3d:traitError', '%s must be %s',                ...
                  obj.Name, obj.TraitInfo)
        end
    end
end
