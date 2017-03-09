.. _installsteno3d:

installSteno3D
==============

.. function:: installSteno3D(...)

Add Steno3D to the MATLAB environment

:code:`installSteno3D()` copies steno3dmat to '~/.steno3d_client/' and adds
steno3d to the default MATLAB path.

:code:`installSteno3D(folder)` copies steno3dmat to :code:`folder` and adds steno3d to
the default MATLAB path.

.. note::

    Steno3D requires MATLAB R2014b or later 

.. code::

    % To install Steno3D to the standard toolbox location
    installSteno3D([matlabroot filesep 'toolbox'])

See also :ref:`upgradeSteno3D <upgradesteno3d>`, :ref:`uninstallSteno3D <uninstallsteno3d>`, :ref:`testSteno3D <teststeno3d>`
