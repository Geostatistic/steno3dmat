function logout()
% LOGOUT Logs user out of current steno3d session
%
%   STENO3D.LOGOUT() logs out of developer session on steno3d.com,
%   deletes current user data, and removes steno3d from the path if it
%   is not on the default path.

    fprintf('Logging out of steno3d...\n')

    if steno3d.utils.User.isLoggedIn()
        steno3d.utils.get('signout');
        user = steno3d.utils.User.currentUser();
        fprintf('Goodbye, @%s\n', user.Uid);
        evalin('base', 'clear steno3d_user');
    end

    logoutpath = strsplit(mfilename('fullpath'), filesep);
    steno3dpath = strjoin(logoutpath(1:end-2), filesep);

    paths = strsplit(path, pathsep);
    defpaths = strsplit(pathdef, pathsep);
    if ispc
      onPath = any(strcmpi(steno3dpath, paths));
      onDefPath = any(strcmpi(steno3dpath, defpaths));
    else
      onPath = any(strcmp(steno3dpath, paths));
      onDefPath = any(strcmp(steno3dpath, defpaths));
    end

    if onPath && ~onDefPath
        fprintf('Removing steno3d from MATLAB path...\n');
        rmpath(steno3dpath);
    end
end
