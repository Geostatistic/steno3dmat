.. _contents:

STENO3DMAT
==========
 MATLAB Client for `Steno3D <https//steno3d.com>`_ by `ARANZ Geo Limited <https//www.aranzgeo.com>`_

Version 0.0.2

Use Steno3D to Analyze, Collaborate, and Present your MATLAB projects.

.. code::

    peaks; proj = steno3d.convert(gcf); proj.upload();

STENO3DMAT contains Steno3D, the Props package, as well as
installation, upgrade, and test scripts. Please follow the links below
for additional help.

.. note::

    Steno3D requires MATLAB R2014b or later 

**Included Packages**:

 :ref:`steno3d <steno3d>` - MATLAB client for Steno3D by ARANZ Geo Limited

 :ref:`props <props>`   - MATLAB package to build declarative, validated classes

**Installation, Upgrade, and Testing Scripts**:

 :func:`installSteno3D`   - Add Steno3D to the MATLAB environment

 :func:`upgradeSteno3D`   - Download and install the latest version of Steno3D

 :func:`uninstallSteno3D` - Remove Steno3D from the MATLAB environment

 :func:`testSteno3D`      - Test suite for Steno3D


.. toctree::
    :maxdepth: 2
    :hidden:

    steno3d/Contents
    props/Contents
    installSteno3D
    upgradeSteno3D
    uninstallSteno3D
    testSteno3D
