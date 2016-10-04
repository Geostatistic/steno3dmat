classdef Volume < steno3d.core.CompositeResource
%VOLUME Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        VolumeProps = {                                                 ...
            struct(                                                     ...
                'Name', 'Mesh',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Volume mesh',                                   ...
                'Class', @steno3d.core.Mesh3DGrid,                      ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Data',                                         ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Volume data',                                   ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.binders.VolumeBinder,        ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Volume Options',                                ...
                'Class', @steno3d.core.opts.VolumeOptions,              ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods

        function obj = Volume(varargin)
            obj = obj@steno3d.core.CompositeResource(varargin{:});
        end
    end

end

