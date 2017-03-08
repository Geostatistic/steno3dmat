.. _steno3dcoretexture2dimage:

Texture2DImage
==============

.. class:: steno3d.core.Texture2DImage

Steno3D object to hold images and mapping to resources

Image textures are used to map data to a Steno3D resource in space
without requiring an array that corresponds to geometry. Images must be
PNG files (or MATLAB matrices that can be written as PNGs with
:code:`imwrite`). In addion to the image, :code:`Texture2DImage` contains spatial
location given by axes vectors U and V extending from an origin point.

The image is mapped on to the resource by projecting it out of the
plane defined by the origin, U, and V, in a U-cross-V direction. Only
:ref:`Points <steno3dcorepoint>` and :ref:`Surfaces <steno3dcoresurface>` support :code:`Texture2DImage`; Lines and Volumes do not.

A :code:`Texture2DImage` can also be added to a resource through a high-level
functional interface with :func:`steno3d.addImage`. The function
:func:`steno3d.surface` also allows creation of a surface with an image.

**Texture2DImage** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **U** (:class:`props.Vector`) - Vector corresponding to the image x-axis, Shape: {1, 3}, DataType: float, Default: [1 0 0]

    **V** (:class:`props.Vector`) - Vector corresponding to the image y-axis, Shape: {1, 3}, DataType: float, Default: [0 1 0]

    **O** (:class:`props.Vector`) - Origin point from which U- and V-axes extend, Shape: {1, 3}, DataType: float, Default: [0 0 0]

    **Image** (:class:`props.Image`) - PNG image file

**Optional Properties**:

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescoretexture>`

See also :ref:`steno3d.addImage <steno3daddimage>`, :ref:`steno3d.surface <steno3dsurface>`, :ref:`steno3d.core.Point <steno3dcorepoint>`, :ref:`steno3d.core.Surface <steno3dcoresurface>`, :ref:`steno3d.core.DataArray <steno3dcoredataarray>`

