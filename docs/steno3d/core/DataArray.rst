.. _steno3dcoredataarray:

DataArray
=========

.. class:: steno3d.core.DataArray

Steno3D object to hold resource data

Data is stored as an array. It is bound to a :ref:`composite resource <steno3dcorecompositeresource>` using a
data :ref:`binder <steno3dcorebinders>` cell array. The length of the Array must correspond to the
specified mesh geometry location (nodes or cell centers). For some
types of meshes, this is straightforward (e.g. using :ref:`Mesh0D <steno3dcoremesh0d>` the Array
must be equal in length to the Vertices). For gridded meshes
(:ref:`Mesh2DGrid <steno3dcoremesh2dgrid>`, :ref:`Mesh3DGrid <steno3dcoremesh3dgrid>`), the Array must be unwrapped in the correct
order. By default, if you have a matrix of the correct shape
[X-length, Y-length(, Z-length)], flattening with matrix(:) gives the
correct order.

A :code:`DataArray` can also be added to a resource through a high-level
functional interface with :func:`steno3d.addData`.

**DataArray** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Array** (:class:`props.Array`) - Data corresponding to geometry of the mesh, Shape: {\*, 1}, DataType: float

    **Order** (:class:`props.String`) - Data array order, for data on grid meshes, Choices: c, f, Default: 'f'

**Optional Properties**:

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescoredata>`

See also :ref:`steno3d.addData <steno3dadddata>`, :ref:`steno3d.core.binders <steno3dcorebinders>`, :ref:`steno3d.core.CompositeResource <steno3dcorecompositeresource>`, :ref:`steno3d.core.Texture2DImage <steno3dcoretexture2dimage>`

