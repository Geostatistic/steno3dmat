classdef PointBinder < props.HasProps
%POINTBINDER Bind data to nodes of a Steno3D Point
%   For usage details, see the %%%ref[binders help](steno3d.core.binders).
%
%   %%%properties
%
%   See the point %%%ref[EXAMPLES](steno3d.core.examples.point)
%
%   %%%seealso STENO3D.CORE.BINDERS, STENO3D.CORE.DATAARRAY,
%   STENO3D.CORE.POINT
%


    properties (Hidden, SetAccess = immutable)
        PBinderProps = {                                                ...
            struct(                                                     ...
                'Name', 'Location',                                     ...
                'Type', @props.String,                                  ...
                'Doc', 'Location of the data on mesh',                  ...
                'Choices', struct(                                      ...
                    'N', {{'VERTEX', 'VERTICES', 'NODE', 'NODES', 'CC', ...
                           'CELLCENTER', 'CELLCENTERS'}}                ...
                ),                                                      ...
                'DefaultValue', 'N',                                    ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Data',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Point data array',                              ...
                'Class', @steno3d.core.DataArray,                       ...
                'Required', true                                        ...
            )                                                           ...
        }
    end

    methods
        function obj = PointBinder(varargin)
            obj = obj@props.HasProps(varargin{:});
        end
    end
end

