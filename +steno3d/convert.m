function proj = convert(gh, varargin)
%FIG2STENO Summary of this function goes here
%   Detailed explanation goes here

% combineaxes
% combine resources
% tablevel

% ['\nIf you would like to see additional support please' ...
%                 '\nsubmit an issue on <a href="matlab: web('            ...
%                 '''https://github.com/3ptscience/steno3dmat/issues'','  ...
%                 '''-browser'')">github</a> or consider <a href="matlab:'...
%                 ' web(''https://github.com/3ptscience/steno3dmat'','    ...
%                 '''-browser'')">contributing</a>.\n']
            
            
    narginchk(1, 7)
    if rem(length(varargin), 2) ~= 0
        error('steno3d:convertError', ...
              'Incorrect number of inputs. See "help convert"');
    end
    if ~isgraphics(gh)
        error('steno3d:convertError',                                   ...
              'First input to convert must be a graphics handle');
    end
    if ~strcmp(gh.Type, {'figure', 'axes'})
        error('steno3d:convertError', ['Input must be figure or axes '  ...
              'handle. For more information see "help convert"']);
    end
    tabLevel = '';
    combineAxes = false;
    combineRes = false;
    for i = 1:2:length(varargin)
        if ~ischar(varargin{i})
            error('steno3d:convertError',  ...
                  'Parameter names must be strings. See "help convert"');
        end
        switch lower(varargin{i})
            case 'combineaxes'
                if islogical(varargin{i+1}) && length(varargin{i+1}) == 1
                    combineAxes = varargin{i+1};
                else
                    error('steno3d:convertError', ...
                          'CombineAxes value must be true or false');
                end
            case 'combineresources'
                if islogical(varargin{i+1}) && length(varargin{i+1}) == 1
                    combineRes = varargin{i+1};
                else
                    error('steno3d:convertError', ...
                          'CombineResources value must be true or false');
                end
            case 'tablevel'
                if ischar(varargin{i+1})
                    tabLevel = varargin{i+1};
                else
                    error('steno3d:convertError', ...
                          'TabLevel value must be a string');
                end
            otherwise
                error('steno3d:convertError', ['Unrecognized parameter '...
                      '"' varargin{i} '" - See "help convert"']);
        end
    end
    
    fprintf([tabLevel 'Converting ' gh.Type '...\n']);
    
    switch gh.Type
        case 'figure'
            proj = steno3d.utils.convert.figure(gh, combineAxes,        ...
                                                combineRes, tabLevel);
        case 'axes'
            proj = steno3d.utils.convert.axes(gh, combineRes, tabLevel);
        
    end
end



