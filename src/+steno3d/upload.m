function url = upload(handle, privacy)
% UPLOAD Upload a figure, axes, or Steno3D Project to %%%link[steno3d.com](https://steno3d.com/)
%   `steno3d.upload(handle)` uploads Steno3D %%%ref[Project](steno3d.core.Project) `handle` to steno3d.com.
%   If `handle` is a figure or axes created by a Steno3D plotting function,
%   the corresponding Project is uploaded. (Note: The the current state of
%   the Project will be uploaded, including modifications that may not yet
%   be reflected in the figure. You may wish to call `plot()` on the project
%   prior to uploading to ensure all modifications are correct.) If `handle`
%   is a figure or axes handle unassociated with a Steno3D Project, the
%   figure or axes is converted to Steno3D using %%%func[steno3d.convert](steno3d.convert) then
%   uploaded.
%
%   `steno3d.upload(handle, privacy)` sets the privacy of the Steno3D
%   Project on steno3d.com, where `privacy` is 'public' or 'private'. If
%   `privacy` is not specified, the Public boolean property of the Project
%   `handle` is used. If that is not available, the default is 'private'.
%
%   `url = steno3d.upload(...)` returns the `url` of the uploaded project. `url`
%   may also be a cell array of urls if multiple projects are uploaded
%   (for example, if a figure with multiple axes is converted to multiple
%   projects).
%
%   The privacy setting determines the project's visibility online. If it
%   is set to 'private', only you, the owner, can view it initially. View,
%   Edit, and Manage permissions can be granted through the web interface.
%   However, the number of private projects is limited on certain plans.
%   If the privacy is 'public', anyone can view the project on the public
%   %%%link[explore](https://steno3d.com/explore) page. More information about plans is available %%%link[online](https://steno3d.com/pricing).
%
%   Example:
%   %%%codeblock
%       steno3d.login();
%       peaks; proj = steno3d.convert(gcf);
%       url = steno3d.upload(proj, 'private');
%       steno3d.logout();
%
%
%   See more %%%ref[EXAMPLES](steno3d.examples.upload)
%
%   %%%seealso STENO3D.CONVERT, STENO3D.CORE.PROJECT, STENO3D.LOGIN,
%   STENO3D.LOGOUT
%


    steno3d.utils.matverchk();
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
    if ~steno3d.utils.User.isLoggedIn()
        error('steno3d:uploadError',                                    ...
              'Please steno3d.login() before uploading');
    end
    if isa(handle, 'steno3d.core.Project')
        projs = handle;
    elseif length(handle) == 1 && isgraphics(handle) &&                 ...
            isa(handle.UserData, 'steno3d.core.Project')
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
        if length(projs) > 1
           url{end} = projurl;
        else
            url = projurl;
        end
    end
end
