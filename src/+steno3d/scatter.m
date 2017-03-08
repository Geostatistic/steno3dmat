function [proj, pts] = scatter(varargin)
%SCATTER Create and plot a Steno3D Point resource
%   `steno3d.scatter(XYZ)` creates a Steno3D Project with a Point resource
%   defined by n x 3 matrix `XYZ`.
%
%   `steno3d.scatter(X, Y, Z)` creates a Steno3D Project with a Point
%   resource defined by equal-sized vectors or matrices `X`, `Y`, and `Z`.
%
%   `steno3d.scatter(..., color)` creates a Point resource of the give color,
%   where `color` is a 1x3 RGB color, hex color string, named color string,
%   or 'random'.
%
%   `steno3d.scatter(..., title1, data1, ..., titleN, dataN)` adds any number
%   of titled datasets to the Point resource. `title` must be a string and
%   `data` must be an matrix or vector that, when flattened, is length n,
%   where n is the number of points. (For more details see %%%func[steno3d.addData](steno3d.addData))
%
%   `steno3d.scatter(project, ...)` adds the Point resource to `project`, an
%   existing Steno3D Project. `project` may also be a figure or axes handle
%   that was created by a Steno3D plotting function
%
%   `project = steno3d.scatter(...)` returns `project`, the Steno3D Project
%   that contains the new Point resource.
%
%   `[project, points] = steno3d.scatter(...)` returns `project`, the Steno3D
%   Project, and `points`, the new Point resource.
%
%   `steno3d.scatter` is more similar to the MATLAB builtin function %%%matlabref[scatter3](scatter3)
%   than the builtin function %%%matlabref[scatter](scatter) since it requres a 3D dataset.
%   Unlike the builtin functions, `steno3d.scatter` does not support any
%   additional property/value pairs. After creating a Point resource with
%   `steno3d.scatter`, properties for the Point object can be directly
%   modified.
%
%   Example:
%   %%%codeblock
%       x = 0:pi/10:4*pi;
%       [myProject, myPoints] = steno3d.scatter(                        ...
%           [x(:) cos(x(:)+0.2) sin(x(:))], [0 .5 .5],                  ...
%           'Random Data', rand(size(x))                                ...
%       );
%       myPoints.Title = 'Example Points';
%       myPoints.Description = 'Trig functions with random data';
%       myProject.Title = 'Project with one set of Points';
%       myProject.Public = true;
%       steno3d.upload(myProject);
%
%
%   See more %%%ref[EXAMPLES](steno3d.examples.scatter)
%
%   %%%seealso steno3d.core.Point, steno3d.upload, steno3d.addData, steno3d.addImage, steno3d.core.Project
%


    steno3d.utils.matverchk();

    if isempty(varargin)
        error('steno3d:scatterError', 'Not enough input arguments');
    end

    if isa(varargin{1}, 'steno3d.core.Project')
        proj = varargin{1};
        varargin = varargin(2:end);
    elseif isgraphics(varargin{1})
        if isa(varargin{1}.UserData, 'steno3d.core.Project')
            proj = varargin{1}.UserData;
            varargin = varargin(2:end);
        else
            error('steno3d:scatterError',                               ...
                  'No project associated with given graphics handle');
        end
    else
        proj = steno3d.core.Project;
    end

    if isempty(varargin)
        error('steno3d:scatterError', 'Not enough input arguments');
    end

    if ~isnumeric(varargin{1})
        error('steno3d:scatterError', 'Must provide numeric x/y/z values');
    end


    if length(varargin) > 2 && ~ischar(varargin{2}) && ~ischar(varargin{3})
        x = varargin{1}; y = varargin{2}; z = varargin{3};
        if any(size(x) ~= size(y)) || any(size(x) ~= size(z))
            error('steno3d:scatterError',                               ...
                  'X, Y, and Z must be the same size');
        end
        xyz = [x(:) y(:) z(:)];
        varargin = varargin(4:end);
    else
        xyz = varargin{1};
        if ~ismatrix(xyz)
            error('steno3d:scatterError', 'XYZ matrix must by n x 3');
        end
        if size(xyz, 2) ~= 3 && size(xyz, 1) == 3;
            xyz = xyz';
        end
        if size(xyz, 2) ~= 3
            error('steno3d:scatterError', 'XYZ matrix must by n x 3');
        end
        varargin = varargin(2:end);
    end

    if length(varargin) == 1 ||                                         ...
            (length(varargin) > 1 && ischar(varargin{2}))
        color = varargin{1};
        varargin = varargin(2:end);
    else
        color = 'random';
    end

    data = {};
    for i = 1:2:length(varargin)
        if ~ischar(varargin{i})
            error('steno3d:scatterError', ['Data must be provided with '...
                  'title/value pairs']);
        end
        if ~isnumeric(varargin{i+1}) ||                                 ...
                length(varargin{i+1}(:)) ~= size(xyz, 1)
            error('steno3d:scatterError', ['Data must be the same '     ...
                  'length as x/y/z values']);
        end
        data{end+1} = {'Data', {'Title', varargin{i},                   ...
                                'Array', varargin{i+1}(:)}};
    end

    pts = steno3d.core.Point(                                           ...
        'Mesh', steno3d.core.Mesh0D(                                    ...
            'Vertices', xyz                                             ...
        ),                                                              ...
        'Data', data,                                                   ...
        'Opts', {'Color', color}                                        ...
    );

    proj.Resources = [proj.Resources {pts}];

    proj.plot();
end
