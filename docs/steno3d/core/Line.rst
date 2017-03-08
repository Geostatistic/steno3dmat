.. _steno3dcoreline:

Line
====

.. class:: steno3d.core.Line

Low-level Steno3D Line resource

Lines are 1D resources. Their geometry is defined by a :ref:`Mesh1D <steno3dcoremesh1d>` as
Vertices and connecting Segments. They may have :ref:`Data <steno3dcoredataarray>` that is either
defined on the vertices (nodes) or the segments (cell-centers). There
are several :ref:`line options <steno3dcoreoptslineoptions>` and :ref:`mesh options <steno3dcoreoptsmesh1doptions>` available for customizing the
appearance.

:code:`Line` resources can also be created through a high-level functional
interface with :func:`steno3d.line`.

**Line** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Mesh** (:class:`props.Instance`) - Structure of the line resource, Class: :ref:`Mesh1D <steno3dcoreMesh1D>`

**Optional Properties**:

    **Data** (:class:`props.Repeated`) - Data defined on the line resource, Type: props.Instance (Class: :ref:`LineBinder <steno3dcorebindersLineBinder>`)

    **Opts** (:class:`props.Instance`) - Options for the line resource, Class: :ref:`LineOptions <steno3dcoreoptsLineOptions>`

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescoreline>`

See also :ref:`steno3d.line <steno3dline>`, :ref:`steno3d.core.Mesh1D <steno3dcoremesh1d>`, :ref:`steno3d.core.binders <steno3dcorebinders>`, :ref:`steno3d.core.opts.LineOptions <steno3dcoreoptslineoptions>`, :ref:`steno3d.core.CompositeResource <steno3dcorecompositeresource>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

