.. _steno3dcoremesh3dgrid:

Mesh3DGrid
==========

.. class:: steno3d.core.Mesh3DGrid

Mesh for Steno3D Volume resources

This mesh provides the geometry for :ref:`Volume <steno3dcorevolume>` resources. It consists of x,
y, and z grid cell widths and an origin point. :code:`Mesh3DGrid` has
additional :ref:`options <steno3dcoreoptsmesh3doptions>` to customize the appearance of the volume.

**Mesh3DGrid** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **H1** (:class:`props.Array`) - Grid cell widths in the x-direction, Shape: {\*, 1}, DataType: float

    **H2** (:class:`props.Array`) - Grid cell widths in the y-direction, Shape: {\*, 1}, DataType: float

    **H3** (:class:`props.Array`) - Grid cell widths in the z-direction, Shape: {\*, 1}, DataType: float

    **O** (:class:`props.Vector`) - Origin point from which axes extend, Shape: {1, 3}, DataType: float, Default: [0 0 0]

**Optional Properties**:

    **Opts** (:class:`props.Instance`) - Options for the mesh, Class: :ref:`Mesh3DOptions <steno3dcoreoptsMesh3DOptions>`

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescorevolume>`

See also :ref:`steno3d.core.Volume <steno3dcorevolume>`, :ref:`steno3d.core.opts.Mesh3DOptions <steno3dcoreoptsmesh3doptions>`

