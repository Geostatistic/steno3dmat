classdef Union < props.Prop
%UNION Summary of this class goes here
%   Detailed explanation goes here

    properties (Access = ?props.Prop)
        PropTypes
    end

    methods
        function obj = Union(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'PropInfo', 'union of multiple types of props');
            obj = obj@props.Prop(args{:});
            if isempty(obj.PropTypes)
                error('steno3d:propError',                              ...
                      'Union props must define `PropTypes`')
            end
        end

        function val = validate(obj, val)
            for i = 1:length(obj.PropTypes)
                try
                    val = obj.PropTypes{i}.validate(val);
                    return
                catch
                    continue
                end
            end
            error('steno3d:propError', 'Invalid value for %s',          ...
                  obj.Name)
        end

        function obj = set.PropTypes(obj, val)
            if ~iscell(val)
                error('steno3d:propError',                              ...
                      ['Prop property `PropTypes` must be a cell '      ...
                       'array of structs defining prop '                ...
                       'construction as documented in '                 ...
                       'props.HasProps']);
            end
            propInstances = {};
            for i = 1:length(val)
                if ~isstruct(val{i}) || ~isfield(val{i}, 'Type')
                    error('steno3d:propError',                          ...
                          ['Prop property `PropTypes` must be a cell '  ...
                           'array of structs defining prop '            ...
                           'construction as documented in '             ...
                           'props.HasProps']);
                end
                if ~isa(val{i}.Type, 'function_handle')
                    error('steno3d:hasPropsError',                      ...
                          'Prop types must be prop constructor handles');
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
                propInstances{end+1} = val{i}.Type(argin{:});

                if ~isa(propInstances{end}, 'props.Prop')
                    error('steno3d:hasPropsError',                      ...
                          ['All types defined in `PropTypes` must be '  ...
                           'subclasses of props.Prop']);
                end
            end
            obj.PropTypes = propInstances;


        end

        function val = DynamicDefault(obj)
            val = obj.PropTypes{1}.DynamicDefault;
        end
    end
end

