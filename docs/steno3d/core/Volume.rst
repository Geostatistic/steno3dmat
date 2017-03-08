.. _steno3dcorevolume:

Volume
======

.. class:: steno3d.core.Volume

Low-level Steno3D Volume resource

Volumes are 3D resources. Their geometry is defined by a :ref:`Mesh3DGrid <steno3dcoremesh3dgrid>`
with regularly spaced x-, y-, and z-axes. Volumes may have :ref:`Data <steno3dcoredataarray>` defined
on the cell-centers. There are several :ref:`volume options <steno3dcoreoptsvolumeoptions>` and
:ref:`mesh options <steno3dcoreoptsmesh3doptions>` available for customizing the appearance.

:code:`Volume` resources can also be created through a high-level functional
interface with :ref:`steno3d.volume <steno3dvolume>`.

**Volume** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Mesh** (:class:`props.Instance`) - Structure of the volume resource, Class: :ref:`Mesh3DGrid <steno3dcoreMesh3DGrid>`

    **Data** (:class:`props.Repeated`) - Data defined on the volume resource, Type: props.Instance (Class: :ref:`VolumeBinder <steno3dcorebindersVolumeBinder>`)

**Optional Properties**:

    **Opts** (:class:`props.Instance`) - Options for the volume resource, Class: :ref:`VolumeOptions <steno3dcoreoptsVolumeOptions>`

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescorevolume>`

See also :ref:`steno3d.volume <steno3dvolume>`, :ref:`steno3d.core.Mesh3DGrid <steno3dcoremesh3dgrid>`, :ref:`steno3d.core.binders <steno3dcorebinders>`, :ref:`steno3d.core.opts.VolumeOptions <steno3dcoreoptsvolumeoptions>`, :ref:`steno3d.core.CompositeResource <steno3dcorecompositeresource>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

