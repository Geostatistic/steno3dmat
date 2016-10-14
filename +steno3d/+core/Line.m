classdef Line < steno3d.core.CompositeResource
%LINE Low-level Steno3D Line resource
%   Lines are 1D resources. Their geometry is defined by a <a href="
%   matlab: help steno3d.core.Mesh1D">Mesh1D</a> as
%   Vertices and connecting Segments. They may have <a href="
%   matlab: help steno3d.core.DataArray">Data</a> that is either
%   defined on the vertices (nodes) or the segments (cell-centers). There
%   are several <a href="matlab: help steno3d.core.opts.LineOptions
%   ">line options</a> and <a href="matlab:
%   help steno3d.core.opts.Mesh0DOptions
%   ">mesh options</a> available for customizing the
%   appearance.
%
%   LINE resources can also be created through a high-level functional
%   interface with <a href="matlab: help steno3d.line">steno3d.line</a>.
%
%   For a demonstration of LINE, see the <a href="
%   matlab: help steno3d.examples.line">EXAMPLES</a>.
%
%   LINE implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="
%   matlab: help props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       Mesh (<a href="matlab: help props.Instance">props.Instance</a>)
%           Structure of the line resource
%           Class: <a href="matlab: help steno3d.core.Mesh1D
%           ">Mesh1D</a>
%
%   OPTIONAL PROPERTIES:
%       Data (<a href="matlab: help props.Repeated">props.Repeated</a>)
%           Data defined on the line resource
%           Type: props.Instance (Class: <a href="matlab:
%           help steno3d.core.binders
%           ">LineBinder</a>)
%
%       Opts (<a href="matlab: help props.Instance">props.Instance</a>)
%           Options for the line resource
%           Class: <a href="matlab: help steno3d.core.opts.LineOptions
%           ">LineOptions</a>
%
%       Title (<a href="matlab: help props.String">props.String</a>)
%           Content title
%
%       Description (<a href="matlab: help props.String">props.String</a>)
%           Content description
%
%   See also steno3d.examples.line, steno3d.line, steno3d.core.Mesh1D,
%   steno3d.core.opts.LineOptions, steno3d.core.opts.Mesh1DOptions,
%   steno3d.core.binders, steno3d.core.CompositeResource,
%   steno3d.core.Project
%


    properties (Hidden, SetAccess = immutable)
        LineProps = {                                                   ...
            struct(                                                     ...
                'Name', 'Mesh',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Structure of the line resource',                ...
                'Class', @steno3d.core.Mesh1D,                          ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Data',                                         ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Data defined on the line resource',             ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.binders.LineBinder,          ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Options for the line resource',                 ...
                'Class', @steno3d.core.opts.LineOptions,                ...
                'Required', false                                       ...
            )                                                           ...
        }
    end

    methods
        function obj = Line(varargin)
            obj = obj@steno3d.core.CompositeResource(varargin{:});
        end
    end

    methods (Hidden)
        function plot(obj, ax)
            if isempty(obj.Data)
                cdata = {'EdgeColor', obj.Opts.Color/255};
            elseif strcmp(obj.Data{1}.Location, 'CC')
                ccarr = obj.Data{1}.Data.Array;
                narr = ccarr(1)*ones(size(obj.Mesh.Vertices, 1), 1);
                narr(obj.Mesh.Segments(:, 1)) = ccarr;
                cdata = {'CData', narr, 'EdgeColor', 'flat'};
            else
                cdata = {'CData', obj.Data{1}.Data.Array,               ...
                         'EdgeColor', 'interp'};
            end

            patch(ax, 'Faces', obj.Mesh.Segments,                       ...
                  'Vertices', obj.Mesh.Vertices,                        ...
                  cdata{:}, 'EdgeAlpha', obj.Opts.Opacity)
        end
    end
end

