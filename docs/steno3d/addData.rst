.. _steno3dadddata:

addData
=======

.. function:: steno3d.addData(...)

Add a dataset to an existing Steno3d resource

:code:`steno3d.addData(resource, data)` adds matrix or vector :code:`data` to the
Steno3D :code:`resource` (:ref:`Point <steno3dcorepoint>`, :ref:`Line <steno3dcoreline>`, :ref:`Surface <steno3dcoresurface>`, or :ref:`Volume <steno3dcorevolume>`). This function first
attempts to assign :code:`data` to cell centers then to nodes. If the length of
the data does not match either of these, this function errors.

:code:`steno3d.addData(resource, title, data)` adds :code:`data` to the :code:`resource` with a
given :code:`title` string.

Example:

.. code::

    x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
    tris = convhull(x, y, z);
    [proj, sfc] = steno3d.trisurf(tris, x, y, z, 'r');
    steno3d.addData(sfc, 'Cell Center Data', rand(4, 1));

.. note::

    If the number of cell centers matches the number of nodes (as is
    the case in the example above), this function will default to locating
    data on cell centers. However, this can be changed programatically:

    .. code::

        mySurface.Data{end}.Location = 'N';

    and change the title accordingly:

    .. code::

        mySurface.Data{end}.Data.Title = 'Node Data';

See more :ref:`EXAMPLES <steno3dexamplesadddata>`

See also :ref:`steno3d.core.DataArray <steno3dcoredataarray>`, :ref:`steno3d.addImage <steno3daddimage>`, :ref:`steno3d.trisurf <steno3dtrisurf>`

