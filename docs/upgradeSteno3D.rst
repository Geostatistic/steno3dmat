.. _upgradesteno3d:

upgradeSteno3D
==============

.. function:: upgradeSteno3D(...)

Download and install the latest version of Steno3D

:code:`upgradeSteno3D()` checks for an existing Steno3D installation, downloads
the latest release of Steno3D to a temporary directory, tests the new
version of Steno3D, and if tests pass, replaces the old version.

On login, Steno3D checks if the current version is out of date. If so,
the user will be prompted to :code:`upgradeSteno3D()`

See also :ref:`steno3d.login <steno3dlogin>`, :ref:`uninstallSteno3D <uninstallsteno3d>`, :ref:`installSteno3D <installsteno3d>`, :ref:`testSteno3D <teststeno3d>`

