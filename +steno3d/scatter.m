function [proj, pts] = scatter(varargin)
%SCATTER Create and plot a Steno3D Point resource
%   STENO3D.SCATTER(XYZ) creates a Steno3D Project with a Point resource
%   defined by n x 3 matrix XYZ.
%
%   STENO3D.SCATTER(X, Y, Z) creates a Steno3D Project with a Point
%   resource defined by equal-sized vectors or matrices X, Y, and Z.
%
%   STENO3D.SCATTER(..., Color) creates a Point resource of the give color,
%   where Color is a 1x3 RGB color, hex color string, named color string,
%   or 'random'.
%
%   STENO3D.SCATTER(..., Title1, Data1, ..., TitleN, DataN) adds any number
%   of titled datasets to the Point resource. Title must be a string and
%   Data must be an matrix or vector that, when flattened, is length n,
%   where n is the number of points. (For more details see <a href="matlab:    
%   help steno3d.addData">steno3d.addData</a>)
%
%   STENO3D.SCATTER(Proj, ...) adds the Point resource to Proj, an existing
%   Steno3D Project. Proj may also be a figure or axes handle that was
%   cfreated by a Steno3D plotting function
%
%   Proj = STENO3D.SCATTER(...) returns Proj, the Steno3D Project that
%   contains the new line resource.
%
%   [Proj, Pts] = STENO3D.SCATTER(...) returns Proj, the Steno3D Project,
%   and Pts, the new Point resource.
%
%   STENO3D.SCATTER is more similar to the MATLAB builtin function <a
%   href="matlab: help scatter3">scatter3</a>
%   than the builtin function <a href="matlab: help scatter"
%   >scatter</a> since it requres a 3D dataset.
%   Unlike the builtin functions, STENO3D.SCATTER does not support any
%   additional property/value pairs. After creating a Point resource with
%   STENO3D.SCATTER, properties fo the Point object can b edirectly
%   modified.
%
%   Example:
%       x = 0:pi/10:4*pi;
%       [myProject, myPoints] = STENO3D.SCATTER(                        ...
%           [x(:) cos(x(:)+0.2) sin(x(:))], [0 .5 .5],                  ...
%           'Random Data', rand(size(x))                                ...
%       );
%       myPoints.Title = 'Example Points';
%       myPoints.Description = 'Trig functions with random data';
%       myProject.Title = 'Project with one set of Points';
%       myProject.Public = true;
%       steno3d.upload(myProject);
%
%   See also STENO3D.CORE.POINT, STENO3D.UPLOAD, STENO3D.ADDDATA,
%   STENO3D.ADDIMAGE, STENO3D.CORE.PROJECT
%


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

