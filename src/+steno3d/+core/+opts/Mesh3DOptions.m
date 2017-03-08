classdef Mesh3DOptions < steno3d.core.opts.Options
%MESH3DOPTIONS Options for Steno3D Mesh3DGrid objects
%   For usage details, see the %%%ref[options help](steno3d.core.opts).
%
%   %%%properties
%
%   See the volume %%%ref[EXAMPLES](steno3d.examples.core.volume)
%
%   %%%seealso steno3d.core.opts, steno3d.core.Mesh3DGrid
%


    properties (Hidden, SetAccess = immutable)
        M3DOptProps = {                                                 ...
            struct(                                                     ...
                'Name', 'Wireframe',                                    ...
                'Type', @props.Bool,                                    ...
                'Doc', 'Display 3D mesh wireframe',                     ...
                'DefaultValue', false,                                  ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Mesh3DOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
    end
end


