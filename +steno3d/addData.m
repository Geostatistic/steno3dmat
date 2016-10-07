function addData(varargin)
%ADDDATA Summary of this function goes here
%
%   ADDDATA(res, data)
%   ADDDATA(res, data, title)

    narginchk(2, 3);
    
    res = varargin{1};
    if ~isa(res, 'steno3d.core.CompositeResource')
        error('steno3d:addDataError', ['Data can only be added to '...
              'Steno3D composite resources']);
    end
    
    data = varargin{2};
    if ~isnumeric(data)
        error('steno3d:addDataError', 'Data must be numeric');
    end
    data = data(:);
    
    if nargin == 3
        title = varargin{3};
        if ~ischar(title)
            error('steno3d:addDataError', 'Data title must be a string');
        end
    else
        title = '';
    end
    
    if length(data) == res.Mesh.nN
        loc = 'N';
    elseif length(data) == res.Mesh.nC
        loc = 'CC';
    else
        error('steno3d:addDataError', ['Data length must equal the '    ...
              'number of nodes (%s) or cell centers(%s)'], res.Mesh.nN, ...
              res.Mesh.nC)
    end
    
    dat = {'Location', loc, 'Data', {'Array', data, 'Title', title}};
    
    res.Data{end+1} = dat;

end

