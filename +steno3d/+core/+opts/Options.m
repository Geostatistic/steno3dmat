classdef (Abstract) Options < props.HasProps
%OPTIONS Base class for Steno3D options
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   See also steno3d.core.opts
%

    properties
    end

    methods
        function obj = Options(varargin)
            obj = obj@props.HasProps(varargin{:});
        end

        function json = toJSON(obj)
        %TOJSON Serialize options to JSON string
            json = '';
            for i = 1:length(obj.PR__props)
                optname = obj.PR__props{i};
                option = obj.(['PR_' optname]);
                json = [json '"' lower(optname) '": '                   ...
                       option.serialize() ', '];
            end
            json = ['{' json(1:end-2) '}'];
        end
    end
end

