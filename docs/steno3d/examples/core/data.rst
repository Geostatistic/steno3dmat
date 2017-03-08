.. _steno3dexamplescoredata:

DataArray construction examples
===============================



Example 1: Create a :ref:`Point <steno3dcorepoint>` resource and add a :ref:`DataArray <steno3dcoredataarray>` with random data

.. code::

    pts = steno3d.core.Point;
    pts.Mesh = steno3d.core.Mesh0D;
    pts.Mesh.Vertices = rand(100, 3);
    dat = steno3d.core.DataArray;
    dat.Title = 'Random Point Data';
    dat.Array = rand(100, 1);
    pts.Data = {                                                 ...
        'Location', 'N',                                         ...
        'Data', dat                                              ...
    };
    example1 = steno3d.core.Project(                             ...
        'Title', 'Data: Example 1',                              ...
        'Resources', pts                                         ...
    );
    clear pts dat

Example 2: Create a :ref:`Surface <steno3dcoresurface>` and add node and cell-center DataArrays

.. code::

    sfc = steno3d.core.Surface;
    sfc.Mesh = steno3d.core.Mesh2DGrid;
    sfc.Mesh.H1 = ones(5, 1);
    sfc.Mesh.H2 = ones(10, 1);
    ccValues = rand(5, 10);
    datCC = steno3d.core.DataArray;
    datCC.Title = 'Random Cell-Centered Data';
    datCC.Array = ccValues(:);
    nValues = rand(6, 11);
    datN = steno3d.core.DataArray;
    datN.Title = 'Random Node Data';
    datN.Array = nValues(:);
    sfc.Data{1} = {                                              ...
        'Location', 'CC',                                        ...
        'Data', datCC                                            ...
    };
    sfc.Data{2} = {                                              ...
        'Location', 'N',                                         ...
        'Data', datN                                             ...
    };
    example2 = steno3d.core.Project(                             ...
        'Title', 'Data: Example 2',                              ...
        'Resources', sfc                                         ...
    );
    clear sfc datCC datN ccValues nValues


You can run the above examples with:

.. code::

    steno3d.examples.core.data

Then plot the projects with:

.. code::

    example1.plot(); % etc...



See also :ref:`steno3d.core.DataArray <steno3dcoredataarray>`, :ref:`steno3d.core.binders <steno3dcorebinders>`, :ref:`steno3d.core.Point <steno3dcorepoint>`, :ref:`steno3d.core.Mesh0D <steno3dcoremesh0d>`, :ref:`steno3d.core.Surface <steno3dcoresurface>`, :ref:`steno3d.core.Mesh2DGrid <steno3dcoremesh2dgrid>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

