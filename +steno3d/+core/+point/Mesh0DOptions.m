classdef Mesh0DOptions < steno3d.core.Options
%MESH0DOPTIONS Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        M0DOptTraits = {                                                ...
        }
    end

    methods
        function obj = Mesh0DOptions(varargin)
            obj = obj@steno3d.core.Options(varargin{:});
        end
    end

end

