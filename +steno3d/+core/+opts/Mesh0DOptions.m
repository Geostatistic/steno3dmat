classdef Mesh0DOptions < steno3d.core.opts.Options
%MESH0DOPTIONS Options applicable to steno3d Mesh0D

    properties (Hidden, SetAccess = immutable)
        M0DOptProps = {                                                 ...
        }
    end

    methods
        function obj = Mesh0DOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
    end

end

