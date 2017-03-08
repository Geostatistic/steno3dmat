.. _steno3dlogin:

login
=====

.. function:: steno3d.login(...)

Log in to steno3d.com to allow Steno3D Project uploads

:code:`steno3d.login()` logs in to steno3d.com with the most recently saved API
key and adds steno3d to your MATLAB path if it is not already added.

:code:`steno3d.login(apikey)` logs in to steno3d.com with API key :code:`apikey`
requested by a Steno3D account holder from their `profile <https://steno3d.com/settings/developer>`_. APIKEY may
also be a username if the API key associated with that username is
saved.

:code:`steno3d.login(..., parameter, value)` logs in using the given
:code:`parameter`/:code:`value` pairs. Avaliable parameters are:

    **CredentialsFile**: string (default: '~/.steno3d_client/credentials')
        Path to file with saved API key. If a new API key is provided
        and the file does not yet exist, it will be created. Unless the
        default path is used, this will have to be provided on every
        login.
    **SkipCredentials**: true or false (default: false)
        If true, the API key will not be read from the CredentialsFile
        nor will it be saved. If false, the API key will be read from
        the CredentialsFile, and if a new API key is provided, it will
        be saved. Note: Even if SkipCredentials is true, the API key
        will be available in the current workspace and will persist in
        the MATLAB history. If you feel like your API key has become
        compromised you may delete it throuh your online `profile <https://steno3d.com/settings/developer>`_.

Logging in to steno3d is required to upload projects to steno3d.com. To
obtain an API developer key, you need a Steno3D account:

`https://steno3d.com/signup <https://steno3d.com/signup>`_

Then, you can request a devel key:

`https://steno3d.com/settings/developer <https://steno3d.com/settings/developer>`_

Unless you choose to 'SkipCredentials', your API key will be saved
locally and read next time you call :code:`steno3d.login()`. On login, Steno3D
also checks that its version is up to date. If it is not, the user will
be prompted to upgrade; an out of date version may or may not prevent a
successful login.

Example:

.. code::

    steno3d.login('username//12345678-xxxx-yyyy-zzzz-SOMEDEVELKEY', ...
                  'CredentialsFile', '~/Dropbox/steno3d_cred')
    peaks; steno3d.upload(gcf);


See more :ref:`EXAMPLES <steno3dexamplesupload>`

See also :ref:`steno3d.logout <steno3dlogout>`, :ref:`steno3d.upload <steno3dupload>`, :ref:`upgradeSteno3D <upgradesteno3d>`

