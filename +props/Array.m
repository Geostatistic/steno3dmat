classdef Array < props.Prop
%ARRAY Summary of this class goes here
%   Detailed explanation goes here

    properties (SetAccess = ?props.Prop)
        Shape = {'*'}
        Serial = false
        DataType = 'float'
    end

    methods
        function obj = Array(varargin)
            args = props.Prop.setPropDefaults(varargin,      ...
                'DefaultValue', [],                                     ...
                'ValidateDefault', false,                               ...
                'PropInfo', 'a numeric array or matrix');
            obj = obj@props.Prop(args{:});
        end

        function obj = set.Shape(obj, val)
            if ~iscell(val)
                error('steno3d:propError',                             ...
                      'Array property `Shape` must be cell array')
            end
            for i = 1:length(val)
                v = val{i};
                if isnumeric(v) && length(v) == 1 && round(v) == v
                    continue
                elseif ischar(v) && v == '*'
                    continue
                else
                    error('steno3d:propError',                         ...
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
                error('steno3d:propError',                             ...
                      'Array property `Serial` must be true or false');
            end
            obj.Serial = val;
        end

        function obj = set.DataType(obj, val)
            if ~ischar(val) || ~ismember(val, {'float', 'int'})
                error('steno3d:propError',                             ...
                      ['Array property `DataType` must be ''float'' or '...
                       '''int''']);
            end
            obj.DataType = val;
        end

        function val = validate(obj, val)
            if ~isnumeric(val)
                error('steno3d:propError', '%s must be %s',            ...
                      obj.Name, obj.PropInfo);
            end
            if strcmp(obj.DataType, 'int') && ~all(val == round(val))
                error('steno3d:propError', '%s must be all integers',  ...
                      obj.Name);
            end
            shp = size(val);
            if length(shp) ~= length(obj.Shape)
                error('steno3d:propError',                             ...
                      '%s must have %d dimensions', obj.Name,           ...
                      length(obj.Shape))
            end
            for i = 1:length(shp)
                if obj.Shape{i} == '*'
                    continue
                end
                if shp(i) ~= obj.Shape{i}
                    error('steno3d:propError',                         ...
                          '%s dimension %d must be size %d', obj.Name,  ...
                          i, obj.Shape{i})
                end
            end
        end

        function output = serialize(obj)
            obj.validate(obj.Value);
            if length(obj.Shape) > 2
                error('steno3d:propError',                             ...
                      'Cannot serialize arrays > 2 dimensions');
            end
            val = obj.Value';
            val = val(:);
            if obj.Serial
                tmpFile = [tempname '.dat'];
                fid = fopen(tmpFile, 'w+', 'l');
                if strcmp(obj.DataType, 'int')
                    fwrite(fid, val, 'int32', 'l');
                    dtype = '<i4';
                else
                    fwrite(fid, val, 'float32', 'l');
                    dtype = '<f4';
                end
                fseek(fid, 0, -1);
                d = fread(fid, Inf, '*uint8');
                fclose(fid);

                output = struct('FileID', d, 'DType', dtype);
            else
                csvlist = num2str(val, '%g, ');
                output = ['[' csvlist(1:end-1) ']'];
            end
        end
    end
end
