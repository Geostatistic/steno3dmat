.. _steno3dcoremesh0d:

Mesh0D
======

.. class:: steno3d.core.Mesh0D

Mesh for Steno3D Point resources

This mesh provides the geometry for :ref:`Point <steno3dcorepoint>` resources, an n x 3 array of
spatial coordinates where n is the number of points. There are
currently no additional options available for this mesh.

**Mesh0D** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Vertices** (:class:`props.Array`) - Spatial coordinates of points, Shape: {\*, 3}, DataType: float

**Optional Properties**:

    **Opts** (:class:`props.Instance`) - Options for the mesh, Class: :ref:`Mesh0DOptions <steno3dcoreoptsMesh0DOptions>`

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescorepoint>`

See also :ref:`steno3d.core.Point <steno3dcorepoint>`, :ref:`steno3d.core.opts.Mesh0DOptions <steno3dcoreoptsmesh0doptions>`

