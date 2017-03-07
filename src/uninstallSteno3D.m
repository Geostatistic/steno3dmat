function uninstallSteno3D()
%`uninstallSteno3D` Remove Steno3D from the MATLAB environment
%   `uninstallSteno3D()` removes steno3d from the MATLAB path and prompts the
%   user to delete the directory with Steno3D files.
%
%   %%%note This function deletes the entire steno3dmat directory if the user
%   answers yes to a prompt. This will delete any files in that directory
%   even if they were not part of the original installation.
%
%   %%%seealso UPGRADESTENO3D, INSTALLSTENO3D
%


    uninstallpath = strsplit(mfilename('fullpath'), filesep);
    steno3dpath = strjoin(uninstallpath(1:end-1), filesep);

    if steno3d.utils.User.isLoggedIn()
        steno3d.logout()
    end

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

    fprintf('Delete steno3dmat directory %s\n', steno3dpath);
    remove = input('and all its contents? (yes/[no]): ', 's');
    if ~strcmp(remove, 'yes')
        fprintf(['Steno3D MATLAB client still available to use from '   ...
                 'the directory:\n%s\n'], steno3dpath)
    else
        fprintf('Deleting folder:\n%s\n', steno3dpath)
        rmdir(steno3dpath, 's')
    end
end
