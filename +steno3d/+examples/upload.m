%Steno3D upload examples
%
%   Example 1:
%       % Before uploading to steno3d.com you must login. With no
%       % parameters, login looks for a saved API key at the default
%       % location, ~/.steno3d_client/credentials, and prompts the user
%       % for one if none is found.
%       steno3d.login();
%
%       % Create a MATALB plot
%       figure; peaks;
%
%       % Upload the figure to steno3d.com. This will convert the figure
%       % (or axes) to a Project using steno3d.convert. By default, the
%       % uploaded Project will be private.
%       steno3d.upload(gcf);
%       close;
%
%       % When complete, you may log out of your MATLAB session.
%       steno3d.logout();
%
%   Example 2:
%       % Log in to steno3d.com. You can provide an API key at the
%       % command line. The SkipCredentials keyword prevents steno3d
%       % from saving the key to a file.
%       % Note: The key will exist in the MATLAB workspace and persist
%       % in the history.
%       steno3d.login(                                               ...
%              'username//12345678-xxxx-yyyy-zzzz-SOMEDEVELKEY',        ...
%              'SkipCredentials', true                                  ...
%          );
%
%       % Create a Steno3D Project
%       example2 = steno3d.scatter(rand(100, 3));
%
%       % Upload the Project as a public project. This project will be
%       % visible to everyone online.
%       steno3d.upload(example2, 'public');
%
%       steno3d.logout();
%
%   Example 3:
%       % Log in to steno3d.com. An alternative file to save credentials
%       % to may be specified with 'CredentialsFile'
%       steno3d.login('CredentialsFile', '~/Documents/steno3d_cred');
%
%       % Create a Steno3D Project
%       example3 = steno3d.scatter(rand(100, 3));
%
%       % Use the Project's upload function; privacy is set according to
%       % the Private property of the Project.
%       example3.upload();
%
%       steno3d.logout();
%
%   See also STENO3D.UPLOAD, STENO3D.LOGIN, STENO3D.LOGOUT,
%   STENO3D.CORE.PROJECT, STENO3D.SCATTER
