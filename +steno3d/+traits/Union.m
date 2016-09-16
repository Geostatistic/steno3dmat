classdef Union < steno3d.traits.Trait
    %BOOL Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = ?steno3d.traits.Trait)
        TraitTypes
    end

    methods
        function obj = Union(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,  ...
                'TraitInfo', 'union of multiple types of traits');
            obj = obj@steno3d.traits.Trait(args{:});
            if isempty(obj.TraitTypes)
                error('steno3d:traitError',                             ...
                      'Union traits must define `TraitTypes`')
            end
        end

        function val = validate(obj, val)
            for i = 1:length(obj.TraitTypes)
                try
                    val = obj.TraitTypes{i}.validate(val);
                    return
                catch
                    continue
                end
            end
            error('steno3d:traitError', 'Invalid value for %s',         ...
                  obj.Name)
        end

        function obj = set.TraitTypes(obj, val)
            if ~iscell(val)
                error('steno3d:traitError',                             ...
                      ['Trait property `TraitTypes` must be a cell '    ...
                       'array of structs defining trait '               ...
                       'construction as documented in '                 ...
                       'steno3d.traits.HasTraits']);
            end
            traitInstances = {};
            for i = 1:length(val)
                if ~isstruct(val{i}) || ~isfield(val{i}, 'Type')
                    error('steno3d:traitError',                         ...
                          ['Trait property `TraitTypes` must be a cell '...
                           'array of structs defining trait '           ...
                           'construction as documented in '             ...
                           'steno3d.traits.HasTraits']);
                end
                if ~isa(val{i}.Type, 'function_handle')
                    error('steno3d:hasTraitsError',                     ...
                          'Trait Types must be trait constructor handles');
                end
                fields = fieldnames(val{i});
                argin = {};
                for j = 1:length(fields)
                    f = fields{j};
                    if strcmp(f, 'Type')
                        continue
                    end
                    argin{end+1} = f;
                    argin{end+1} = val{i}.(f);
                end
                traitInstances{end+1} = val{i}.Type(argin{:});

                if ~isa(traitInstances{end}, 'steno3d.traits.Trait')
                    error('steno3d:hasTraitsError',                     ...
                          ['All types defined in `TraitTypes` must be ' ...
                           'subclasses of steno3d.traits.Trait']);
                end
            end
            obj.TraitTypes = traitInstances;


        end

        function val = DynamicDefault(obj)
            firstType = obj.TraitTypes{1};
            val = firstType.DynamicDefault;
        end
    end
end

