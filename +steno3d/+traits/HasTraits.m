classdef HasTraits < dynamicprops
%HASTRAITS Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        % Cell array of structs with required fields:
        %  Name, Type, Doc
        % Optional fields include:
        %  Required, Repeated, DefaultValue
        % Additional fields may be available depending on the trait
    end

    properties (Constant, Hidden)
        TRAIT_PREFIX = 'TR_';
    end

    properties (Hidden, Access = private)
        TR__val = false
    end

    properties (Hidden, SetAccess = private)
        TR__traits = {}
    end


    methods
        function obj = HasTraits(varargin)
            mc = metaclass(obj);
            pl = mc.PropertyList;
            for i = 1:length(pl)
                if ~strcmpi(pl(i).SetAccess, 'immutable')
                    continue
                end
                traits = obj.(pl(i).Name);
                if ~iscell(traits)
                    continue
%                     error('steno3d:hasTraitsError',                     ...
%                           ['`protected` properties of HasTraits '       ...
%                            'classes are assumed to be Trait '           ...
%                            'constructors and therefore must be cell ' ...
%                            'arrays of structs']);
                end
                for j = 1:length(traits)
                    setupTrait(obj, traits{j});
                end
            end

            if length(varargin) == 1
                varargin = varargin{1};
            end
            if rem(length(varargin), 2) ~= 0
                error('steno3d:hasTraitsError',                         ...
                      ['Input to HasTraits class must be property/value'...
                       ' pairs']);
            end
            for i = 1:2:length(varargin)
                if ~ischar(varargin{i})
                    error('steno3d:hasTraitsError',                     ...
                          ['Input property names for property/value '   ...
                           'pairs must be strings']);
                end
                obj.(varargin{i}) = varargin{i+1};
            end
        end

        function valid = validator(obj)
            valid = true;
        end

    end

    methods (Sealed)

        function validate(obj)
            validating = [obj.TRAIT_PREFIX '_val'];
            if obj.(validating)
                return
            end
            ME = [];
            obj.(validating) = true;
            try
                traitNames = obj.([obj.TRAIT_PREFIX '_traits']);
                for i = 1:length(traitNames)
                    value = obj.(traitNames{i});
                    trait = obj.([obj.TRAIT_PREFIX traitNames{i}]);
                    if trait.Required && isempty(value)
                        error('steno3d:traitError',                     ...
                              'Required trait ''%s'' not set', trait.Name);
                    end
                    if ~isempty(value)
                        trait.validate(value);
                        for j = 1:length(value)
                            v = value(j);
                            if isa(v, 'steno3d.traits.HasTraits')
                                v.validate();
                            end
                        end
                    end
                end
                obj.validator();
            catch ME
            end
            obj.(validating) = false;
            if ~isempty(ME)
                rethrow(ME);
            end
        end
    end

    methods (Access = private)
        function setupTrait(obj, tr)
            if ~isstruct(tr)
                error('steno3d:hasTraitsError',                         ...
                      'All elements of `Traits` property must be structs');
            end
            if ~isfield(tr, 'Name') || ~isfield(tr, 'Type') ||          ...
                    ~isfield(tr, 'Doc')
                error('steno3d:hasTraitsError',                         ...
                      ['All elements of `Traits` property must '        ...
                       'have fields:\nName, Type, Doc'])
            end
            if length(tr(:)) ~= 1
                error('steno3d:hasTraitsError',                         ...
                      ['''%s'' Trait struct must be size 1. Please '    ...
                       'ensure if you have a cell array inside a Trait '...
                       'struct, it is nested in a size 1 cell array.'], ...
                       tr(1).Name);
            end
            if ~ischar(tr.Name)
                error('steno3d:hasTraitsError',                         ...
                      'Trait Names must be strings');
            end
            if ~isa(tr.Type, 'function_handle')
                error('steno3d:hasTraitsError',                         ...
                      'Trait Types must be trait constructor handles');
            end
            name = tr.Name;
            hiddenName = [obj.TRAIT_PREFIX name];
            if strcmp(name(1:min(end, length(obj.TRAIT_PREFIX))),       ...
                      obj.TRAIT_PREFIX)
                error('steno3d:hasTraitsError',                         ...
                      ['Starting a trait name with ''%s'' may cause a ' ...
                       'name conflict; please rename %s'],              ...
                       obj.TRAIT_PREFIX, name)
            end
            fields = fieldnames(tr);
            argin = {};
            for j = 1:length(fields)
                f = fields{j};
                if strcmp(f, 'Type')
                    continue
                end
                argin{end+1} = f;
                argin{end+1} = tr.(f);
            end
            metaProp = addprop(obj, name);
            metaTrait = addprop(obj, hiddenName);
            obj.(hiddenName) = tr.Type(argin{:});
            if ~isa(obj.(hiddenName), 'steno3d.traits.Trait')
                error('steno3d:hasTraitsError',                         ...
                      ['All types defined in `Traits` must be '         ...
                       'subclasses of steno3d.traits.Trait']);
            end
            metaProp.SetMethod = @setTrait;
            metaProp.GetMethod = @getTrait;
            metaTrait.Hidden = true;
            obj.([obj.TRAIT_PREFIX '_traits']){end+1} = name;

            function setTrait(obj, val)
                obj.(hiddenName).Value = val;
            end

            function val = getTrait(obj)
                val = obj.(hiddenName).Value;
            end
        end
    end

end

