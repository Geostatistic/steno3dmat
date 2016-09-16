classdef HasTraits < dynamicprops
    %HASTRAITS Summary of this class goes here
    %   Detailed explanation goes here

    properties (Abstract, Access = protected)
        Traits  % Cell array of structs with required fields:
                %  Name, Type, Description
                % Optional fields include:
                %  Required, Repeated, DefaultValue
                % Additional fields may be available depending on the trait
    end

    methods
        function obj = HasTraits()
            if ~iscell(obj.Traits)
                error('steno3d:hasTraitsError',                         ...
                      '`Traits` property must be a cell array of structs');
            end
            for i = 1:length(obj.Traits)
                setupTrait(obj, obj.Traits{i});
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
                    ~isfield(tr, 'Description')
                error('steno3d:hasTraitsError',                         ...
                      ['All elements of `Traits` property must '        ...
                       'have fields:\nName, Type, Description'])
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
            prefix = 'Trait__';
            name = tr.Name;
            hiddenName = [prefix name];
            if strcmp(name(1:min(end, length(prefix))), prefix)
                error('steno3d:hasTraitsError',                         ...
                      ['Starting a trait name with ''%s'' may cause a ' ...
                       'name conflict; please rename %s'],              ...
                       prefix, name)
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

            function setTrait(obj, val)
                obj.(hiddenName).Value = val;
            end

            function val = getTrait(obj)
                val = obj.(hiddenName).Value;
            end
        end
    end

end

