classdef Union < props.Prop
%UNION Prop that may be one of several different types of props
%   This is a type of props.Prop that can be used when a props.HasProps
%   class needs a property that can be multiple types. When the property is
%   assigned, PROPS.UNION attempts to validate it as each type until it
%   succeeds.
%
%   PROPERTIES (in addition to those inherited from props.Prop)
%       PropTypes: A nested cell array of structs that define the valid
%                  prop types. The structs in PropTypes require Type handle
%                  but do not require Name or Doc - those are inherited
%                  from the PROPS.UNION values. Note: The requirement for
%                  nesting the cell array is necessary to subvert MATLAB's
%                  default treatment of cell arrays contained in structs.
%                  See the example below for how this is implemented.
%
%   Example:
%       ...
%       class HasUnionProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               UnionPropStruct = {                                     ...
%                   struct(                                             ...
%                       'Name', 'StringOrInt',                          ...
%                       'Type', @props.Union,                           ...
%                       'Doc', 'This property is a string or an int>0', ...
%                       'PropTypes', {{struct(                          ...
%                           'Type', @props.Int,                         ...
%                           'MinValue', 0                               ...
%                       ), struct(                                      ...
%                           'Type', @props.String                       ...
%                       )}}                                             ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   See also props.Prop, props.HasProps, props.Int, props.String,
%   props.Repeated, props.Instance
%


    properties (Access = ?props.Prop)
        PropTypes
    end

    methods
        function obj = Union(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'PropInfo', 'union of multiple types of props');
            obj = obj@props.Prop(args{:});
            if isempty(obj.PropTypes)
                error('props:unionError',                               ...
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
            error('props:unionError', 'Invalid value for %s',          ...
                  obj.Name)
        end

        function obj = set.PropTypes(obj, val)
            if ~iscell(val)
                error('props:unionError',                               ...
                      ['Prop property `PropTypes` must be a cell '      ...
                       'array of structs defining prop '                ...
                       'construction as documented in '                 ...
                       'props.HasProps']);
            end
            propInstances = {};
            for i = 1:length(val)
                if ~isstruct(val{i}) || ~isfield(val{i}, 'Type')
                    error('props:unionError',                           ...
                          ['Prop property `PropTypes` must be a cell '  ...
                           'array of structs defining prop '            ...
                           'construction as documented in '             ...
                           'props.HasProps']);
                end
                if ~isa(val{i}.Type, 'function_handle')
                    error('props:unionError',                           ...
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
                argin = props.Prop.setPropDefaults(                     ...
                    argin, 'Name', obj.Name, 'Doc', obj.Doc             ...
                );
                propInstances{end+1} = val{i}.Type(argin{:});

                if ~isa(propInstances{end}, 'props.Prop')
                    error('props:unionError',                           ...
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

