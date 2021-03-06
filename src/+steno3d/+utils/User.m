classdef User
%USER Object constructed from user query response data

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
        %USER Constructor from user query response data
        %
        %   OBJ = USER(APIKEY, ENDPT, USERDATA) creates USER object with
        %   steno3d.com APIKEY, ENDPT web address, and user-query response
        %   struct USERDATA.

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
        function [loggedIn, user] = isLoggedIn()
        %ISLOGGEDIN Check if a user is logged in to Steno3D
        %
        %   ISLOGGEDIN() returns true if a user is logged in and false
        %   otherwise. Errors if 'steno3d_user' exists as a variable in the
        %   current worspace but contains something other than user data.
        %
        %   [LOGGEDIN, USER] = STENO3D.UTILS.ISLOGGEDIN() returns true or
        %   false for LOGGEDIN as described above, and the currently
        %   logged in USER. If LOGGEDIN is false, USER is 'None'.

            try
                user = evalin('base', 'steno3d_user');
                loggedIn = true;
            catch
                user = 'None';
                loggedIn = false;
            end
            if loggedIn && ~isa(user, 'steno3d.utils.User')
                error('steno3d:userError',                              ...
                      ['The variable used to store user data '          ...
                       '(steno3d_user) exists\nbut does''t contain '    ...
                       'user data.\nPlease `clear steno3d_user` '       ...
                       'and `steno3d.login()` again.'])
            end
        end
        function user = currentUser()
        %CURRENTUSER Return the current, logged in Steno3D user
        %
        %   USER = CURRENTUSER() returns the current Steno3D USER or
        %   errors if no user is logged in.

            [loggedIn, user] = steno3d.utils.User.isLoggedIn();
            if ~loggedIn
                error('steno3d:userError',                              ...
                      'No user is logged in to steno3d')
            end
        end
    end
end

