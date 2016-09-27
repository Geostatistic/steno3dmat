function resp = post(url, varargin)
%POST perform a web request to steno3d.com
%
%   RESP = POST(URL) posts data to the URL endpoint of steno3d.com, passing
%   required headers and any additional key/value pairs as varargin.
%   Returns web response or errors if no user is logged in.

    if ~steno3d.utils.User.isLoggedIn()
        error('steno3d:notLoggedIn', 'Please `steno3d.login()`')
    end
    user = steno3d.utils.User.currentUser();

    resp_string = steno3d.utils.urlreadpost(                            ...
        [user.Endpoint url],                                            ...
        [{'sshKey', user.ApiKey,                                        ...
        'client', ['steno3dmat:' steno3d.utils.version()]},             ...
        varargin]                                                       ...
    );
    resp = steno3d.utils.json2struct(resp_string);
end


