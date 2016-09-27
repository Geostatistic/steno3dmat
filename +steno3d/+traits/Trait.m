classdef Trait
%TRAIT Summary of this class goes here
%   Detailed explanation goes here

    properties
        Value
    end
    properties (SetAccess = protected)
        Name = ''
        Doc = ''
        TraitInfo = ''
        Required = false
        ValidateDefault = true
        DefaultValue
    end

    methods
        function obj = Trait(varargin)
            if rem(nargin, 2) ~= 0
                error('steno3d:traitError',                             ...
                      ['Traits must be constructed with valid '         ...
                       '''PropertyName'', Value pairs'])
            end
            for i = 1:2:nargin
                obj.(varargin{i}) = varargin{i+1};
            end
            if obj.ValidateDefault
                obj.DefaultValue = obj.validate(obj.DynamicDefault);
            end
        end

        function value = validate(obj, value)
        end

        function obj = set.Name(obj, val)
            if ~ischar(val)
                error('steno3d:traitError',                             ...
                      'Trait property `Name` must be a string');
            end
            obj.Name = val;
        end

        function obj = set.Doc(obj, val)
            if ~ischar(val)
                error('steno3d:traitError',                             ...
                      'Trait property `Doc` must be a string');
            end
            obj.Doc = val;
        end

        function obj = set.TraitInfo(obj, val)
            if ~ischar(val)
                error('steno3d:traitError',                             ...
                      'Trait property `TraitInfo` must be a string');
            end
            obj.TraitInfo = val;
        end

        function obj = set.Required(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:traitError',                             ...
                      'Trait property `Required` must be true or false');
            end
            obj.Required = val;
        end

        function obj = set.DefaultValue(obj, val)
            obj.DefaultValue = val;
        end

        function val = DynamicDefault(obj)
            val = obj.DefaultValue;
        end

        function val = get.Value(obj)
            if isempty(obj.Value)
                val = obj.DefaultValue;
            else
                val = obj.Value;
            end
        end

        function obj = set.Value(obj, val)
            val = obj.validate(val);
            obj.Value = val;
        end
        
        function output = serialize(obj)
            mc = metaclass(obj);
            error('steno3d:traitError',                                 ...
                  'Cannot serialize trait %s of type %s',               ...
                  mc.Name, obj.Name)
            output = '';
        end
    end

    methods (Static)
        function args = setTraitDefaults(args, varargin)
            if rem(nargin, 2) ~= 1
                error('steno3d:traitError',                             ...
                      ['setTraitDefaults requires the input arguments ' ...
                       'and additional default parameter, value pairs']);
            end
            for i = 1:2:nargin-1
                if all(~strcmp(varargin{i}, args))
                    args{end+1} = varargin{i};
                    args{end+1} = varargin{i+1};
                end
            end
        end
    end

end

