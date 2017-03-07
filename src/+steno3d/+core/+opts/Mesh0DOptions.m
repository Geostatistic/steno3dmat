classdef Mesh0DOptions < steno3d.core.opts.Options
%MESH0DOPTIONS Options for Steno3D Mesh0D objects
%   For usage details, see the %%%ref[options help](steno3d.core.opts).
%
%   %%%properties
%
%   See the point %%%ref[EXAMPLES](steno3d.core.examples.point)
%
%   %%%seealso STENO3D.CORE.OPTS, STENO3D.CORE.MESH0D
%


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


