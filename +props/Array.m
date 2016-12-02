classdef Array < props.Prop
%ARRAY Multi-dimensional float or int array prop
%   This is a type of props.Prop that can be used when a props.HasProps
%   class needs a numeric array property.
%
%   PROPERTIES (in addition to those inherited from props.Prop)
%       Shape: A nested cell array describing the shape of the array where
%              the n-th entry must correspond to size(array, n). If an
%              entry is '*', that dimension can be any size. Note: The
%              requirement for nesting the cell array is necessary to
%              subvert MATLAB's default treatment of cell arrays contained
%              in structs.
%              Example:
%                   If Shape = {{1, 3, '*'}}, valid array sizes include
%                   [1, 3, 1], [1, 3, 100], etc. Invalid array sizes
%                   include [1, 3], [1, 3, 100, 1], [3, 1, 100].
%       
%       Binary: If true, array is written to binary when serialized to a
%               file. If false, array is written as a string when
%               serialized.
%
%       DataType: 'float' or 'int'
%
%       IndexArray: If true, the array is saved as as (array - 1) for
%                   compatibility with zero-indexed languages. If false,
%                   the array is saved as-is.
%
%   Example:
%       ...
%       class HasArrayProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               ArrayPropStruct = {                                     ...
%                   struct(                                             ...
%                       'Name', 'ThreeColumns',                         ...
%                       'Type', @props.Array,                           ...
%                       'Doc', 'Three column array, saved as binary',   ...
%                       'Shape', {{'*', 3}},                            ...
%                       'Binary', true,                                 ...
%                       'DataType', 'float'                             ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   See also props.Prop, props.HasProps, props.Float, props.Int,
%   props.Repeated, props.Image
%


    properties (SetAccess = ?props.Prop)
        Shape = {{'*', '*'}}
        Binary = false
        DataType = 'float'
        IndexArray = false
    end

    methods
        function obj = Array(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'DefaultValue', [],                                     ...
                'ValidateDefault', false);
            obj = obj@props.Prop(args{:});
        end

        function obj = set.Shape(obj, val)
            if ~iscell(val)
                error('props:arrayError',                               ...
                      'Array property `Shape` must be cell array')
            end
            for i = 1:length(val)
                v = val{i};
                if isnumeric(v) && length(v) == 1 && round(v) == v
                    continue
                elseif ischar(v) && v == '*'
                    continue
                else
                    error('props:arrayError',                           ...
                          ['Array property `shape` must be either '     ...
                           'integers corresponding to valid array '     ...
                           'dimension size or ''*'' if array dimension '...
                           'can be any length']);
                end
            end
            obj.Shape = val;
        end

        function obj = set.Binary(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('props:arrayError',                               ...
                      'Array property `Binary` must be true or false');
            end
            obj.Binary = val;
        end
        
        function obj = set.IndexArray(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('props:arrayError',                               ...
                      'Array property `IndexArray` must be true or false');
            end
            obj.IndexArray = val;
        end

        function obj = set.DataType(obj, val)
            if ~ischar(val) || ~ismember(val, {'float', 'int'})
                error('props:arrayError',                               ...
                      ['Array property `DataType` must be ''float'' or '...
                       '''int''']);
            end
            obj.DataType = val;
        end

        function val = validate(obj, val)
            if ~isnumeric(val)
                error('props:arrayError', '%s must be numeric',          ...
                      obj.Name);
            end
            if strcmp(obj.DataType, 'int') && ~all(val(:) == round(val(:)))
                error('props:arrayError', '%s must be all integers',    ...
                      obj.Name);
            end
            shp = size(val);
            if length(shp) ~= length(obj.Shape)
                error('props:arrayError',                               ...
                      '%s must have %d dimensions', obj.Name,           ...
                      length(obj.Shape))
            end
            for i = 1:length(shp)
                if obj.Shape{i} == '*'
                    continue
                end
                if shp(i) ~= obj.Shape{i}
                    error('props:arrayError',                           ...
                          '%s dimension %d must be size %d', obj.Name,  ...
                          i, obj.Shape{i})
                end
            end
        end

        function output = serialize(obj)
            obj.validate(obj.Value);
            if length(obj.Shape) > 2
                error('props:arrayError',                               ...
                      'Cannot serialize arrays > 2 dimensions');
            end
            val = obj.Value';
            val = val(:)';
            if obj.IndexArray
                val = val-1;
            end
            if obj.Binary
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
        
        function n = nbytes(obj)
            n = length(obj.Value(:))*8;
        end
        
        function doc = dynamicDoc(obj)
            doc = '{';
            for i = 1:length(obj.Shape)
                if i > 1
                    doc = [doc ', '];
                end
                if isnumeric(obj.Shape{i})
                    doc = [doc num2str(obj.Shape{i})];
                else
                    doc = [doc obj.Shape{1}];
                end
            end
                        
            doc = ['Shape: ' doc '}, DataType: ' obj.DataType];
        end
    end
end
