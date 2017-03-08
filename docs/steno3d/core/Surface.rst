.. _steno3dcoresurface:

Surface
=======

.. class:: steno3d.core.Surface

Low-level Steno3D Surface resource

Surfaces are 2D resources. Their geometry is defined by either a
triangulated :ref:`Mesh2D <steno3dcoremesh2d>` or a regularly gridded :ref:`Mesh2DGrid <steno3dcoremesh2dgrid>`. Mesh2D has
Vertices connected by Triangles; Mesh2DGrid has regular spacing defined
on two axes. Surfaces may have :ref:`Data <steno3dcoredataarray>` defined either on the vertices
(nodes) or the faces (cell-centers). There are several :ref:`surface options <steno3dcoreoptssurfaceoptions>`
and :ref:`mesh options <steno3dcoreoptsmesh2doptions>` available for customizing the appearance.

:code:`Surface` resources can also be created through a high-level functional
interface with :func:`steno3d.trisurf` (triangulated surface) or
:func:`steno3d.surface` (grid surface).

**Surface** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Mesh** (:class:`props.Union`) - Structure of the surface resource, Types: props.Instance (Class: :ref:`Mesh2D <steno3dcoreMesh2D>`), props.Instance (Class: :ref:`Mesh2DGrid <steno3dcoreMesh2DGrid>`)

**Optional Properties**:

    **Data** (:class:`props.Repeated`) - Data defined on the surface resource, Type: props.Instance (Class: :ref:`SurfaceBinder <steno3dcorebindersSurfaceBinder>`)

    **Textures** (:class:`props.Repeated`) - Images mapped to the surface resource, Type: props.Instance (Class: :ref:`Texture2DImage <steno3dcoreTexture2DImage>`)

    **Opts** (:class:`props.Instance`) - Options for the surface resource, Class: :ref:`SurfaceOptions <steno3dcoreoptsSurfaceOptions>`

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescoresurface>`

See also :ref:`steno3d.trisurf <steno3dtrisurf>`, :ref:`steno3d.surface <steno3dsurface>`, :ref:`steno3d.core.Mesh2D <steno3dcoremesh2d>`, :ref:`steno3d.core.Mesh2DGrid <steno3dcoremesh2dgrid>`, :ref:`steno3d.core.binders <steno3dcorebinders>`, :ref:`steno3d.core.opts.SurfaceOptions <steno3dcoreoptssurfaceoptions>`, :ref:`steno3d.core.CompositeResource <steno3dcorecompositeresource>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

