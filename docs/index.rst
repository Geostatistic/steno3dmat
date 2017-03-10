.. _index:

.. image:: https://raw.githubusercontent.com/3ptscience/steno3dpy/master/docs/images/steno3d_logo.png
    :width: 240
    :align: center
    :target: https://steno3d.com/
    :alt: Steno3D

.. image:: https://img.shields.io/badge/docs-latest-brightgreen.svg
    :alt: ReadTheDocs
    :target: http://steno3dmat.readthedocs.io/en/latest/

.. image:: https://img.shields.io/badge/license-MIT-blue.svg
    :alt: MIT License
    :target: https://github.com/3ptscience/steno3dmat/blob/master/LICENSE

Welcome to the MATLAB client library for `Steno3D <https://steno3d.com>`_
by `ARANZ Geo Limited <https://www.aranzgeo.com>`_. Explore and collaborate
on your 3D data!

Demo Video
----------

.. image:: https://img.youtube.com/vi/So1puiHry2o/0.jpg
    :target: https://www.youtube.com/watch?v=So1puiHry2o
    :alt: steno3dmat demo

Quickstart
----------

.. warning::

    This library is in PRE-RELEASE. Please submit any issues or feedback on
    `github <https://github.com/3ptscience/steno3dmat/issues>`_. There will very
    likely be backwards-incompatible changes as development continues. You can
    follow along with new releases on the `github release page <https://github.com/3ptscience/steno3dmat/releases>`_.

If you have not yet installed Steno3D for MATLAB, you can
`download the zip file <https://github.com/3ptscience/steno3dmat/releases/download/v0.0.3/steno3dmat.zip>`_
then in MATLAB:

.. code:: matlab

    cd Downloads/;
    unzip('steno3dmat.zip');
    cd steno3dmat;
    installSteno3D;

.. note::

    Steno3D requires MATLAB version R2014b or later.

You also need to `sign up for a Steno3D account <https://steno3d.com/signup>`_.
From there, you can `request a developer API key <https://steno3d.com/settings/developer>`_.

At that point, login and start uploading your MATLAB figures

.. code:: matlab

    steno3d.login;
    peaks;
    proj = steno3d.convert(gcf);
    proj.upload;

Function and API documentation is available from within MATLAB

.. code:: matlab

    help steno3d;

or `online <http://steno3dmat.readthedocs.io>`_.

If you run into problems or if you see a new `release on github <https://github.com/3ptscience/steno3dmat/releases>`_,
you can upgrade in MATLAB:

.. code:: matlab

    upgradeSteno3D;

If your problems persist, please submit an `issue <https://github.com/3ptscience/steno3dmat/issues>`_.

The latest version of Steno3D is 0.0.3. Detailed release notes are
`available on github <https://github.com/3ptscience/steno3dmat/releases>`_.

.. toctree::
    :maxdepth: 2

    steno3d/Contents
    props/Contents
    installSteno3D
    upgradeSteno3D
    uninstallSteno3D
    testSteno3D
