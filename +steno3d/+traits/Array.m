classdef Array < steno3d.traits.Trait
%ARRAY Summary of this class goes here
%   Detailed explanation goes here

    properties (SetAccess = ?steno3d.traits.Trait)
        Shape = {'*'}
        Serial = false
        DataType = 'float'
    end

    methods
        function obj = Array(varargin)
            args = steno3d.traits.Trait.setTraitDefaults(varargin,      ...
                'DefaultValue', [],                                     ...
                'ValidateDefault', false,                               ...
                'TraitInfo', 'a numeric array or matrix');
            obj = obj@steno3d.traits.Trait(args{:});
        end

        function obj = set.Shape(obj, val)
            if ~iscell(val)
                error('steno3d:traitError',                             ...
                      'Array property `Shape` must be cell array')
            end
            for i = 1:length(val)
                v = val{i};
                if isnumeric(v) && length(v) == 1 && round(v) == v
                    continue
                elseif ischar(v) && v == '*'
                    continue
                else
                    error('steno3d:traitError',                         ...
                          ['Array property `shape` must be either '     ...
                           'integers corresponding to valid array '     ...
                           'dimension size or ''*'' if array dimension '...
                           'can be any length']);
                end
            end
            obj.Shape = val;
        end

        function obj = set.Serial(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('steno3d:traitError',                             ...
                      'Array property `Serial` must be true or false');
            end
            obj.Serial = val;
        end

        function obj = set.DataType(obj, val)
            if ~ischar(val) || ~ismember(val, {'float', 'int'})
                error('steno3d:traitError',                             ...
                      ['Array property `DataType` must be ''float'' or '...
                       '''int''']);
            end
            obj.DataType = val;
        end

        function val = validate(obj, val)
            if ~isnumeric(val)
                error('steno3d:traitError', '%s must be %s',            ...
                      obj.Name, obj.TraitInfo);
            end
            if strcmp(obj.DataType, 'int') && ~all(val == round(val))
                error('steno3d:traitError', '%s must be all integers',  ...
                      obj.Name);
            end
            shp = size(val);
            if length(shp) ~= length(obj.Shape)
                error('steno3d:traitError',                             ...
                      '%s must have %d dimensions', obj.Name,           ...
                      length(obj.Shape))
            end
            for i = 1:length(shp)
                if obj.Shape{i} == '*'
                    continue
                end
                if shp(i) ~= obj.Shape{i}
                    error('steno3d:traitError',                         ...
                          '%s dimension %d must be size %d', obj.Name,  ...
                          i, obj.Shape{i})
                end
            end
        end

        function fileInfo = serialize(obj)
            obj.validate(obj.Value);
            if obj.Serial
                tmpFile = [tempname '.dat'];
                fid = fopen(tmpFile, 'w');
                if strcmp(obj.DataType, 'int')
                    fwrite(fid, obj.Value, 'int32', 'l');
                    dtype = '<i4';
                else
                    fwrite(fid, obj.Value, 'float32', 'l');
                    dtype = '<f4';
                end
                fseek(fid, 0, -1);
                fileInfo = struct('FileID', fid, 'DType', dtype);
            else
                fileInfo = num2str(obj.Value);
            end

        end




    end

end
