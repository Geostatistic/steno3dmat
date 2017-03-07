classdef Color < props.Prop
%COLOR RGB, Hex, or string color prop
%   This is a type of %%%ref[props.Prop](props.Prop) that can be used when a %%%ref[props.HasProps](props.HasProps)
%   class needs a color property. Examples of valid colors include:
%       - 8-bit RGB colors with values betweeon 0-255 (e.g. [0 128 255])
%       - MATLAB RGB colors with values between 0-1 (e.g. [0 .5 .5])
%       - Hex string colors with 6 digits (e.g. '#0080FF')
%       - Hex string colors with 3 digits (e.g. '#F50')
%       - MATLAB color letters (e.g. 'y')
%       - Predefined named colors (e.g. 'papayawhip')
%       - Random color ('random')
%   All of these are converted to and stored as their equivalent 8-bit RGB
%   color.
%
%   PROPERTIES - No properties besides those inherited from %%%ref[props.Prop](props.Prop)
%
%   Example:
%   %%%codeblock
%       ...
%       class HasColorProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               ColorPropStruct = {                                     ...
%                   struct(                                             ...
%                       'Name', 'FaceColor',                            ...
%                       'Type', @props.Color,                           ...
%                       'Doc', 'Color of the object',                   ...
%                       'DefaultValue', 'random'                        ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   %%%seealso props.Prop, props.HasProps, props.Vector, props.Instance
%

    properties (Constant, Hidden)
        PROP_INFO = ['RGB with values 0-1 or 0-255, hex color (e.g. '   ...
                     '''#FF0000''), string color name, or ''random''']
    end
    methods
        function obj = Color(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'DefaultValue', 'random');
            obj = obj@props.Prop(args{:});
        end

        function val = validate(obj, val)
            if ischar(val)
                if isfield(obj.COLORS_NAMED, lower(val))
                    val = obj.COLORS_NAMED.(val);
                end
                if strcmpi(val, 'RANDOM')
                    val = obj.COLORS_20{randi(20)};
                end
                if val(1) == '#'
                    val = val(2:end);
                end
                if length(val) == 3
                    val = val([1, 1, 2, 2, 3, 3]);
                end
                if length(val) ~= 6
                    error('props:colorError', '%s must be %s',          ...
                          obj.Name, obj.PROP_INFO);
                end
                try
                    val = [hex2dec(val(1:2)),                           ...
                           hex2dec(val(3:4)),                           ...
                           hex2dec(val(5:6))];
                catch
                    error('props:colorError', '%s must be %s',          ...
                          obj.Name, obj.PROP_INFO);
                end
            end
            if ~isnumeric(val) || length(val(:)) ~= 3
                error('props:colorError', '%s must be %s',              ...
                      obj.Name, obj.PROP_INFO);
            end
            if all(val >= 0 & val <= 1)
                val = val*255;
            end
            val = round(val);
            if any(val < 0 | val > 255)
                error('props:colorError', '%s must be %s',              ...
                      obj.Name, obj.PROP_INFO);
            end
        end

        function output = serialize(obj)
            csvlist = num2str(obj.Value, '%u, ');
            output = ['[' csvlist(1:end-1) ']'];
        end
    end

    methods (Static)

        function valid = isValid(val)
            obj = props.Color('Name', 'Color');
            try
                obj.validate(val);
                valid = true;
            catch
                valid = false;
            end
        end
    end

    properties (Constant, Access = private)

COLORS_20 = {                                                           ...
    '#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c',              ...
    '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5',              ...
    '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f',              ...
    '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5'               ...
}

COLORS_NAMED = struct(                                                  ...
    'aliceblue', 'F0F8FF', 'antiquewhite', 'FAEBD7', 'aqua', '00FFFF',  ...
    'aquamarine', '7FFFD4', 'azure', 'F0FFFF', 'beige', 'F5F5DC',       ...
    'bisque', 'FFE4C4', 'black', '000000', 'blanchedalmond', 'FFEBCD',  ...
    'blue', '0000FF', 'blueviolet', '8A2BE2', 'brown', 'A52A2A',        ...
    'burlywood', 'DEB887', 'cadetblue', '5F9EA0',                       ...
    'chartreuse', '7FFF00', 'chocolate', 'D2691E', 'coral', 'FF7F50',   ...
    'cornflowerblue', '6495ED', 'cornsilk', 'FFF8DC',                   ...
    'crimson', 'DC143C', 'cyan', '00FFFF', 'darkblue', '00008B',        ...
    'darkcyan', '008B8B', 'darkgoldenrod', 'B8860B',                    ...
    'darkgray', 'A9A9A9', 'darkgrey', 'A9A9A9', 'darkgreen', '006400',  ...
    'darkkhaki', 'BDB76B', 'darkmagenta', '8B008B',                     ...
    'darkolivegreen', '556B2F', 'darkorange', 'FF8C00',                 ...
    'darkorchid', '9932CC', 'darkred', '8B0000','darksalmon', 'E9967A', ...
    'darkseagreen', '8FBC8F', 'darkslateblue', '483D8B',                ...
    'darkslategray', '2F4F4F', 'darkslategrey', '2F4F4F',               ...
    'darkturquoise', '00CED1', 'darkviolet', '9400D3',                  ...
    'deeppink', 'FF1493', 'deepskyblue', '00BFFF', 'dimgray', '696969', ...
    'dimgrey', '696969', 'dodgerblue', '1E90FF', 'irebrick', 'B22222',  ...
    'floralwhite', 'FFFAF0', 'forestgreen', '228B22',                   ...
    'fuchsia', 'FF00FF', 'gainsboro', 'DCDCDC', 'ghostwhite', 'F8F8FF', ...
    'gold', 'FFD700', 'goldenrod', 'DAA520', 'gray', '808080',          ...
    'grey', '808080', 'green', '008000', 'greenyellow', 'ADFF2F',       ...
    'honeydew', 'F0FFF0', 'hotpink', 'FF69B4', 'indianred', 'CD5C5C',   ...
    'indigo', '4B0082', 'ivory', 'FFFFF0', 'khaki', 'F0E68C',           ...
    'lavender', 'E6E6FA', 'lavenderblush', 'FFF0F5',                    ...
    'lawngreen', '7CFC00', 'lemonchiffon', 'FFFACD',                    ...
    'lightblue', 'ADD8E6', 'lightcoral', 'F08080',                      ...
    'lightcyan', 'E0FFFF', 'lightgoldenrodyellow', 'FAFAD2',            ...
    'lightgray', 'D3D3D3', 'lightgrey', 'D3D3D3',                       ...
    'lightgreen', '90EE90', 'lightpink', 'FFB6C1',                      ...
    'lightsalmon', 'FFA07A', 'lightseagreen', '20B2AA',                 ...
    'lightskyblue', '87CEFA', 'lightslategray', '778899',               ...
    'lightslategrey', '778899', 'lightsteelblue', 'B0C4DE',             ...
    'lightyellow', 'FFFFE0', 'lime', '00FF00', 'limegreen', '32CD32',   ...
    'linen', 'FAF0E6', 'magenta', 'FF00FF', 'maroon', '800000',         ...
    'mediumaquamarine', '66CDAA', 'mediumblue', '0000CD',               ...
    'mediumorchid', 'BA55D3', 'mediumpurple', '9370DB',                 ...
    'mediumseagreen', '3CB371', 'mediumslateblue', '7B68EE',            ...
    'mediumspringgreen', '00FA9A', 'mediumturquoise', '48D1CC',         ...
    'mediumvioletred', 'C71585', 'midnightblue', '191970',              ...
    'mintcream', 'F5FFFA', 'mistyrose', 'FFE4E1', 'moccasin', 'FFE4B5', ...
    'navajowhite', 'FFDEAD', 'navy', '000080', 'oldlace', 'FDF5E6',     ...
    'olive', '808000', 'olivedrab', '6B8E23', 'orange', 'FFA500',       ...
    'orangered', 'FF4500', 'orchid', 'DA70D6',                          ...
    'palegoldenrod', 'EEE8AA', 'palegreen', '98FB98',                   ...
    'paleturquoise', 'AFEEEE', 'palevioletred', 'DB7093',               ...
    'papayawhip', 'FFEFD5', 'peachpuff', 'FFDAB9', 'peru', 'CD853F',    ...
    'pink', 'FFC0CB', 'plum', 'DDA0DD', 'powderblue', 'B0E0E6',         ...
    'purple', '800080', 'rebeccapurple', '663399', 'red', 'FF0000',     ...
    'rosybrown', 'BC8F8F', 'royalblue', '4169E1',                       ...
    'saddlebrown', '8B4513', 'salmon', 'FA8072', 'sandybrown', 'F4A460',...
    'seagreen', '2E8B57', 'seashell', 'FFF5EE', 'sienna', 'A0522D',     ...
    'silver', 'C0C0C0', 'skyblue', '87CEEB', 'slateblue', '6A5ACD',     ...
    'slategray', '708090', 'slategrey', '708090', 'snow', 'FFFAFA',     ...
    'springgreen', '00FF7F', 'steelblue', '4682B4', 'tan', 'D2B48C',    ...
    'teal', '008080', 'thistle', 'D8BFD8', 'tomato', 'FF6347',          ...
    'turquoise', '40E0D0', 'violet', 'EE82EE', 'wheat', 'F5DEB3',       ...
    'white', 'FFFFFF', 'whitesmoke', 'F5F5F5', 'yellow', 'FFFF00',      ...
    'yellowgreen', '9ACD32', 'k', '000000', 'b', '0000FF',              ...
    'c', '00FFFF', 'g', '00FF00', 'm', 'FF00FF', 'r', 'FF0000',         ...
    'w', 'FFFFFF', 'y', 'FFFF00'                                        ...
)

    end
end
