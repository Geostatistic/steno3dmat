function url = upload(handle, privacy)
% UPLOAD Upload a figure, axes, or Steno3D Project to <a href="matlab:
% web('https://steno3d.com/','-browser')">steno3d.com</a>
%   STENO3D.UPLOAD(HANDLE) uploads Steno3D Project HANDLE to steno3d.com.
%   If HANDLE is a figure or axes created by a Steno3D plotting function,
%   the corresponding Project is uploaded. (Note: The the current state of
%   the Project will be uploaded, including modifications that may not yet
%   be reflected in the figure. You may wish to call plot() on the project
%   prior to uploading to ensure all modifcations are correct.) If HANDLE
%   is a figure or axes handle unassociated with a Steno3D Project, the
%   figure or axes is converted to Steno3D using <a href="matlab:
%   help steno3d.convert">steno3d.convert</a> then
%   uploaded.
%
%   STENO3D.UPLOAD(HANDLE, PRIVACY) sets the privacy of the Steno3D
%   Project on steno3d.com, where PRIVACY is 'public' or 'private'. If
%   PRIVACY is not specified, the Public boolean property of the Project
%   HANDLE is used. If that is not available, the default is 'private'.
%
%   URL = STENO3D.UPLOAD(...) returns the URL of the uploaded project. URL
%   may also be a cell array of urls if multiple projects are uploaded
%   (for example, if a figure with multiple axes is converted to multiple
%   projects).
%
%   The privacy setting determines the project's visibility online. If it
%   is set to 'private', only you, the owner, can view it initially. View,
%   Edit, and Manage permissions can be granted through the web interface.
%   However, the number of private projects is limited on certain plans.
%   If the privacy is 'public', anyone can view the project on the public
%   <a href="matlab: web('https://steno3d.com/explore','-browser')
%   ">explore</a> page. More information about plans is available <a
%   href="matlab: web('https://steno3d.com/pricing','-browser')
%   ">online</a>.
%
%   Example:
%       myProj = steno3d.scatter(rand(100, 1), rand(100, 1), rand(100, 1));
%       myURL = STENO3D.UPLOAD(myProj, 'private');
%
%   See also STENO3D.CONVERT, STENO3D.CORE.PROJECT
%

    
    narginchk(1, 2)
    if nargin == 2
        if strcmpi(privacy, 'public')
            public = true;
        elseif strcmpi(privacy, 'private')
            public = false;
        else
            error('steno3d:uploadError', 'Invalid privacy setting');
        end
    end
    
    if ~steno3d.core.User.isLoggedIn()
        error('steno3d:uploadError',                                    ...
              'Please steno3d.login() before uploading');
    end
    
    if isa(handle, 'steno3d.core.Project')
        projs = handle;
    elseif isgraphics(handle) && isa(handle.UserData, 'steno3d.core.Project')
        projs = handle.UserData;
    else
        try
            projs = steno3d.convert(handle);
        catch
            error('steno3d:uploadError', ['Invalid upload input. Please'...
                  'give a figure, axes, or, Steno3D project.'])
        end
    end
    url = {};
    for i=1:length(projs)
        if nargin == 2
            projs(i).Public = public;
        end
        projurl = projs(i).upload();
        if length(proj) > 1
           url{end} = projurl;
        else
            url = projurl;
        end
    end
    
    

end