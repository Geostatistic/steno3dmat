.. _steno3dcoremesh2d:

Mesh2D
======

.. class:: steno3d.core.Mesh2D

Mesh for triangulated Steno3D Surface resources

This mesh provides the geometry for triangulated :ref:`Surface <steno3dcoresurface>` resources. It
consists of an m x 3 array of spatial vertices and an n x 3 array of
vertex indices to define the triangles. Triangle values must be between
1 and m. :code:`Mesh2D` has additional :ref:`options <steno3dcoreoptsmesh2doptions>` to customize the appearance of
the surface.

**Mesh2D** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Vertices** (:class:`props.Array`) - Spatial coordinates of surface vertices, Shape: {\*, 3}, DataType: float

    **Triangles** (:class:`props.Array`) - Vertex indices of surface triangles, Shape: {\*, 3}, DataType: int

**Optional Properties**:

    **Opts** (:class:`props.Instance`) - Options for the mesh, Class: :ref:`Mesh2DOptions <steno3dcoreoptsMesh2DOptions>`

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescoresurface>`

See also :ref:`steno3d.core.Surface <steno3dcoresurface>`, :ref:`steno3d.core.opts.Mesh2DOptions <steno3dcoreoptsmesh2doptions>`

