classdef User
% USER user object constructed from user query response data
%
%   obj = USER(APIKEY, ENDPT, USERDATA) creates USER object with
%   steno3d.com APIKEY, ENDPT web address, and user-query response
%   object USERDATA

    properties (SetAccess = immutable)
        ApiKey
        Endpoint
        Uid
        Name
        Email
        Url
        Affiliation
        Location
        FileSizeLimit = 5000000
        FigSizeLimit = 25000000
        FigCompLimit = 25
    end
    methods
        function obj = User(apikey, endpt, userdata)
            obj.ApiKey = apikey;
            obj.Endpoint = endpt;
            obj.Uid = userdata.uid;
            obj.Name = userdata.name;
            obj.Email = userdata.email;
            obj.Url = userdata.url;
            obj.Affiliation = userdata.affiliation;
            obj.Location = userdata.location;
        end
    end
    methods (Static)
        function varargout = currentUser()
        %CURRENTUSER Checks for current, logged in steno3d user
        %
        %   CURRENTUSER() returns true if a user is logged in and false
        %   otherwise. Errors if `steno3d_user` exists but contains
        %   something other than user data
        %
        %   user = CURRENTUSER() returns the currently logged in user or
        %   errors if no user is logged in
            
            try
                user = evalin('base', 'steno3d_user');
                loggedIn = true;
            catch
                user = 'None';
                loggedIn = false;
            end
            if loggedIn && ~isa(user, 'steno3d.User')
                error('steno3d:userError',                              ...
                      ['The variable used to store user data '          ...
                       '(steno3d_user) exists\nbut does''t contain '    ...
                       'user data.\nPlease `clear steno3d_user` '       ...
                       'and `steno3d.login() again.'])
            end
                
            if nargout == 0
                varargout{1} = loggedIn;
                return
            end
            if ~loggedIn
                error('steno3d:userError',                              ...
                      'No user is logged in to steno3d')
            end
            if nargout == 1 
                varargout{1} = user;
                return
            end
        end
    end
end

