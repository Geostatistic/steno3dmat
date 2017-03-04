classdef Volume < steno3d.core.CompositeResource
%VOLUME Low-level Steno3D Volume resource
%   Volumes are 3D resources. Their geometry is defined by a <a href="
%   matlab: help steno3d.core.Mesh3DGrid">Mesh3DGrid</a>
%   with regularly spaced x-, y-, and z-axes. Volumes may have <a href="
%   matlab: help steno3d.core.DataArray">Data</a> defined
%   on the cell-centers. There are several <a href=" matlab:
%   help steno3d.core.opts.VolumeOptions">volume options</a> and
%   <a href="matlab: help steno3d.core.opts.Mesh3DOptions
%   ">mesh options</a> available for customizing the appearance.
%
%   VOLUME resources can also be created through a high-level functional
%   interface with <a href="matlab: help steno3d.volume
%   ">steno3d.volume</a>.
%
%   VOLUME implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="
%   matlab: help props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       Mesh (<a href="matlab: help props.Instance">props.Instance</a>)
%           Structure of the volume resource
%           Class: <a href="matlab: help steno3d.core.Mesh3DGrid
%           ">Mesh3DGrid</a>
%
%       Data (<a href="matlab: help props.Repeated">props.Repeated</a>)
%           Data defined on the volume resource
%           Type: props.Instance (Class: <a href="matlab:
%           help steno3d.core.binders
%           ">VolumeBinder</a>)
%
%   OPTIONAL PROPERTIES:
%       Opts (<a href="matlab: help props.Instance">props.Instance</a>)
%           Options for the volume resource
%           Class: <a href="matlab: help steno3d.core.opts.VolumeOptions
%           ">VolumeOptions</a>
%
%       Title (<a href="matlab: help props.String">props.String</a>)
%           Content title
%
%       Description (<a href="matlab: help props.String">props.String</a>)
%           Content description
%
%
%   See the <a href="matlab: help steno3d.examples.core.volume
%   ">EXAMPLES</a>
%
%   See also STENO3D.VOLUME, STENO3D.CORE.MESH3DGRID, STENO3D.CORE.BINDERS,
%   STENO3D.CORE.OPTS.VOLUMEOPTIONS, STENO3D.CORE.COMPOSITERESOURCE,
%   STENO3D.CORE.PROJECT
%


    properties (Hidden, SetAccess = immutable)
        VolumeProps = {                                                 ...
            struct(                                                     ...
                'Name', 'Mesh',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Structure of the volume resource',              ...
                'Class', @steno3d.core.Mesh3DGrid,                      ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Data',                                         ...
                'Type', @props.Repeated,                                ...
                'Doc', 'Data defined on the volume resource',           ...
                'PropType', struct(                                     ...
                    'Type', @props.Instance,                            ...
                    'Class', @steno3d.core.binders.VolumeBinder,        ...
                    'Initialize', false                                 ...
                ),                                                      ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Opts',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Options for the volume resource',               ...
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

    methods (Hidden)
        function plot(obj, ax)
            origin = obj.Mesh.O;
            os = {origin, origin + [0 0 sum(obj.Mesh.H3)/2],            ...
                  origin + [0 0 sum(obj.Mesh.H3)],                      ...
                  origin, origin + [0 sum(obj.Mesh.H2)/2 0],            ...
                  origin + [0 sum(obj.Mesh.H2) 0],                      ...
                  origin, origin + [sum(obj.Mesh.H1)/2 0 0],            ...
                  origin + [sum(obj.Mesh.H1) 0 0]};
            us = {[1 0 0], [1 0 0], [1 0 0],                            ...
                  [1 0 0], [1 0 0], [1 0 0],                            ...
                  [0 1 0], [0 1 0], [0 1 0]};
            vs = {[0 1 0], [0 1 0], [0 1 0],                            ...
                  [0 0 1], [0 0 1], [0 0 1],                            ...
                  [0 0 1], [0 0 1], [0 0 1]};
            dat = reshape(obj.Data{1}.Data.Array, length(obj.Mesh.H1),  ...
                          length(obj.Mesh.H2), length(obj.Mesh.H3));
            dats = {dat(:,:,1), dat(:,:,round(end/2)), dat(:,:,end),    ...
                    dat(:,1,:), dat(:,round(end/2),:), dat(:,end,:),    ...
                    dat(1,:,:), dat(round(end/2),:,:), dat(end,:,:)};
            h1s = {obj.Mesh.H1, obj.Mesh.H1, obj.Mesh.H1,               ...
                   obj.Mesh.H1, obj.Mesh.H1, obj.Mesh.H1,               ...
                   obj.Mesh.H2, obj.Mesh.H2, obj.Mesh.H2};
            h2s = {obj.Mesh.H2, obj.Mesh.H2, obj.Mesh.H2,               ...
                   obj.Mesh.H3, obj.Mesh.H3, obj.Mesh.H3,               ...
                   obj.Mesh.H3, obj.Mesh.H3, obj.Mesh.H3};
            for i = 1:9
                lh1 = length(h1s{i});
                lh2 = length(h2s{i});
                h1 = repmat([0 cumsum(h1s{i})'], lh2+1, 1)';
                h2 = repmat([0 cumsum(h2s{i})'], lh1+1, 1);
                u = us{i};
                v = vs{i};
                u = u/sqrt(sum(u.^2));
                v = v/sqrt(sum(v.^2));
                verts = h1(:)*u + h2(:)*v + ones(size(h1(:)))*os{i};
                f = 1:lh1;
                f = [f; f+1; f+lh1+2; f+lh1+1]';
                faces = repmat(f, lh2, 1);
                offset = (lh1+1)*(0:lh2-1);
                offset = ones(lh1, 1) * offset;
                faces = faces + offset(:)*ones(1, 4);
                ccarr = dats{i}(:);
                narr = ccarr(1)*ones(size(verts, 1), 1, 'double');
                narr(faces(:, 1)) = ccarr;
                cdata = {'CData', narr, 'FaceColor', 'flat'};
                if obj.Mesh.Opts.Wireframe
                    ec = [0 0 0];
                else
                    ec = 'none';
                end
                patch('Parent', ax, 'Vertices', verts, 'Faces', faces,  ...
                      cdata{:}, 'EdgeColor', ec, 'FaceAlpha',           ...
                      obj.Opts.Opacity);
                hold on;
            end
        end
    end
end

