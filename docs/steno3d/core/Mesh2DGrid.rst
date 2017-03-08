.. _steno3dcoremesh2dgrid:

Mesh2DGrid
==========

.. class:: steno3d.core.Mesh2DGrid

Mesh for gridded Steno3D Surface resources

This mesh provides the geometry for gridded :ref:`Surface <steno3dcoresurface>` resources. The grid
cell widths are given by two arrays H1 and H2. By default, these
correspond to the x- and y-direction, respectively, and the surface
exists as a horizontal plane. However, alternative U- and V-axis
vectors can be defined to orient the plane in any direction.

In addition to setting the axes, the :code:`Mesh2DGrid` can be given any origin
point and can have node topography perpendicular to the surface (in the
U-cross-V direction, z-direction by default). :code:`Mesh2DGrid` has additional
:ref:`options <steno3dcoreoptsmesh2doptions>` to customize the appearance of the surface.

**Mesh2DGrid** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **H1** (:class:`props.Array`) - Grid cell widths in the U-direction, Shape: {\*, 1}, DataType: float

    **H2** (:class:`props.Array`) - Grid cell widths in the V-direction, Shape: {\*, 1}, DataType: float

    **O** (:class:`props.Vector`) - Origin point from which H1- and H2-axes extend, Shape: {1, 3}, DataType: float, Default: [0 0 0]

    **U** (:class:`props.Vector`) - Orientation of H1 axis, Shape: {1, 3}, DataType: float, Default: [1 0 0]

    **V** (:class:`props.Vector`) - Orientation of H2 axis, Shape: {1, 3}, DataType: float, Default: [0 1 0]

    **ZOrder** (:class:`props.String`) - Array ordering of Z, Choices: c, f, Default: 'f'

**Optional Properties**:

    **Z** (:class:`props.Array`) - Node topography perpendicular to the surface, Shape: {\*, 1}, DataType: float

    **Opts** (:class:`props.Instance`) - Options for the mesh, Class: :ref:`Mesh2DOptions <steno3dcoreoptsMesh2DOptions>`

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the 
See also :ref:`steno3d.core.Surface <steno3dcoresurface>`, :ref:`steno3d.core.opts.Mesh2DOptions <steno3dcoreoptsmesh2doptions>`

