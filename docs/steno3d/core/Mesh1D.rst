.. _steno3dcoremesh1d:

Mesh1D
======

.. class:: steno3d.core.Mesh1D

Mesh for Steno3D Line resources

This mesh provides the geometry for :ref:`Line <steno3dcoreline>` resources. It consists of an
m x 3 array of spatial vertices and an n x 2 array of vertex indices to
define the line segments. Segment values must be between 1 and m.
:code:`Mesh1D` has additional :ref:`options <steno3dcoreoptsmesh1doptions>` to customize the appearance of the line.

**Mesh1D** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Vertices** (:class:`props.Array`) - Spatial coordinates of line vertices, Shape: {\*, 3}, DataType: float

    **Segments** (:class:`props.Array`) - Endpoint vertex indices of line segments, Shape: {\*, 2}, DataType: int

**Optional Properties**:

    **Opts** (:class:`props.Instance`) - Options for the mesh, Class: :ref:`Mesh1DOptions <steno3dcoreoptsMesh1DOptions>`

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescoreline>`

See also :ref:`steno3d.core.Line <steno3dcoreline>`, :ref:`steno3d.core.opts.Mesh1DOptions <steno3dcoreoptsmesh1doptions>`

