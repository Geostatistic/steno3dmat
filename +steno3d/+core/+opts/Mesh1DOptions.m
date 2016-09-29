classdef Mesh1DOptions < steno3d.core.opts.Options
%MESH1DOPTIONS Summary of this class goes here
%   Detailed explanation goes here

    properties (Hidden, SetAccess = immutable)
        M1DOptProps = {                                                 ...
            struct(                                                     ...
                'Name', 'ViewType',                                     ...
                'Type', @props.String,                                  ...
                'Doc', ['Display 1D lines or tubes/boreholes/extruded ' ...
                        'lines'],                                       ...
                'Choices', struct(                                      ...
                    'line', {{'lines', 'tube', '1d'}},                  ...
                    'tube', {{'tubes', 'extruded line',                 ...
                              'extruded lines', 'borehole',             ...
                              'boreholes'}}                             ...
                ),                                                      ...
                'DefaultValue', 'line',                                 ...
                'Lowercase', true,                                      ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Mesh1DOptions(varargin)
            obj = obj@steno3d.core.opts.Options(varargin{:});
        end
    end

end

