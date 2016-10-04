classdef Int < props.Float
%INT Integer property

    methods
        function obj = Int(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'PropInfo', 'a single integer',                         ...
                'IsInteger', true);
            obj = obj@props.Float(args{:});
        end
    end
end

