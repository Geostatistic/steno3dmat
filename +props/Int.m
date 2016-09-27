classdef Int < props.Float
%INT Summary of this class goes here
%   Detailed explanation goes here

    methods
        function obj = Int(varargin)
            args = props.Prop.setPropDefaults(varargin,      ...
                'PropInfo', 'a single integer',                        ...
                'IsInteger', true);
            obj = obj@props.Float(args{:});
        end
    end
end

