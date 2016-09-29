classdef Repeated < props.Prop
%REPEATED Summary of this class goes here
%   Detailed explanation goes here

    properties (Access = ?props.Prop)
        PropType
    end

    methods
        function obj = Repeated(varargin)
            args = props.Prop.setPropDefaults(varargin,      ...
                'PropInfo', 'muliple values of a certain type of prop');
            obj = obj@props.Prop(args{:});
            if isempty(obj.PropType)
                error('steno3d:propError',                             ...
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
                error('steno3d:propError',                             ...
                      ['Prop property `PropType` must be a struct '   ...
                       'defining prop construction as documented in '  ...
                       'props.HasProps']);
            end
            if ~isfield(val, 'Type')
                error('steno3d:propError',                             ...
                      'Prop property `PropType` must define `Type`');
            end
            if ~isa(val.Type, 'function_handle')
                error('steno3d:hasPropsError',                         ...
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
            argin = props.Prop.setPropDefaults(              ...
                argin, 'Name', obj.Name                                 ...
            );
            propInstance = val.Type(argin{:});

            if ~isa(propInstance, 'props.Prop')
                error('steno3d:hasPropsError',                         ...
                      ['Types defined in `PropType` must be a '        ...
                       'subclass of props.Prop']);
            end
            obj.PropType = propInstance;
        end

        function val = DynamicDefault(obj)
            val = obj.PropType.DynamicDefault;
        end
    end
end
