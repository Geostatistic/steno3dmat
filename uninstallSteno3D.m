function uninstallSteno3D(varargin)
%UNINSTALLSTENO3D remove steno3d from the MATLAB environment
%
%   UNINSTALLSTENO3D() removes steno3d from the MATLAB path and prompts to
%   delete steno3d files
    
    if steno3d.utils.User.isLoggedIn()
        steno3d.logout()
    end
    
    uninstallpath = strsplit(mfilename('fullpath'), filesep);
    steno3dpath = strjoin(uninstallpath(1:end-1), filesep);

    paths = strsplit(path, pathsep);
    defpaths = strsplit(pathdef, pathsep);
    if ispc
      onPath = any(strcmpi(steno3dpath, paths));
      onDefPath = any(strcmpi(steno3dpath, defpaths));
    else
      onPath = any(strcmp(steno3dpath, paths));
      onDefPath = any(strcmp(steno3dpath, defpaths));
    end

    if onPath
        fprintf('Removing steno3d from current MATLAB path... ');
        rmpath(steno3dpath);
        fprintf('Done\n')
    end

    if onDefPath
        fprintf('Removing steno3d from default MATLAB path... ');
        savedPath = path;
        path(pathdef)
        rmpath(steno3dpath)
        savepath
        path(savedPath)
        fprintf('Done\n')
    end

    remove = input('Delete all contents of steno3dmat? (yes/[no]): ', 's');
    if ~strcmp(remove, 'yes')
        fprintf(['Steno3D MATLAB client still available to use from '   ...
                 'the directory:\n%s\n'], steno3dpath)
    else
        fprintf('Deleting Steno3D MATLAB client.')
        rmdir(steno3dpath, 's')
    end
end
