classdef Options < props.HasProps
%OPTIONS Summary of this class goes here
%   Detailed explanation goes here

    properties
    end

    methods
        function obj = Options(varargin)
            obj = obj@props.HasProps(varargin{:});
        end

        function json = toJSON(obj)
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

