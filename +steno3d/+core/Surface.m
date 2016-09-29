classdef Surface < steno3d.core.CompositeResource
%SURFACE Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        SurfaceProps = {                                                ...
            struct(                                                     ...
                'Name', 'Mesh',                                         ...
                'Type', @props.Union,                                   ...
                'Doc', 'Surface mesh',                                  ...
                'PropTypes', {{struct(                                  ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.Mesh2D                       ...
                ), struct(                                              ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.Mesh2DGrid                   ...
                )}},                                                    ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Data',                                         ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Surface data',                                  ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.binders.SurfaceBinder,       ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Textures',                                     ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Surface textures',                              ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.Texture2DImage,              ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Surface Options',                               ...
                'Class', @steno3d.core.opts.SurfaceOptions,             ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Surface(varargin)
            obj = obj@steno3d.core.CompositeResource(varargin{:});
        end
    end

end
