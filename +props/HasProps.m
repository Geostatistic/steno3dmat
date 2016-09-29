classdef HasProps < dynamicprops
%HASPROPS Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        % Cell array of structs with required fields:
        %  Name, Type, Doc
        % Optional fields include:
        %  Required, Repeated, DefaultValue
        % Additional fields may be available depending on the prop
    end

    properties (Constant, Hidden)
        PROP_PREFIX = 'PR_';
    end

    properties (Hidden, Access = private)
        PR__val = false
    end

    properties (Hidden, SetAccess = private)
        PR__props = {}
    end


    methods
        function obj = HasProps(varargin)
            mc = metaclass(obj);
            pl = mc.PropertyList;
            for i = 1:length(pl)
                if ~strcmpi(pl(i).SetAccess, 'immutable')
                    continue
                end
                props = obj.(pl(i).Name);
                if ~iscell(props)
                    continue
%                     error('steno3d:hasPropsError',                     ...
%                           ['`protected` properties of HasProps '       ...
%                            'classes are assumed to be Prop '           ...
%                            'constructors and therefore must be cell ' ...
%                            'arrays of structs']);
                end
                for j = 1:length(props)
                    setupProp(obj, props{j});
                end
            end

            if length(varargin) == 1
                varargin = varargin{1};
            end
            if rem(length(varargin), 2) ~= 0
                error('steno3d:hasPropsError',                          ...
                      ['Input to HasProps class must be property/value' ...
                       ' pairs']);
            end
            for i = 1:2:length(varargin)
                if ~ischar(varargin{i})
                    error('steno3d:hasPropsError',                      ...
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
            validating = [obj.PROP_PREFIX '_val'];
            if obj.(validating)
                return
            end
            ME = [];
            obj.(validating) = true;
            try
                propNames = obj.([obj.PROP_PREFIX '_props']);
                for i = 1:length(propNames)
                    value = obj.(propNames{i});
                    prop = obj.([obj.PROP_PREFIX propNames{i}]);
                    if prop.Required && isempty(value)
                        error('steno3d:propError',                      ...
                              'Required prop ''%s'' not set', prop.Name);
                    end
                    if ~isempty(value)
                        prop.validate(value);
                        for j = 1:length(value)
                            v = value(j);
                            if isa(v, 'props.HasProps')
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
        function setupProp(obj, tr)
            if ~isstruct(tr)
                error('steno3d:hasPropsError',                          ...
                      'All elements of `Props` property must be structs');
            end
            if ~isfield(tr, 'Name') || ~isfield(tr, 'Type') ||          ...
                    ~isfield(tr, 'Doc')
                error('steno3d:hasPropsError',                          ...
                      ['All elements of `Props` property must '         ...
                       'have fields:\nName, Type, Doc'])
            end
            if length(tr(:)) ~= 1
                error('steno3d:hasPropsError',                          ...
                      ['''%s'' Prop struct must be size 1. Please '     ...
                       'ensure if you have a cell array inside a Prop ' ...
                       'struct, it is nested in a size 1 cell array.'], ...
                       tr(1).Name);
            end
            if ~ischar(tr.Name)
                error('steno3d:hasPropsError',                          ...
                      'Prop Names must be strings');
            end
            if ~isa(tr.Type, 'function_handle')
                error('steno3d:hasPropsError',                          ...
                      'Prop Types must be prop constructor handles');
            end
            name = tr.Name;
            hiddenName = [obj.PROP_PREFIX name];
            if strcmp(name(1:min(end, length(obj.PROP_PREFIX))),        ...
                      obj.PROP_PREFIX)
                error('steno3d:hasPropsError',                          ...
                      ['Starting a prop name with ''%s'' may cause a '  ...
                       'name conflict; please rename %s'],              ...
                       obj.PROP_PREFIX, name)
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
            metaHiddenProp = addprop(obj, hiddenName);
            obj.(hiddenName) = tr.Type(argin{:});
            if ~isa(obj.(hiddenName), 'props.Prop')
                error('steno3d:hasPropsError',                          ...
                      ['All types defined in `Props` must be '          ...
                       'subclasses of props.Prop']);
            end
            metaProp.SetMethod = @setProp;
            metaProp.GetMethod = @getProp;
            metaHiddenProp.Hidden = true;
            obj.([obj.PROP_PREFIX '_props']){end+1} = name;

            function setProp(obj, val)
                obj.(hiddenName).Value = val;
            end

            function val = getProp(obj)
                val = obj.(hiddenName).Value;
            end
        end
    end

end

