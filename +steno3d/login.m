function login(varargin)
%LOGIN logs in to steno3d.com with your api developer key
%
%   STENO3D.LOGIN()         attempts to login with saved api key
%   STENO3D.LOGIN(API_KEY)  attempts to login with API_KEY
%
%   STENO3D.LOGIN(..., 'Parameter', value)  See below for valid parameters
%
%   Logging in to steno3d is required to upload plots to steno3d.com. To
%   obtain an API developer key, you need a Steno3D account:
%
%   <a href="matlab: web('https://steno3d.com/signup', '-browser')"
%   >https://steno3d.com/signup</a>
%
%   Then, you can request a devel key:
%
%   <a href="matlab: web('https://steno3d.com/settings/developer', '-browser')"
%   >https://steno3d.com/settings/developer</a>
%
%   Unless you choose to 'SkipCredentials', your API key will be saved
%   locally and read next time you call `steno3d.login()`. You can always
%   login using a different devel key (or username if the corresponding
%   devel key is saved in teh credentials file).
%
%   Available valid parameter/value pairs include:
%       'Endpoint'          the target site (default: steno3d.com)
%       'CredentialsFile'   path to file with saved api key (default:
%                           '~/.steno3d_client/credentials')
%       'SkipCredentials'   if true, API_KEY will not be saved to
%                           'CredentialsFile' and if false, it will be
%                           saved (default: false)
%
%   Example:
%   >> STENO3D.LOGIN('username//12345678-xxxx-yyyy-zzzz-SOMEDEVELKEY',  ...
%                    'CredentialsFile', './cred')

    PRODUCTION_BASE_URL = 'https://steno3d.com/';
    VALID_PARAMS = {'Endpoint', 'CredentialsFile', 'SkipCredentials'};

    WELCOME_MESSAGE = ['\n'                                             ...
        'Welcome to the MATLAB client library for Steno3D!\n\n'         ...
    ];

    ALREADY_LOGGED_IN = ['\n'                                           ...
        'You are already logged in as @%s. To log in as a different\n'  ...
        'user please `steno3d.logout()`, then login specifying a\n'     ...
        'different username or API developer key.\n\n'                  ...
    ];

    % Check if steno3d is on the path and if not, add it
    loginpath = strsplit(mfilename('fullpath'), filesep);
    steno3dpath = strjoin(loginpath(1:end-2), filesep);
    paths = strsplit(path, pathsep);
    if ispc
      onPath = any(strcmpi(steno3dpath, paths));
    else
      onPath = any(strcmp(steno3dpath, paths));
    end

    if ~onPath
        addpath(steno3dpath)
    end

    % Check if already logged in
    [loggedIn, user] = steno3d.utils.User.isLoggedIn();
    if loggedIn
        fprintf(ALREADY_LOGGED_IN, user.Uid);
        return
    end

    % Handle variable input parameters
    narginchk(0, 7);
    if rem(nargin, 2) ~= 0
        apikey = varargin{1};
        kwargs = varargin(2:end);
    else
        apikey = '';
        kwargs = varargin;
    end
    endpoint = PRODUCTION_BASE_URL;
    credFile = [homedir() filesep '.steno3d_client' filesep 'credentials'];
    skipCred = false;
    for i=1:2:length(kwargs)
        if ~ischar(kwargs{i})
            error('steno3d:badLoginParam',                              ...
                  ['Login parameter names must be strings. For more '   ...
                   'info:\n>> help steno3d.login']);
        end
        switch lower(kwargs{i})
            case lower(VALID_PARAMS{1})
                endpoint = validateEndpoint(kwargs{i+1});
            case lower(VALID_PARAMS{2})
                credFile = validateCredFile(kwargs{i+1});
            case lower(VALID_PARAMS{3})
                skipCred = validateSkipCred(kwargs{i+1});
            otherwise
                error('steno3d:badLoginParam',                          ...
                      ['Invalid login parameter ''%s''. Valid '         ...
                       'parameters\ninclude: %s\n'                      ...
                       'For more info:\n'                               ...
                       '>> help steno3d.login'],                        ...
                      kwargs{i}, strjoin(VALID_PARAMS, ', '))
        end
    end

    % Check if steno3dmat version is up to date
    if ~isVersionOk(endpoint)
        fprintf('Login failed.\n')
        return
    end

    fprintf(WELCOME_MESSAGE)

    % Login without saving credentials
    if skipCred
        loginWith(apikey, endpoint)
        return
    end

    % Login with saving credentials
    splitfile = strsplit(credFile, filesep);
    if ~isdir(strjoin(splitfile(1:end-1), filesep))
        % The only directory this makes is '~/.steno3d_client/'
        mkdir(strjoin(splitfile(1:end-1), filesep))
    end
    apikeys = {};
    usernames = {};
    if exist(credFile, 'file')
        fprintf('Credentials file found: %s\n', credFile);
        fid = fopen(credFile, 'r');
        line = fgetl(fid);
        while isKey(line)
            splitkey = strsplit(line, '//');
            usernames{end+1} = splitkey(1);
            apikeys{end+1} = line;
            line = fgetl(fid);
        end
        fclose(fid);
    else
        fprintf('Creating new credentials file: %s\n', credFile);
    end
    apiind = find(strcmp(usernames, apikey));
    if apiind
        apikey = apikeys{apiind};
    end
    if strcmp(apikey, '') && ~isempty(apikeys)
        apikey = apikeys{1};
    end
    loginWith(apikey, endpoint)

    % Save new credentials after successful login
    if steno3d.utils.User.isLoggedIn()
        cu = steno3d.utils.User.currentUser();
        fid = fopen(credFile, 'w');
        fprintf(fid, [cu.ApiKey '\n']);
        for i=1:length(apikeys)
            if (strcmp(cu.ApiKey, apikeys{i}) ||                        ...
                    strcmp(cu.Uid, usernames{i}))
                continue
            end
            fprintf(fid, [apikeys{i} '\n']);
        end
        fclose(fid);
    end
end

function loginWith(apikey, endpoint)
% LOGINWITH logs in to steno3d.com with specified apikey and endpoint
%
%   LOGINWITH(APIKEY, ENDPOINT) Attempts to login to ENDPOINT with APIKEY.
%   If APIKEY is an empty string, the user is prompted for a key

    APIKEY_PROMPT = 'Steno3D API key: ';

    FIRST_LOGIN = ['\n'                                                 ...
    'If you do not have a Steno3D developer key, you need to request\n' ...
    'one from the Steno3D website in order to access the API. Please\n' ...
    'log in to the application (if necessary) and request a new key.\n' ...
    '\n'                                                                ...
    '<a href="matlab: web(''%1$ssettings/developer'', ''-browser'')">'  ...
    '%1$ssettings/developer'                                            ...
    '</a>\n'                                                            ...
    '\n'                                                                ...
    'If you are not yet signed up, you can do that here:\n'             ...
    '\n'                                                                ...
    '<a href="matlab: web(''%1$ssignup'', ''-browser'')">'              ...
    '%1$ssignup'                                                        ...
    '</a>\n'                                                            ...
    '\n'                                                                ...
    'When you are ready, please enter the key, or reproduce this\n'     ...
    'prompt by calling steno3d.login().\n\n'                            ...
    ];

    LOGIN_FAILED = ['\n'                                                ...
    'Oh no! We could not log you in. The API developer key that you\n'  ...
    'provided could not be validated. If your current API key has\n'    ...
    'been lost or invalidated, please request a new one at:\n'          ...
    '\n'                                                                ...
    '<a href="matlab: web(''%1$ssettings/developer'', ''-browser'')">'  ...
    '%1$ssettings/developer'                                            ...
    '</a>\n'                                                            ...
    '\n'                                                                ...
    'Then, try `steno3d.login(''your//NEW-DEVEL-KEY'')`\n'              ...
    '\n'                                                                ...
    'If the problem persists:\n'                                        ...
    '\n'                                                                ...
    '1) Restart MATLAB and try again\n'                                 ...
    '2) Update steno3d with `steno3d.update()`\n'                       ...
    '3) Ask for <help@steno3d.com>\n'                                   ...
    '4) Open an issue https://github.com/3ptscience/steno3dmat/issues\n'...
    '\n'                                                                ...
    ];

    BAD_API_KEY = ['\n'                                                 ...
    'Oh no! Your API developer key format is incorrect.\n'              ...
    '\n'                                                                ...
    'It should be your username followed by ''//'' then 36\n'           ...
    'characters. You may also use only your username if you have\n'     ...
    'access to local saved credentials. If you have not requested\n'    ...
    'an API key or if you have lost your API key, please request\n'     ...
    'a new one at:\n'                                                   ...
    '\n'                                                                ...
    '<a href="matlab: web(''%1$ssettings/developer'', ''-browser'')">'  ...
    '%1$ssettings/developer'                                            ...
    '</a>\n'                                                            ...
    '\n'                                                                ...
    ];

    if strcmp(apikey, '')
        fprintf(FIRST_LOGIN, endpoint);
        apikey = input(APIKEY_PROMPT, 's');
    end
    if ~isKey(apikey)
        fprintf(BAD_API_KEY, endpoint);
        return
    end

    try
        resp = webread([endpoint 'api/me'],                             ...
                       'sshKey', apikey,                                ...
                       'client', ['steno3dmat:' steno3d.utils.version()]);
    catch ME
        if strcmp(ME.identifier, 'MATLAB:webservices:UnknownHost')
            notConnectedError()
        else
            fprintf(LOGIN_FAILED, endpoint)
        end
        steno3d.logout()
        return
    end
    user = steno3d.utils.User(apikey, endpoint, resp);
    fprintf('Welcome to Steno3D! You are logged in as @%s\n', user.Uid)
    assignin('base', 'steno3d_user', user)
end

function home = homedir()
%HOMEDIR retreive home directory regardless of platform
%
%   HOME = HOMEDIR() returns full path to home directory

    if ispc
        home = [getenv('HOMEDRIVE') getenv('HOMEPATH')];
    else
        home = getenv('HOME');
    end
end

function endpt = validateEndpoint(endpt)
%VALIDATEENDPOINT ensures the steno3d web endpoint is valid
%
%   ENDPT = VALIDATEENDPOINT(ENDPT) checks if ENDPT is a string, starts
%   with https, and adds a trailing slash if none is found

    if ~ischar(endpt)
        error('steno3d:badLoginParam',                                  ...
              ['Endpoint must be string. For more info:\n'              ...
               '>> help steno3d.login']);
    end
    if ~isempty(strfind(endpt, '.com')) && ~strcmp(endpt(1:5), 'https')
        error('steno3d:badLoginParam',                                  ...
              ['Live endpoints require HTTPS. For more info:\n'         ...
               '>> help steno3d.login']);
    end
    if endpt(end) ~= '/'
        endpt = [endpt '/'];
    end
end

function crf = validateCredFile(crf)
%VALIDATECREDFILE ensures the credentials file is valid
%
%   CRF = VALIDATECREDFILE(CRF) checks if CRF is a string, expands '.' and
%   '~' to the full path, checks that CRF is in an existing directory and
%   CRF is not a directory.

    if ~ischar(crf)
        error('steno3d:badLoginParam',                                  ...
              ['CredentialsFile must be string. For more info:\n'       ...
               '>> help steno3d.login']);
    end
    if crf(1) == '.' && crf(2) == filesep
        crf = [pwd crf(2:end)];
    end
    if crf(1) == '~' && crf(2) == filesep
        crf = [homedir() crf(2:end)];
    end
    if isdir(crf)
        error('steno3d:badLoginParam',                                  ...
              ['CredentialsFile must be a file (or not yet exist). For' ...
               'more info:\n>>help steno3d.login']);
    end
    splitfile = strsplit(crf, filesep);
    crd = strjoin(splitfile(1:end-1), filesep);
    if ~strcmp(crd, [homedir() filesep '.steno3d_client']) && ~isdir(crd)
        error('steno3d:badLoginParam',                                  ...
              ['Directory containing CredentialsFile does not exist:\n' ...
               '%s\n'                                                   ...
               'For more info:\n>> help steno3d.login'], crd)
    end
end

function skipcr = validateSkipCred(skipcr)
%VALIDATESKIPCRED ensures skip credentials value is a boolean
%
%   SKIPCR = VALIDATESKIPCRED(SKIPCR) checks that SKIPCR is true (1) or
%   false (0)

    try
        if islogical(skipcr)
            return
        end
    catch
    end
    error('steno3d:badLoginParam',                                      ...
          ['SkipCredentials must be true or false. For more info:\n'    ...
           '>> help steno3d.login']);
end

function isValid = isKey(key)
%VALIDATEKEY ensures the develkey is a valid format
%
%   ISVALID = ISKEY(KEY) returns true if KEY is a string, contains '//',
%   and has 36 characters following the '//'; returns false otherwise.

    isValid = true;
    if ~ischar(key)
        isValid = false;
        return
    end
    splitKey = strsplit(key, '//');
    if length(splitKey) ~= 2 || length(splitKey{2}) ~= 36
        isValid = false;
    end
end

function versionOk = isVersionOk(endpoint)
%ISVERSIONOK checks if the current version is up to date
%
%   VERSIONOK = ISVERSIONOK(ENDPOINT) queries ENDPOINT for the latest
%   version of steno3dmat and compares that to the local version of
%   steno3dmat. Returns false if the latest version of steno3dmat is
%   a major or minor version ahead of the local version; otherwise returns
%   true.
%
%   User is still notified if their version of steno3dmat is out of date
%   even if it is valid.

    INVALID_VERSION = ['\n'                                             ...
    'Oh no! Your version of steno3d is out of date.\n'                  ...
    '\n%s\n%s\n\n'                                                      ...
    'Please update steno3d with `steno3d.upgrade()`.\n\n'               ...
    ];

    BETA_TEST = ['\n'                                                   ...
    'It looks like you are using a beta version of steno3d. Thank you\n'...
    'for trying it out!\n'                                              ...
    '\n'                                                                ...
    'Please, if you run into any problems or have any feedback, open\n' ...
    'an issue at https://github.com/3ptscience/steno3dmat/issues\n'     ...
    '\n'                                                                ...
    'If you would like to switch to the most recent stable version:\n'  ...
    '>> steno3d.upgrade()\n\n'                                          ...
    ];

    versionOk = true;
    try
        resp = webwrite([endpoint 'api/client/steno3dmat'],             ...
                        'version', steno3d.utils.version());
    catch ME
        if strcmp(ME.identifier, 'MATLAB:webservices:UnknownHost')
            notConnectedError();
            versionOk = false;
        end
        if strcmp(ME.identifier,                                        ...
                  'MATLAB:webservices:HTTP400StatusCodeError')
            versplit = strsplit(steno3d.utils.version(), '.');
            if strfind(versplit(3), 'b')
                fprintf(BETA_TEST);
            else
                fprintf(INVALID_VERSION,                                ...
                        ['Your version: ' steno3d.utils.version()],     ...
                        'Error: Invalid version string');
            end
        end
        return
    end
    yourVer = str2double(strsplit(resp.your_version, '.'));
    currVer = str2double(strsplit(resp.current_version, '.'));
    if resp.valid || strcmp(resp.current_version, '0.0.0')
        return
    elseif yourVer(0) == currVer(0) && yourVer(1) == currVer(1)
        fprintf(INVALID_VERSION, ['Your version: ' resp.your_version],  ...
                ['Current version: ' resp.current_version]);
    else
        fprintf(INVALID_VERSION, ['Your version: ' resp.your_version],  ...
                ['Required version: ' resp.current_version]);
        if yourVer(0) < currVer(0)
            versionOk = false;
        elseif yourVer(0) == currVer(0) && yourVer(1) < currVer(1)
            versionOk = false;
        end
    end
end

function notConnectedError()
% NOTCONNECTEDERROR prints an error if you cannot connect to the server

    NOT_CONNECTED = ['\n'                                               ...
    'Oh no! We could not connect to the Steno3D server. Please ensure\n'...
    'that you are:\n'                                                   ...
    '\n'                                                                ...
    '1) Connected to the Internet\n'                                    ...
    '2) Can connect to Steno3D at https://steno3d.com\n'                ...
    '3) Ask for <help@steno3d.com>\n'                                   ...
    '4) Open an issue https://github.com/3ptscience/steno3dmat/issues\n'...
    '\n'                                                                ...
    ];

    fprintf(NOT_CONNECTED)

end
