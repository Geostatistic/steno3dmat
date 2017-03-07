function resp = get(url, varargin)
%GET perform a web request to steno3d.com
%
%   RESP = GET(URL) get data from the URL endpoint of steno3d.com, passing
%   required headers and any additional parameter/value pairs. Returns web
%   response, converted from json to matlab struct, or errors if no user is
%   logged in.

    if ~steno3d.utils.User.isLoggedIn()
        error('steno3d:notLoggedIn', 'Please `steno3d.login()`')
    end
    user = steno3d.utils.User.currentUser();
    resp_string = urlread([user.Endpoint url], 'get',                   ...
                   [varargin {'sshKey', user.ApiKey,                    ...
                   'client', ['steno3dmat:' steno3d.version()]}]);
    if nargout == 1
        resp = steno3d.utils.json2struct(resp_string);
    end
end

