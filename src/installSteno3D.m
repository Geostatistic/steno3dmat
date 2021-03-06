function installSteno3D(varargin)
%`installSteno3D` Add Steno3D to the MATLAB environment
%   `installSteno3D()` copies steno3dmat to '~/.steno3d_client/' and adds
%   steno3d to the default MATLAB path.
%
%   `installSteno3D(folder)` copies steno3dmat to `folder` and adds steno3d to
%   the default MATLAB path.
%
%   %%%note
%       Steno3D requires MATLAB R2014b or later %%%versioncheck
%   %%%codeblock
%       % To install Steno3D to the standard toolbox location
%       installSteno3D([matlabroot filesep 'toolbox'])
%
%   %%%seealso upgradeSteno3D, uninstallSteno3D, testSteno3D


    if verLessThan('matlab', '8.4')
        error('steno3d:installError', ['Steno3D requires MATLAB '       ...
              'Release R2014b or greater.\nIf you do not have access '  ...
              'to this version, consider trying the\n<a href="matlab: ' ...
              'web(''https://github.com/3ptscience/steno3dpy/master/'','...
              ' ''-browser'')">Steno3D client library for Python</a>.']);
    end

    narginchk(0, 1);

    installpath = strsplit(mfilename('fullpath'), filesep);
    installfolder = strjoin(installpath(1:end-1), filesep);
    if ~strcmp(pwd, installfolder)
        error('steno3d:installError',                                   ...
              'Please install from within the unzipped steno3dmat folder');
    end

    if nargin == 1
        targetdir = varargin{1};
        if ~ischar(targetdir)
            error('steno3d:installError',                               ...
                  'Target folder must be the name of a directory.')
        end

        if targetdir(1) == '.' && targetdir(2) == filesep
            targetdir = [pwd targetdir(2:end)];
        end
        if targetdir(1) == '~' && targetdir(2) == filesep
            targetdir = [homedir() targetdir(2:end)];
        end
        if ~isdir(targetdir)
            error('steno3d:installError',                               ...
                  'Target folder must be an existing directory.')
        end
    else
        targetdir = [homedir() filesep '.steno3d_client'];
        if ~isdir(targetdir)
            mkdir(targetdir)
        end
    end
    targetdir = [targetdir filesep 'steno3dmat'];
    if isdir(targetdir)
        error('steno3d:installError',                                   ...
              ['%s\nSteno3D MATLAB client source folder already '       ...
               'exists.\nIf you are looking to update steno3d, please ' ...
               'use\n    >> steno3d.upgrade()\nOtherwise, please '      ...
               'delete the folder and install again.'], targetdir)
    else
        mkdir(targetdir)
    end

    fprintf('Copying files to install location:\n%s\n', targetdir)
    copyfile('testSteno3D.m', targetdir)
    copyfile('uninstallSteno3D.m', targetdir)
    copyfile('upgradeSteno3D.m', targetdir)
    copyfile('installSteno3D.m', targetdir)
    copyfile('README', targetdir)
    copyfile('LICENSE', targetdir)
    steno3ddir = [targetdir filesep '+steno3d'];
    copyfile('+steno3d', steno3ddir)
    propsdir = [targetdir filesep '+props'];
    copyfile('+props', propsdir)

    fprintf('Adding steno3d to current MATLAB path...\n')
    addpath(targetdir)

    fprintf('Adding steno3d to default MATLAB path...\n')
    savedPath = path;
    path(pathdef)
    addpath(targetdir)
    savepath
    path(savedPath)

    remove = input('Remove installation source folder? (yes/[no]): ', 's');
    if strcmp(remove, 'yes')
        fprintf('Removing installation folder:\n%s\n', installfolder);
    end

    fprintf(['\nInstallation complete! To get started with steno3d:\n'  ...
             '    >> help steno3d\n\n']);

    if strcmp(remove, 'yes')
        cd ..
        rmdir(installfolder, 's');
    end
end

function home = homedir()
%HOMEDIR Retreive home directory regardless of platform
%   HOME = HOMEDIR() returns full path to home directory

    if ispc
        home = [getenv('HOMEDRIVE') getenv('HOMEPATH')];
    else
        home = getenv('HOME');
    end
end
