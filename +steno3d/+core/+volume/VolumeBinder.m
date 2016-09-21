classdef VolumeBinder < steno3d.traits.HasTraits
%VOLUMEBINDER Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        VBinderTraits = {                                               ...
            struct(                                                     ...
                'Name', 'Location',                                     ...
                'Type', @steno3d.traits.String,                         ...
                'Doc', 'Location of the data on mesh',                  ...
                'Choices', struct(                                      ...
                    'CC', {{'CELLCENTER'}}                              ...
                ),                                                      ...
                'DefaultValue', 'CC',                                   ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Data',                                         ...
                'Type', @steno3d.traits.Instance,                       ...
                'Doc', 'Volume data array',                             ...
                'Class', @steno3d.core.data.DataArray,                  ...
                'Required', true                                        ...
            )                                                           ...
        }
    end

    methods
    end

end

