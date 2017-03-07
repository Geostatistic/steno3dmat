classdef Point < steno3d.core.CompositeResource
%POINT Low-level Steno3D Point resource
%   Points are 0D resources. Their geometry is defined by a %%%ref[Mesh0D](steno3d.core.Mesh0D) with
%   Vertices. They may have %%%ref[Data](steno3d.core.DataArray) defined on the vertices (nodes). There are
%   several %%%ref[point options](steno3d.core.opts.PointOptions) available for customizing the appearance.
%
%   `Point` resources can also be created through a high-level functional
%   interface with %%%func[steno3d.scatter](steno3d.scatter).
%
%   %%%properties
%
%   See the %%%ref[EXAMPLES](steno3d.examples.core.point)
%
%   %%%seealso STENO3D.SCATTER, STENO3D.CORE.MESH0D, STENO3D.CORE.BINDERS,
%   STENO3D.CORE.OPTS.POINTOPTIONS, STENO3D.CORE.COMPOSITERESOURCE,
%   STENO3D.CORE.PROJECT
%


    properties (Hidden, SetAccess = immutable)
        PointProps = {                                                  ...
            struct(                                                     ...
                'Name', 'Mesh',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Structure of the point resource',               ...
                'Class', @steno3d.core.Mesh0D,                          ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Data',                                         ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Data defined on the point resource',            ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.binders.PointBinder,         ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Textures',                                     ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Images mapped to the point resource',           ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.Texture2DImage,              ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Options for the point resource',                ...
                'Class', @steno3d.core.opts.PointOptions,               ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Point(varargin)
            obj = obj@steno3d.core.CompositeResource(varargin{:});
        end
    end

    methods (Hidden)
        function plot(obj, ax)
            if ~isempty(obj.Data)
                scatter3(ax, obj.Mesh.Vertices(:, 1),                   ...
                         obj.Mesh.Vertices(:, 2),                       ...
                         obj.Mesh.Vertices(:, 3), [],                   ...
                         obj.Data{1}.Data.Array(:), 'filled');
            else
                scatter3(ax, obj.Mesh.Vertices(:, 1),                   ...
                         obj.Mesh.Vertices(:, 2),                       ...
                         obj.Mesh.Vertices(:, 3), [],                   ...
                         obj.Opts.Color/255, 'filled');
            end
        end
    end
end

