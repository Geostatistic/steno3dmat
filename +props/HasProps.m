classdef HasProps < dynamicprops
%HASPROPS Class with dynamically created, declarative Props
%   PROPS.HASPROPS is designed to aid creation of classes by providing a 
%   declarative interface for creating type-checked, validated and
%   cross-validated properties.
%
%   DECLARING DYNAMIC PROPS:
%       The props of a PROPS.HASPROPS subclass are declared in an immutable
%       property that is a cell array of structs. It is recommended but not
%       required to set this property to 'Hidden' since it is unused after
%       class instantiated.
% 
%       The required fields of each struct in this immutable cell array are
%       'Name' (the name by which the prop value will be accessed), 'Type'
%       (a handle to the type of prop), and 'Doc' (a description of the
%       prop). Optional fields include 'Required' and 'DefaultValue', and
%       specific types of props may have additional fields.
%
%   ADDING VALIDATION:
%       Individual Props are validated, type-checked, and possibly coerced
%       to new values when set. This validation logic is defined in the
%       specific Prop class.
%
%       PROPS.HASPROPS classes also have a framework for cross-validating
%       properties. To utilize this, define a "validator()" method that
%       checks prop combinations and errors if they are invalid. Then, when
%       you call "validate()" on the PROPS.HASPROPS instance, all the
%       validation methods will be called recursively.
%
%   INSTANTIATING THE CLASS:
%       Upon instantiation, each struct declared in the immutable cell
%       array will be converted into two properties: and accessible
%       property, Name, that is used to get and set the prop value, and a
%       hidden property, PR_Name, the underlying instance of props.Prop
%       where the value is actually validated and stored.
%
%       PROPS.HASPROPS allows you to assign prop values on instantiation by
%       passing in Parameter/Value pairs. However, this requires defining a
%       constructor method that passes varargin to the PROPS.HASPROPS
%       constructor. If this constructor is not defined, the default
%       constructor takes no arguments, and passing Parameter/Value pairs
%       will result in an error.
%
%   A simple example of a PROPS.HASPROPS subclass is provided at
%   props.examples.CandyJar. It may help to look at the <a href="matlab:
%   help props.examples.CandyJar">implementation of</a>
%   <a href="matlab: help props.examples.CandyJar
%   ">CandyJar</a> and an <a href="matlab:
%   help props.examples.CandyJarScript
%   ">example script using a CandyJar instance</a>.
%
%   For a more substantial practical example, look at the Steno3D MATLAB
%   client on <a href="matlab:
%   web('https://github.com/3ptscience/steno3dmat','-browser')">github</a>.
%
%   See also props.Prop, props.examples.CandyJar,
%   props.examples.CandyJarScript
%   


    properties (Hidden, SetAccess = immutable)
    %PROPERTIES Here, dynamic props are defined in a cell array of structs
    %   Required fields: Name, Type, Doc
    %   Optional fields: Required, DefaultValue
    %   Additional fields may be available depending on the prop Type
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
        %HASPROPS Constructor builds dynamic props, assigns initial values
            if verLessThan('matlab', '8.4')
                error('props:versionError', ['Props requires MATLAB '   ...
                      'Release R2014b (8.4) or greater']);
            end
            % First look through the class properties. All properties that
            % are NOT immutable cell arrays will be treated like normal
            % MATLAB class properties.
            %
            % Properties that ARE immutable cell arrays will be used to
            % setup the dynamic props. PROPS.HASPROPS classes CANNOT have
            % immutable cell array properties that are not used to setup
            % props; they will error.
            mc = metaclass(obj);
            pl = mc.PropertyList;
            for i = 1:length(pl)
                if ~strcmpi(pl(i).SetAccess, 'immutable')
                    continue
                end
                props = obj.(pl(i).Name);
                if ~iscell(props)
                    continue
                end
                for j = 1:length(props)
                    setupProp(obj, props{j});
                end
            end
            % After building the instance with dynamic props, assign
            % initial values based on Parameter/Value pairs from varargin
            if length(varargin) == 1
                varargin = varargin{1};
            end
            if rem(length(varargin), 2) ~= 0
                error('props:hasPropsError',                            ...
                      ['Input to HasProps class must be property/value '...
                       'pairs']);
            end
            for i = 1:2:length(varargin)
                if ~ischar(varargin{i})
                    error('props:hasPropsError',                        ...
                          ['Input property names for property/value '   ...
                           'pairs must be strings']);
                end
                obj.(varargin{i}) = varargin{i+1};
            end
        end
    end
    
    methods (Hidden)
        function validator(obj)
        %VALIDATOR Cross-validates different properties
        %   This function contains any validation that does not happen
        %   within the individual props.Prop instance. It errors if
        %   different prop values conflict.
        %
        %   "obj.validate()" should be used to validate PROPS.HASPROPS
        %   instances. That function calls "obj.validator()" in addition to
        %   performing other validation.
        end
    end

    methods (Sealed)
        function validate(obj)
        %VALIDATE Validates a PROPS.HASPROPS instance
        %   This function re-validates all the prop values, ensures that
        %   all the Required props are set, calls the object validator
        %   functions, and recursively validates any other PROPS.HASPROPS
        %   instances contained within the instance.
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
                        error('props:hasPropsError',                    ...
                              'Required prop ''%s'' not set', prop.Name);
                    end
                    if ~isempty(value)
                        prop.validate(value);
                        if isa(value, 'props.HasProps')
                            value.validate()
                        elseif iscell(value)
                            for j = 1:length(value)
                                v = value{j};
                                if isa(v, 'props.HasProps')
                                    v.validate();
                                end
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
        % SETUPPROP Ensures prop struct is valid, builds dynamic properties
        %   This function is only called on class instantiation. It
        %   validates each struct in the immutable cell array properties,
        %   and uses those structs to create (1) a dynamic property visible
        %   to the user for setting and getting props and (2) a hidden
        %   dynamic property containing a props.Prop instance where the 
        %   property value is stored and validated.
            if ~isstruct(tr)
                error('props:hasPropsError',                            ...
                      'All elements of `Props` property must be structs');
            end
            if ~isfield(tr, 'Name') || ~isfield(tr, 'Type') ||          ...
                    ~isfield(tr, 'Doc')
                error('props:hasPropsError',                            ...
                      ['All elements of `Props` property must '         ...
                       'have fields:\nName, Type, Doc'])
            end
            if length(tr(:)) ~= 1
                error('props:hasPropsError',                            ...
                      ['''%s'' Prop struct must be size 1. Please '     ...
                       'ensure if you have a cell array inside a Prop ' ...
                       'struct, it is nested in a size 1 cell array.'], ...
                       tr(1).Name);
            end
            if ~ischar(tr.Name)
                error('props:hasPropsError',                            ...
                      'Prop Names must be strings');
            end
            if ~isa(tr.Type, 'function_handle')
                error('props:hasPropsError',                            ...
                      'Prop Types must be prop constructor handles');
            end
            name = tr.Name;
            hiddenName = [obj.PROP_PREFIX name];
            if strcmp(name(1:min(end, length(obj.PROP_PREFIX))),        ...
                      obj.PROP_PREFIX)
                error('props:hasPropsError',                            ...
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
                error('props:hasPropsError',                            ...
                      ['All types defined in `Props` must be '          ...
                       'subclasses of props.Prop']);
            end
            metaProp.SetMethod = @setProp;
            metaProp.GetMethod = @getProp;
            metaHiddenProp.Hidden = true;
            metaHiddenProp.SetObservable = true;
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

