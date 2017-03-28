function newRes = consolidate(oldRes, tabLevel)
%CONSOLIDATE Attempts to combine similar Steno3D Resources

    if isempty(oldRes) || ~isa(oldRes{1}, 'steno3d.core.CompositeResource')
        error('steno3d:convertError', ['steno3d.utils.consolidate '     ...
              'requires input of type "steno3d.core.CompositeResource"']);
    end

    fprintf([tabLevel 'Consolidating project resources...\n']);

    newRes = {};
    while ~isempty(oldRes)
        newRes = {newRes{:} oldRes{1}};
        oldRes = oldRes(2:end);
        keep = [];
        for j = 1:length(oldRes)
            try
                newRes{end} = consolidateResources(newRes{end}, oldRes{j});
            catch
                keep = [keep j];
            end
        end
        oldRes = oldRes(keep);
    end
end


function res = consolidateResources(res1, res2)
%CONSOLIDATERESOURCES Combines two resources or errors if not possible

    mc = metaclass(res1.Mesh);
    if ~isa(res2.Mesh, mc.Name)
        error('steno3d:consolidationError', ...
              'Cannot consolodate resources with different mesh types');
    end

    dataeq = true;
    if length(res1.Data) ~= length(res2.Data)
        dataeq = false;
    else
        for k = 1:length(res1.Data)
            if ~strcmp(res1.Data{k}.Location, res2.Data{k}.Location) || ...
                  ~strcmp(res1.Data{k}.Data.Title, res2.Data{k}.Data.Title)
               dataeq = false;
            end
        end
        if any(res1.Opts.Color ~= res2.Opts.Color)
            dataeq = false;
        end
    end

    if isa(res1.Mesh, 'steno3d.core.Mesh0D')
        if length(res1.Mesh.Vertices) == length(res2.Mesh.Vertices) &&  ...
                all(res1.Mesh.Vertices(:) == res2.Mesh.Vertices(:))
            res = res1;
            res.Data = [res.Data res2.Data];
            res.Textures = [res.Textures res2.Textures];
            return

        elseif dataeq
            res = res1;
            res.Mesh.Vertices = [res.Mesh.Vertices; res2.Mesh.Vertices];
            for i = 1:length(res.Data)
                res.Data{i}.Data.Array = [res.Data{i}.Data.Array;       ...
                                          res2.Data{i}.Data.Array];
            end
            res.Textures = [res.Textures res2.Textures];
            return

        end
    elseif isa(res1.Mesh, 'steno3d.core.Mesh1D')
        if length(res1.Mesh.Vertices) == length(res2.Mesh.Vertices) &&  ...
           length(res1.Mesh.segments) == length(res2.Mesh.Segments) &&  ...
                all(res1.Mesh.Vertices(:) == res2.Mesh.Vertices(:)) &&  ...
                all(res1.Mesh.Segments(:) == res2.Mesh.Segments(:))
            res = res1;
            res.Data = [res.Data res2.Data];
            res.Textures = [res.Textures res2.Textures];
            return

        elseif dataeq
            res = res1;
            res.Mesh.Segments = [                                       ...
                res.Mesh.Segments;                                      ...
                res2.Mesh.Segments+size(res.Mesh.Vertices, 1)           ...
            ];
            res.Mesh.Vertices = [res.Mesh.Vertices; res2.Mesh.Vertices];...
            for i = 1:length(res.Data)
                res.Data{i}.Data.Array = [res.Data{i}.Data.Array;       ...
                                          res2.Data{i}.Data.Array];
            end
            return

        end
    elseif isa(res1.Mesh, 'steno3d.core.Mesh2D')
        if length(res1.Mesh.Vertices) == length(res2.Mesh.Vertices) &&  ...
           length(res1.Mesh.Triangles) == length(res2.Mesh.Triangles) &&...
                all(res1.Mesh.Vertices(:) == res2.Mesh.Vertices(:)) &&  ...
                all(res1.Mesh.Triangles(:) == res2.Mesh.Triangles(:))
            res = res1;
            res.Data = [res.Data res2.Data];
            res.Textures = [res.Textures res2.Textures];
            return

        elseif dataeq
            res = res1;
            res.Mesh.Triangles = [                                      ...
                res.Mesh.Triangles;                                     ...
                res2.Mesh.Triangles+size(res.Mesh.Vertices, 1)          ...
            ];
            res.Mesh.Vertices = [res.Mesh.Vertices; res2.Mesh.Vertices];
            for i = 1:length(res.Data)
                res.Data{i}.Data.Array = [res.Data{i}.Data.Array;
                                          res2.Data{i}.Data.Array];
            end
            res.Textures = [res.Textures res2.Textures];
            return

        end
    elseif isa(res1.Mesh, 'steno3d.core.Mesh2DGrid')
        if all(res1.Mesh.H1(:) == res2.Mesh.H1(:)) &&                   ...
                all(res1.Mesh.H2(:) == res2.Mesh.H2(:)) &&              ...
                all(res1.Mesh.O(:) == res2.Mesh.O(:)) &&                ...
                all(res1.Mesh.U(:) == res2.Mesh.U(:)) &&                ...
                all(res1.Mesh.V(:) == res2.Mesh.V(:)) &&                ...
                all(res1.Mesh.Z(:) == res2.Mesh.Z(:))
            res = res1;
            res.Data = [res.Data res2.Data];
            res.Textures = [res.Textures res2.Textures];
            return

        end
    elseif isa(res1.Mesh, 'steno3d.core.Mesh3DGrid')
        if all(res1.Mesh.H1(:) == res2.Mesh.H1(:)) &&                   ...
                all(res1.Mesh.H2(:) == res2.Mesh.H2(:)) &&              ...
                all(res1.Mesh.H3(:) == res2.Mesh.H3(:)) &&              ...
                all(res1.Mesh.O(:) == res2.Mesh.O(:))
            res = res1;
            res.Data = [res.Data res2.Data];
            return
        end
    else
        error('steno3d:consolidationError',                             ...
              'Cannot consolidate resources');
    end
end
