classdef String < steno3d.traits.Trait
%STRING Summary of this class goes here
%   Detailed explanation goes here

    properties (Access = ?steno3d.traits.Trait)
        Choices = struct()
        Lowercase = false
    end

    methods
        function obj = String(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,      ...
                'DefaultValue', '',                                     ...
                'TraitInfo', 'a string');
            obj = obj@steno3d.traits.Trait(args{:});
        end

        function val = validate(obj, val)
            if ~ischar(val)
                error('steno3d:traitError', '%s must be %s',            ...
                      obj.Name, obj.TraitInfo)
            end
            fields = fieldnames(obj.Choices);
            if isempty(fields)
                if obj.Lowercase
                    val = lower(val);
                else
                    val = upper(val);
                end
                return
            end
            for i = 1:length(fields)
                if any(strcmpi(val, obj.Choices.(fields{i})))
                    if obj.Lowercase
                        val = lower(fields{i});
                    else
                        val = upper(fields{i});
                    end
                    return
                end
            end
            if obj.Lowercase
                choicestr = strjoin(lower(fields), ''', ''');
            else
                choicestr = strjoin(upper(fields), ''', ''');
            end
            error('steno3d:traitError', '%s must be one of: ''%s''',...
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
                error('steno3d:traitError',                             ...
                      ['Choices must be cell array of strings or a '    ...
                       'struct of with fields as choices and values as '...
                       'alternatives to the field']);
            end
            fields = fieldnames(val);
            for i = 1:length(fields)
                if ~iscellstr(val.(fields{i}))
                    error('steno3d:traitError',                         ...
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

    end
end

