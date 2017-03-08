classdef String < props.Prop
%STRING String prop
%   This is a type of %%%ref[props.Prop](props.Prop) that can be used when a %%%ref[props.HasProps](props.HasProps)
%   class needs a string property. PROPS.STRING can either accept any
%   string or only certain spcecified strings.
%
%   %%%bold[Attributes] (in addition to those inherited from %%%ref[props.Prop](props.Prop)):
%
%   Choices:
%       The available choices for the string property. If choices
%       is not specified, any string will be considered valid. If
%       choices is a nested cell array of strings, only those
%       choices are valid. Choices may also be a struct with
%       strings as fields and nested cell array of strings as
%       values. This allows several different strings (the values)
%       to be coerced into a single string (the field). Note: The
%       requirement for nesting the cell array is necessary to
%       subvert MATLAB's default treatment of cell arrays
%       contained in structs. See example below for the
%       implementation of each of these types of Choices.
%
%   Lowercase:
%       If true, the input string is coerced to all-lowercase.
%       If false and Choices are set, the string is coerced to
%       the case found in Choices. If false and Choices is not
%       set, the string is kept as-is.
%
%   Example:
%   %%%codeblock
%       ...
%       class HasStringProps < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               StringPropsStruct = {                                   ...
%                   struct(                                             ...
%                       'Name', 'AnyString',                            ...
%                       'Type', @props.String,                          ...
%                       'Doc', 'This property can be any string'        ...
%                   ), struct(                                          ...
%                       'Name', 'ChoiceString',                         ...
%                       'Type', @props.String,                          ...
%                       'Doc', 'This property can only be hi or bye',   ...
%                       'Choices', {{'hi', 'bye'}},                     ...
%                       'DefaultValue', 'hi'                            ...
%                   ), struct(                                          ...
%                       'Name', 'CoercedChoiceString',                  ...
%                       'Type', @props.String,                          ...
%                       'Doc', 'This coerces hi and bye to English',    ...
%                       'Choices', struct(                              ...
%                           'hi', {{'hola', 'bonjour', 'guten tag'}},   ...
%                           'bye', {{'adios', 'au revoir',              ...
%                                    'auf Wiedersehen'}}                ...
%                       ),                                              ...
%                       'DefaultValue', 'hi'                            ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   %%%seealso props.Prop, props.HasProps, props.Color, props.Bool
%


    properties (SetAccess = ?props.Prop)
        Choices = struct()
        Lowercase = false
    end

    methods
        function obj = String(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'DefaultValue', '');
            obj = obj@props.Prop(args{:});
        end

        function val = validate(obj, val)
            if ~ischar(val)
                error('props:stringError', '%s must be a string',       ...
                      obj.Name);
            end
            fields = fieldnames(obj.Choices);
            if isempty(fields)
                if obj.Lowercase
                    val = lower(val);
                end
                return
            end
            for i = 1:length(fields)
                if any(strcmpi(val, obj.Choices.(fields{i})))
                    if obj.Lowercase
                        val = lower(fields{i});
                    else
                        val = fields{i};
                    end
                    return
                end
            end
            if obj.Lowercase
                choicestr = strjoin(lower(fields), ''', ''');
            else
                choicestr = strjoin(fields, ''', ''');
            end
            error('props:stringError', '%s must be one of: ''%s''',     ...
                  obj.Name, choicestr);
        end

        function obj = set.Choices(obj, val)
            if iscellstr(val)
                strval = struct();
                for i = 1:length(val)
                    strval.(val{i}) = {};
                end
                val = strval;
            end
            if ~isstruct(val)
                error('props:stringError',                              ...
                      ['Choices must be cell array of strings or a '    ...
                       'struct of with fields as choices and values as '...
                       'alternatives to the field']);
            end
            fields = fieldnames(val);
            for i = 1:length(fields)
                if ~iscellstr(val.(fields{i}))
                    error('props:stringError',                          ...
                          ['Choices struct values must be cell arrays ' ...
                           'of strings. When constructing choices you ' ...
                           'must specify the values as a cell array '   ...
                           'nested inside another size 1 cell array']);
                end
                if ~ismember(fields{i}, val.(fields{i}))
                    val.(fields{i}){end+1} = fields{i};
                end
            end
            obj.Choices = val;
        end

        function output = serialize(obj)
            output = ['"' obj.Value '"'];
        end

        function doc = dynamicDoc(obj, doctype)
            if isempty(fields(obj.Choices))
                doc = '';
            else
                doc = ['Choices: ' strjoin(fields(obj.Choices), ', ')];
            end
        end
    end
end

