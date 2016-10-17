classdef Mesh0DOptions < steno3d.core.opts.Options
%MESH0DOPTIONS Options for to Steno3D Mesh0D objects
%   For usage details, see the <a href="matlab: help steno3d.core.opts
%   ">options help</a>.
%
%   MESH0DOPTIONS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   ---- CLASS HAS NO PROPERTIES ----
%
%   See also steno3d.core.opts, steno3d.core.Mesh0D
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

