.. _steno3dcorepoint:

Point
=====

.. class:: steno3d.core.Point

Low-level Steno3D Point resource

Points are 0D resources. Their geometry is defined by a :ref:`Mesh0D <steno3dcoremesh0d>` with
Vertices. They may have :ref:`Data <steno3dcoredataarray>` defined on the vertices (nodes). There are
several :ref:`point options <steno3dcoreoptspointoptions>` available for customizing the appearance.

:code:`Point` resources can also be created through a high-level functional
interface with :func:`steno3d.scatter`.

**Point** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Mesh** (:class:`props.Instance`) - Structure of the point resource, Class: :ref:`Mesh0D <steno3dcoreMesh0D>`

**Optional Properties**:

    **Data** (:class:`props.Repeated`) - Data defined on the point resource, Type: props.Instance (Class: :ref:`PointBinder <steno3dcorebindersPointBinder>`)

    **Textures** (:class:`props.Repeated`) - Images mapped to the point resource, Type: props.Instance (Class: :ref:`Texture2DImage <steno3dcoreTexture2DImage>`)

    **Opts** (:class:`props.Instance`) - Options for the point resource, Class: :ref:`PointOptions <steno3dcoreoptsPointOptions>`

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescorepoint>`

See also :ref:`steno3d.scatter <steno3dscatter>`, :ref:`steno3d.core.Mesh0D <steno3dcoremesh0d>`, :ref:`steno3d.core.binders <steno3dcorebinders>`, :ref:`steno3d.core.opts.PointOptions <steno3dcoreoptspointoptions>`, :ref:`steno3d.core.CompositeResource <steno3dcorecompositeresource>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

