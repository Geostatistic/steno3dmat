Steno3D
*******

.. image:: https://img.shields.io/badge/license-MIT-blue.svg
    :alt: MIT License
    :target: https://github.com/3ptscience/steno3dmat/blob/master/LICENSE

Welcome to the MATLAB client library for `Steno3D <https://steno3d.com>`_
by `ARANZ Geo Limited <https://www.aranzgeo.com>`_.

NOTE: This library is in PRE-RELEASE. Please submit any issues or feedback on
`github <https://github.com/3ptscience/steno3dmat/issues>`_. There will very
likely be backwards-incompatible changes as development continues. You can
follow along with new releases on the `github release page <https://github.com/3ptscience/steno3dmat/releases>`_.

If you have not yet installed Steno3D for MATLAB, you can
`download the zip file <https://github.com/3ptscience/steno3dmat/releases/download/v0.0.3/steno3dmat.zip>`_
then in MATLAB (R2014b or greater):

.. code:: matlab

    >> cd Downloads/
    >> unzip('steno3dmat.zip')
    >> cd steno3dmat
    >> installSteno3D

You also need to `sign up for a Steno3D account <https://steno3d.com/signup>`_.
From there, you can `request a developer API key <https://steno3d.com/settings/developer>`_.

At that point, you can

.. code:: matlab

    >> steno3d.login()

then start uploading your MATLAB figures. Function and API documentation is
available through the MATLAB help browser or at the command line with

.. code:: matlab

    >> help steno3d

and following the links from there.

If you run into problems or if you see a new release on `github <https://github.com/3ptscience/steno3dmat/releases>`_,
you can upgrade in MATLAB:

.. code:: matlab

    >> upgradeSteno3D

If your problems persist, please submit an `issue <https://github.com/3ptscience/steno3dmat/issues>`_.

The latest version of Steno3D is 0.0.3. Detailed release notes are available
on `github <https://github.com/3ptscience/steno3dmat/releases>`_.
