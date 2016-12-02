classdef Mesh0DOptions < steno3d.core.opts.Options
%MESH0DOPTIONS Options for Steno3D Mesh0D objects
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   MESH0DOPTIONS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   ---- CLASS HAS NO PROPERTIES ----
%
%
%   See the point <a href="matlab: help steno3d.core.examples.point
%   ">EXAMPLES</a>
%
%   See also STENO3D.CORE.OPTS, STENO3D.CORE.MESH0D
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


