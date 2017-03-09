.. _steno3dcorebinders:

Data Binders
============
 Adding data to resources in Steno3D

Steno3D uses data binders to bind :ref:`DataArrays <steno3dcoredataarray>` to :ref:`CompositeResources <steno3dcorecompositeresource>`.
Because of this, the "Data" property of a resource is a binder (or cell
array of binders). These binders each have two properties:

    :code:`Data`     - DataArray with title, description, array, etc.

    :code:`Location` - Geometry element to which data is bound, either 'N'
               (nodes) or 'CC' (cell-centers).

It is not necessary to construct binder objects explicitly; they can be
created implicitly using cell arrays as shown in the example below.

.. code::

    % Initialize a Steno3D Point resource
    myPoint = steno3d.core.Point;
    myPoint.Mesh = steno3d.core.Mesh0D('Vertices', rand(100, 3));
    randomData1 = steno3d.core.DataArray(                        ...
        'Title', 'Random Point Data',                            ...
        'Array', rand(100, 1)                                    ...
    );

    % Explicit data binder construction (NOT RECOMMENDED)
    myPoint.Data = steno3d.core.binders.PointBinder(             ...
        'Location', 'N', 'Data', randomData1                     ...
    );

    % Implicit data binder construction (RECOMMENDED)
    myPoint.Data = {'Location', 'N', 'Data', randomData1};

    % Adding multiple datasets to one resource
    randomData2 = steno3d.core.DataArray(                        ...
        'Title', 'More Random Point Data',                       ...
        'Array', rand(100, 1)                                    ...
    );
    randomData3 = steno3d.core.DataArray(                        ...
        'Title', 'Another Random Point Data',                    ...
        'Array', rand(100, 1)                                    ...
    );
    myPoint.Data = {                                             ...
        {'Location', 'N', 'Data', randomData1},                  ...
        {'Location', 'N', 'Data', randomData2},                  ...
        {'Location', 'N', 'Data', randomData3}                   ...
    };

**Binder types**:

 :class:`steno3d.core.binders.PointBinder`   - Bind data to nodes of a Steno3D :ref:`Point <steno3dcorepoint>`

 :class:`steno3d.core.binders.LineBinder`    - Bind data to segments or vertices of a Steno3D :ref:`Line <steno3dcoreline>`

 :class:`steno3d.core.binders.SurfaceBinder` - Bind data to faces or vertices of a Steno3D :ref:`Surface <steno3dcoresurface>`

 :class:`steno3d.core.binders.VolumeBinder`  - Bind data to cell centers of a Steno3D :ref:`Volume <steno3dcorevolume>`

For more examples see the DataArray :ref:`examples <steno3dexamplescoredata>`

See also :ref:`steno3d.core.DataArray <steno3dcoredataarray>`, :ref:`steno3d.addData <steno3dadddata>`


.. toctree::
    :maxdepth: 2
    :hidden:

    PointBinder
    LineBinder
    SurfaceBinder
    VolumeBinder
