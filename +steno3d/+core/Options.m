classdef Options < steno3d.traits.HasTraits
%OPTIONS Summary of this class goes here
%   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = Options(varargin)
            obj = obj@steno3d.traits.HasTraits(varargin{:});
        end
        
        function json = toJSON(obj)
            json = '';
            for i = 1:length(obj.TR__traits)
                optname = obj.TR__traits{i};
                option = obj.(['TR_' optname]);
                json = [json '"' lower(optname) '": '                   ...
                       option.serialize() ', '];
            end
            json = ['{' json(1:end-2) '}'];
        end
    end
    
end

