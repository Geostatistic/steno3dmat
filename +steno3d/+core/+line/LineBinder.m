classdef LineBinder < steno3d.traits.HasTraits
%LINEBINDER Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        LBinderTraits = {                                               ...
            struct(                                                     ...
                'Name', 'Location',                                     ...
                'Type', @steno3d.traits.String,                         ...
                'Doc', 'Location of the data on mesh',                  ...
                'Choices', struct(                                      ...
                    'CC', {{'LINE', 'FACE', 'CELLCENTER', 'EDGE',       ...
                            'SEGMENT'}},                                ...
                    'N', {{'VERTEX', 'NODE', 'ENDPOINT'}}               ...
                ),                                                      ...
                'ValidateDefault', false,                               ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Data',                                         ...
                'Type', @steno3d.traits.Instance,                       ...
                'Doc', 'Line data array',                               ...
                'Class', @steno3d.core.data.DataArray,                  ...
                'Required', true                                        ...
            )                                                           ...
        }
    end

    methods
    end

end

