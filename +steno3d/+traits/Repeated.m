classdef Repeated < steno3d.traits.Trait
%REPEATED Summary of this class goes here
%   Detailed explanation goes here

    properties (Access = ?steno3d.traits.Trait)
        TraitType
    end

    methods
        function obj = Repeated(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,      ...
                'TraitInfo', 'muliple values of a certain type of trait');
            obj = obj@steno3d.traits.Trait(args{:});
            if isempty(obj.TraitType)
                error('steno3d:traitError',                             ...
                      'Repeated traits must define `TraitType`')
            end
        end

        function val = validate(obj, val)
            if ~iscell(val)
                val = {val};
            end
            for i = 1:length(val)
                val{i} = obj.TraitType.validate(val{i});
            end
        end

        function obj = set.TraitType(obj, val)
            if ~isstruct(val)
                error('steno3d:traitError',                             ...
                      ['Trait property `TraitType` must be a struct '   ...
                       'defining trait construction as documented in '  ...
                       'steno3d.traits.HasTraits']);
            end
            if ~isfield(val, 'Type')
                error('steno3d:traitError',                             ...
                      'Trait property `TraitType` must define `Type`');
            end
            if ~isa(val.Type, 'function_handle')
                error('steno3d:hasTraitsError',                         ...
                      'Trait type must be trait constructor handles');
            end
            fields = fieldnames(val);
            argin = {};
            for j = 1:length(fields)
                f = fields{j};
                if strcmp(f, 'Type')
                    continue
                end
                argin{end+1} = f;
                argin{end+1} = val.(f);
            end
            traitInstance = val.Type(argin{:});

            if ~isa(traitInstance, 'steno3d.traits.Trait')
                error('steno3d:hasTraitsError',                         ...
                      ['Types defined in `TraitType` must be a '        ...
                       'subclass of steno3d.traits.Trait']);
            end
            obj.TraitType = traitInstance;
        end

        function val = DynamicDefault(obj)
            val = obj.TraitType.DynamicDefault;
        end
    end
end
