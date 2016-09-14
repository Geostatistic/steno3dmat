function resp = get(url)
%GET perform a web request to steno3d.com
%
%   RESP = GET(URL) get data from the URL endpoint of steno3d.com, passing
%   required headers. Returns web response or errors if no user is logged
%   in.

    if ~steno3d.User.isLoggedIn()
        error('steno3d:notLoggedIn', 'Please `steno3d.login()`')
    end
    user = steno3d.User.currentUser();
    resp = webread([user.Endpoint url],                                 ...
                   'sshKey', user.ApiKey,                               ...
                   'client', ['steno3dmat:' steno3d.utils.version()]);
end

