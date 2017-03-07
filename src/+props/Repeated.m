classdef Repeated < props.Prop
%REPEATED Prop that is a repeated number of another type of prop
%   This is a type of %%%ref[props.Prop](props.Prop) that can be used when a %%%ref[props.HasProps](props.HasProps)
%   class needs a property that can be multiple values of one types.
%   PROPS.REPEATED stores the repeated values in a cell array; each value
%   is validated.
%
%   PROPERTIES (in addition to those inherited from %%%ref[props.Prop](props.Prop))
%       PropType: A struct that defines another valid prop type. This
%                 struct requires Type handle but not Name or Doc - those
%                 are inherited from the PROPS.REPEATED values.
%
%   Example:
%   %%%codeblock
%       ...
%       class HasRepeatedProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               RepeatedPropStruct = {                                  ...
%                   struct(                                             ...
%                       'Name', 'MultipleColors',                       ...
%                       'Type', @props.Repeated,                        ...
%                       'Doc', 'This propery can hold multiple colors', ...
%                       'PropType', struct(                             ...
%                           'Type', @props.Color                        ...
%                       )                                               ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   %%%seealso props.Prop, props.HasProps, props.Union, props.Array,
%   props.Color
%


    properties (SetAccess = ?props.Prop)
        PropType
    end

    methods
        function obj = Repeated(varargin)
            args = props.Prop.setPropDefaults(varargin);
            obj = obj@props.Prop(args{:});
            if isempty(obj.PropType)
                error('props:repeatedError',                            ...
                      'Repeated props must define `PropType`')
            end
        end

        function val = validate(obj, val)

            if isempty(val)
                val = {};
                return
            end
            try
                val = {obj.PropType.validate(val)};
                return
            catch
            end

            for i = 1:length(val)
                if iscell(val)
                    temp_val{i} = obj.PropType.validate(val{i});
                else
                    temp_val{i} = obj.PropType.validate(val(i));
                end
            end
            val = temp_val;
        end

        function obj = set.PropType(obj, val)
            if ~isstruct(val)
                error('props:repeatedError',                            ...
                      ['Prop property `PropType` must be a struct '     ...
                       'defining prop construction as documented in '   ...
                       'props.HasProps']);
            end
            if ~isfield(val, 'Type')
                error('props:repeatedError',                            ...
                      'Prop property `PropType` must define `Type`');
            end
            if ~isa(val.Type, 'function_handle')
                error('props:repeatedError',                            ...
                      'Prop type must be prop constructor handles');
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
            argin = props.Prop.setPropDefaults(                         ...
                argin, 'Name', obj.Name, 'Doc', obj.Doc                 ...
            );
            propInstance = val.Type(argin{:});

            if ~isa(propInstance, 'props.Prop')
                error('props:repeatedError',                            ...
                      ['Types defined in `PropType` must be a '         ...
                       'subclass of props.Prop']);
            end
            obj.PropType = propInstance;
        end
        function val = DynamicDefault(obj)
            val = {};
        end

        function doc = dynamicDoc(obj, doctype)
            mc = metaclass(obj.PropType);
            doc = ['Type: ' mc.Name];
            if ~isempty(obj.PropType.dynamicDoc(doctype))
                doc = [doc ' (' obj.PropType.dynamicDoc(doctype) ')'];
            end
        end
    end
end
