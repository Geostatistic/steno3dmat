function logout()
% LOGOUT Log out of current session on steno3d.com
%   `steno3d.logout()` logs user out of their current session with
%   steno3d.com, deletes current user data from the workspace, and removes
%   steno3d from the path if it is not on the default path by default.
%   Note: Although user data is deleted, the API key may remain in MATLAB
%   history. If you feel like your API key has become compromised you may
%   delete it through your online %%%link[profile](https://steno3d.com/settings/developer).
%
%   Example:
%   %%%codeblock
%       steno3d.login();
%       peaks; steno3d.upload(gcf);
%       steno3d.logout();
%
%
%   See more %%%ref[EXAMPLES](steno3d.exampls.upload)
%
%   %%%seealso STENO3D.LOGIN, STENO3D.UPLOAD, UPGRADESTENO3D,
%   UNINSTALLSTENO3D
%


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
