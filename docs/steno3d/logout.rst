.. _steno3dlogout:

logout
======

.. function:: steno3d.logout(...)

Log out of current session on steno3d.com

:code:`steno3d.logout()` logs user out of their current session with
steno3d.com, deletes current user data from the workspace, and removes
steno3d from the path if it is not on the default path by default.
Note: Although user data is deleted, the API key may remain in MATLAB
history. If you feel like your API key has become compromised you may
delete it through your online `profile <https://steno3d.com/settings/developer>`_.

Example:

.. code::

    steno3d.login();
    peaks; steno3d.upload(gcf);
    steno3d.logout();


See more :ref:`EXAMPLES <steno3dexamplesupload>`

See also :ref:`steno3d.login <steno3dlogin>`, :ref:`steno3d.upload <steno3dupload>`, :ref:`upgradeSteno3D <upgradesteno3d>`, :ref:`uninstallSteno3D <uninstallsteno3d>`

