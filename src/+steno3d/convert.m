function proj = convert(handle, varargin)
%CONVERT Convert MATLAB figure or axes into a Steno3D Project
%   `project = steno3d.convert(handle)` converts the figure or axes `HANDLE`
%   to `PROJECT`, a Steno3D %%%ref[Project](steno3d.core.Project) or list of Projects.
%
%   `project = steno3d.convert(..., parameter, value)` converts the figure or
%   axes `handle` using the given `parameter`/`value` pairs. Available parameters
%   are:
%
%       %%%bold[CombineAxes]: true or false (default: true)
%           If HANDLE is a figure with multiple axes and CombineAxes is
%           false, a separate project will be created for each axes.
%           If HANDLE is a figure with multiple axes and CombineAxes is
%           true, the contents of all axes will be added to one project.
%           If HANDLE is an axes or a figure with one axes, CombineAxes has
%           no effect.
%       %%%bold[CombineResources]: true or false (default: true)
%           If CombineResources is false, every MATLAB graphics object
%           encountered will produce a separate Steno3D Resource.
%           If CombineResources is true, this function attempts to combine
%           similar graphics objects into single Steno3D Resources. This
%           includes combining multiple data sets with identical underlying
%           geometry and appending similar resources with the same data
%           titles (or no data). Although this parameter exists, it is
%           recommended to build resources carefully using the Steno3D
%           plotting rather than relying on correct conversion of MATLAB
%           graphics.
%
%   Supported MATLAB graphics types include contour, group, image, line,
%   patch, scatter, and surface. These cover the majority of MATLAB builtin
%   plotting functions. Currently, unsupported MATLAB graphics types
%   include polaraxes, transform, area, bar, errorbar, quiver, stair, stem,
%   rectangle, text, light, and function objects.
%
%   Additionally, not all properties of the graphics are supported by
%   Steno3D. Most notably, variable color data is not supported; only
%   one-element data is currently allowed. Other unsupported aspects are
%   different line/marker types, variable alpha data, camera/lighting, etc.
%   After converting a MATLAB figure to a Steno3D Project, you may plot the
%   project to ensure all the required features were converted.
%
%   If you would like to see additional support please submit an issue on
%   %%%link[github](https://github.com/3ptscience/steno3dmat/issues) or consider %%%link[contributing](https://github.com/3ptscience/steno3dmat).
%
%   Example:
%   %%%codeblock
%       peaks;
%       peaksProj = steno3d.convert(gcf);
%
%   See more %%%ref[EXAMPLES](steno3d.examples.convert)
%
%   %%%seealso steno3d.core.Project, steno3d.combine
%


    steno3d.utils.matverchk();
    narginchk(1, 7)
    if rem(length(varargin), 2) ~= 0
        error('steno3d:convertError', ...
              'Incorrect number of inputs');
    end
    if ~isgraphics(handle)
        error('steno3d:convertError',                                   ...
              'First input to convert must be a graphics handle');
    end
    if ~strcmp(handle.Type, {'figure', 'axes'})
        error('steno3d:convertError',                                   ...
              'Input must be figure or axes handle.');
    end
    tabLevel = '';
    combineAxes = true;
    combineRes = true;
    for i = 1:2:length(varargin)
        if ~ischar(varargin{i})
            error('steno3d:convertError',  ...
                  'Parameter names must be strings');
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
                      '"' varargin{i} '"']);
        end
    end
    fprintf([tabLevel 'Converting ' handle.Type '...\n']);
    switch handle.Type
        case 'figure'
            proj = steno3d.utils.convert.figure(handle, combineAxes,    ...
                                                combineRes, tabLevel);
        case 'axes'
            proj = steno3d.utils.convert.axes(handle, combineRes,       ...
                                              tabLevel);
    end
end



