classdef Surface < steno3d.core.CompositeResource
%SURFACE Low-level Steno3D Surface resource
%   Surfaces are 2D resources. Their geometry is defined by either a
%   triangulated <a href="matlab: help steno3d.core.Mesh2D
%   ">Mesh2D</a> or a regularly gridded <a href="matlab:
%   help steno3d.core.Mesh2DGrid">Mesh2DGrid</a>. Mesh2D has
%   Vertices connected by Triangles; Mesh2DGrid has regular spacing defined
%   on two axes. Surfaces may have <a href="matlab:
%   help steno3d.core.DataArray">Data</a> defined either on the vertices
%   (nodes) or the faces (cell-centers). There are several <a href="matlab:
%   help steno3d.core.opts.SurfaceOptions">surface options</a>
%   and <a href=" matlab: help steno3d.core.opts.Mesh2DOptions
%   ">mesh options</a> available for customizing the appearance.
%
%   SURFACE resources can also be created through a high-level functional
%   interface with <a href="matlab: help steno3d.trisurf
%   ">steno3d.trisurf</a> (triangulated surface) or
%   <a href="matlab: help steno3d.surface
%   ">steno3d.surface</a> (grid surface).
%
%   For a demonstration of SURFACE, see the <a href="
%   matlab: help steno3d.examples.surface">EXAMPLES</a>.
%
%   SURFACE implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       Mesh (<a href="matlab: help props.Union">props.Union</a>)
%           Structure of the surface resource
%           Types: props.Instance (Class: <a href="matlab:
%                  help steno3d.core.Mesh2D">Mesh2D</a>),
%                  props.Instance (Class: <a href="matlab:
%                  help steno3d.core.Mesh2DGrid
%                  ">Mesh2DGrid</a>)
%
%   OPTIONAL PROPERTIES:
%       Data (<a href="matlab: help props.Repeated">props.Repeated</a>)
%           Data defined on the surface resource
%           Type: props.Instance (Class: <a href="matlab:
%           help steno3d.core.binders
%           ">SurfaceBinder</a>)
%
%       Textures (<a href="matlab: help props.Repeated">props.Repeated</a>)
%           Images mapped to the surface resource
%           Type: props.Instance (Class: <a href="matlab:
%           help steno3d.core.Texture2DImage
%           ">Texture2DImage</a>)
%
%       Opts (<a href="matlab: help props.Instance">props.Instance</a>)
%           Options for the surface resource
%           Class: <a href="matlab: help steno3d.core.opts.SurfaceOptions
%           ">SurfaceOptions</a>
%
%       Title (<a href="matlab: help props.String">props.String</a>)
%           Content title
%
%       Description (<a href="matlab: help props.String">props.String</a>)
%           Content description
%
%   See also steno3d.examples.surface, steno3d.trisurf, steno3d.surface,
%   steno3d.core.Mesh2D, steno3d.core.Mesh2DGrid,
%   steno3d.core.opts.SurfaceOptions, steno3d.core.opts.Mesh2DOptions,
%   steno3d.core.binders, steno3d.core.CompositeResource,
%   steno3d.core.Project
%


    properties (Hidden, SetAccess = immutable)
        SurfaceProps = {                                                ...
            struct(                                                     ...
                'Name', 'Mesh',                                         ...
                'Type', @props.Union,                                   ...
                'Doc', 'Structure of the surface resource',             ...
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
                'Doc', 'Data defined on the surface resource',          ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.binders.SurfaceBinder,       ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Textures',                                     ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Images mapped to the surface resource',         ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.Texture2DImage,              ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', false                                       ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Options for the surface resource',              ...
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

    methods (Hidden)
        function plot(obj, ax)
            if isa(obj.Mesh, 'steno3d.core.Mesh2D')
                verts = obj.Mesh.Vertices;
                faces = obj.Mesh.Triangles;
            else
                lh1 = length(obj.Mesh.H1);
                lh2 = length(obj.Mesh.H2);
                h1 = repmat([0 cumsum(obj.Mesh.H1)'], lh2+1, 1)';
                h2 = repmat([0 cumsum(obj.Mesh.H2)'], lh1+1, 1);
                u = obj.Mesh.U;
                v = obj.Mesh.V;
                u = u/sqrt(sum(u.^2));
                v = v/sqrt(sum(v.^2));
                verts = h1(:)*u + h2(:)*v + ones(size(h1(:)))*obj.Mesh.O;
                if ~isempty(obj.Mesh.Z)
                    z = cross(u, v);
                    z = z/sqrt(sum(z.^2));
                    verts = verts + obj.Mesh.Z*z;
                end

                f = 1:lh1;
                f = [f; f+1; f+lh1+2; f+lh1+1]';
                faces = repmat(f, lh2, 1);
                offset = (lh1+1)*(0:lh2-1);
                offset = ones(lh1, 1) * offset;
                faces = faces + offset(:)*ones(1, 4);

            end

            if isempty(obj.Data)
                cdata = {'FaceColor', obj.Opts.Color/255};
            elseif strcmp(obj.Data{1}.Location, 'N')
                cdata = {'CData', obj.Data{1}.Data.Array,               ...
                         'FaceColor', 'interp'};
            else
                cdata = {'CData', obj.Data{1}.Data.Array,               ...
                         'FaceColor', 'flat'};
            end

            if obj.Mesh.Opts.Wireframe
                ec = [0 0 0];
            else
                ec = 'none';
            end

            patch('Parent', ax, 'Vertices', verts, 'Faces', faces,      ...
                  cdata{:}, 'EdgeColor', ec, 'FaceAlpha',               ...
                  obj.Opts.Opacity);
        end
    end
end

