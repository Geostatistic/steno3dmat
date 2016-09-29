function [res, fail] = toStenoRes(gh, tabLevel)
%TOSTENORES Summary of this function goes here
%   Detailed explanation goes here
    if nargin == 1
        tabLevel = '';
    end

    if ~isgraphics(gh)
        error('steno3d:matlabFigureError',                              ...
              'Input to toStenoRes must be a graphics handle');
    end
    
    res = {};
    fail = 0;
    fprintf([tabLevel 'Converting ' gh.Type '...\n']);
    
    switch gh.Type
        case {'axes', 'figure'}
            res = steno3d.fig2steno(gh);
            return
        case 'line'
            res = steno3d.utils.convert.line(gh);
        case 'scatter'
            res = steno3d.utils.convert.scatter(gh);
        case 'surface'
            res = steno3d.utils.convert.surface(gh);
                
                
        otherwise
            fprintf([tabLevel '... Unsupported graphics type.\n'])
            fail = 1;
    end
end

