classdef Mesh1DOptions < steno3d.core.opts.Options
%MESH1DOPTIONS Options for Steno3D Mesh1D objects
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   MESH1DOPTIONS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   OPTIONAL PROPERTIES:
%       ViewType (<a href="matlab: help props.String">props.String</a>)
%           Display 1D lines or tubes/boreholes/extruded lines
%           Choices: line, tube
%           Default: 'line'
%
%
%   See the line <a href="matlab: help steno3d.core.examples.line
%   ">EXAMPLES</a>
%
%   See also STENO3D.CORE.OPTS, STENO3D.CORE.MESH1D
%


    properties (Hidden, SetAccess = immutable)
        M1DOptProps = {                                                 ...
            struct(                                                     ...
                'Name', 'ViewType',                                    ...
                'Type', @props.String,                                  ...
                'Doc', ['Display 1D lines or tubes/boreholes/extruded ' ...
                        'lines'],                                       ...
                'Choices', struct(                                      ...
                    'line', {{'lines', '1d'}},                          ...
                    'tube', {{'tubes', 'extruded line',                 ...
                              'extruded lines', 'borehole',             ...
                              'boreholes'}}                             ...
                ),                                                      ...
                'DefaultValue', 'line',                                 ...
                'Lowercase', true,                                      ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Mesh1DOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
        
        function json = toJSON(obj)
        %TOJSON Serialize options to JSON string
            json = '';
            for i = 1:length(obj.PR__props)
                optname = obj.PR__props{i};
                option = obj.(['PR_' optname]);
                if strcmp(optname, 'ViewType')
                    optname = 'View_Type';
                end
                json = [json '"' lower(optname) '": '                   ...
                       option.serialize() ', '];
            end
            json = ['{' json(1:end-2) '}'];
        end
    end
end


