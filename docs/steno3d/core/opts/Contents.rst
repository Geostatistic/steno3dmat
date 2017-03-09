.. _steno3dcoreopts:

Options
=======
 Adding options to resources in Steno3D

Most Steno3D objects have options to customize their appearance. These
are set with Options objects. See the specific Options type to see the
available options.

It is not necessary to construct options objects explicitly; they can
be created implicitly using cell arrays as shown in the example below.

.. code::

    % Initialize a Steno3D Surface resource
    mySurface = steno3d.core.Surface;
    mySurface.Mesh = steno3d.core.Mesh2DGrid(                    ...
        'H1', ones(10, 1),                                       ...
        'H2', ones(20, 1)                                        ...
    );

    % Explicit options construction (NOT RECOMMENDED)
    myPoint.Opts = steno3d.core.opts.PointOptions(               ...
        'Opacity', .75, 'Color', 'r'                             ...
    );
    myPoint.Mesh.Opts = steno3d.core.opts.Mesh2DOptions(         ...
        'Wireframe', true                                        ...
    );

    % Implicit data binder construction (RECOMMENDED)
    myPoint.Opts = {'Opacity', .75, 'Color', 'r'};
    myPoint.Mesh.Opts = {'Wireframe', true};

**Options Types**:

 :class:`steno3d.core.opts.PointOptions`   - Options for Steno3D :ref:`Point <steno3dcorepoint>`

 :class:`steno3d.core.opts.LineOptions`    - Options for Steno3D :ref:`Line <steno3dcoreline>`

 :class:`steno3d.core.opts.SurfaceOptions` - Options for Steno3D :ref:`Surface <steno3dcoresurface>`

 :class:`steno3d.core.opts.VolumeOptions`  - Options for Steno3D :ref:`Volume <steno3dcorevolume>`

 :class:`steno3d.core.opts.Mesh0DOptions`  - Options for Steno3D :ref:`Mesh0D <steno3dcoremesh0d>`

 :class:`steno3d.core.opts.Mesh1DOptions`  - Options for Steno3D :ref:`Mesh1D <steno3dcoremesh1d>`

 :class:`steno3d.core.opts.Mesh2DOptions`  - Options for Steno3D :ref:`Mesh2D <steno3dcoremesh2d>` and :ref:`Mesh2DGrid <steno3dcoremesh2dgrid>`

 :class:`steno3d.core.opts.Mesh3DOptions`  - Options for Steno3D :ref:`Mesh3DGrid <steno3dcoremesh3dgrid>`

 :class:`steno3d.core.opts.Options`        - Abstract base class for Steno3D options


.. toctree::
    :maxdepth: 2
    :hidden:

    PointOptions
    LineOptions
    SurfaceOptions
    VolumeOptions
    Mesh0DOptions
    Mesh1DOptions
    Mesh2DOptions
    Mesh3DOptions
    Options
