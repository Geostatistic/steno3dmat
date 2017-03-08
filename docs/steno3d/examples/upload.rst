.. _steno3dexamplesupload:

upload examples
===============



Example 1: :ref:`Log in <steno3dlogin>`, implictly convert a figure, and :ref:`upload <steno3dupload>` as private

.. code::

                    steno3d.login();
    figure; peaks;
                steno3d.upload(gcf);
    close;
        steno3d.logout();

Example 2: Log in without saving credentials, upload a :ref:`Project <steno3dcoreproject>`

.. code::

                        steno3d.login(                                               ...
        'username//12345678-xxxx-yyyy-zzzz-SOMEDEVELKEY',        ...
        'SkipCredentials', true                                  ...
    );
    example2 = steno3d.scatter(rand(100, 3));
            steno3d.upload(example2, 'public');
    steno3d.logout();

Example 3: Log in with saved credentials, use Project upload function

.. code::

            steno3d.login('CredentialsFile', '~/Documents/steno3d_cred');
    example3 = steno3d.scatter(rand(100, 3));
            example3.upload();
    steno3d.logout();

See also :ref:`steno3d.upload <steno3dupload>`, :ref:`steno3d.login <steno3dlogin>`, :ref:`steno3d.logout <steno3dlogout>`, :ref:`steno3d.core.Project <steno3dcoreproject>`, :ref:`steno3d.scatter <steno3dscatter>`

