classdef Vector < props.Array
%VECTOR Summary of this class goes here
%   Detailed explanation goes here

    methods
        function obj = Vector(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'Shape', {1, 3},                                        ...
                'DefaultValue', [0 0 0],                                ...
                'ValidateDefault', true,                                ...
                'PropInfo', 'a vector of length 3');
            obj = obj@props.Array(args{:});
        end

        function val = validate(obj, val)
            if ischar(val)
                if strcmpi(val, 'x')
                    val = [1 0 0];
                elseif strcmpi(val, 'y')
                    val = [0 1 0];
                elseif strcmpi(val, 'z')
                    val = [0 0 1];
                end
            end
            val = validate@props.Array(obj, val);
        end
    end

end
