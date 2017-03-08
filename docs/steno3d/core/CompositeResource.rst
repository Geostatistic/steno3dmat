.. _steno3dcorecompositeresource:

CompositeResource
=================

.. class:: steno3d.core.CompositeResource

Abstract base class for Steno3D resources (Point, Line, etc)

Composite resources are the building blocks of Steno3D :ref:`Projects <steno3dcoreproject>`. They
include :ref:`Point <steno3dcorepoint>`, :ref:`Line <steno3dcoreline>`, :ref:`Surface <steno3dcoresurface>`, and :ref:`Volume <steno3dcorevolume>`. They all must have a mesh to
define their geometry. They may also have data bound to the mesh, image
textures, and options.

See also :ref:`steno3d.core.Point <steno3dcorepoint>`, :ref:`steno3d.core.Line <steno3dcoreline>`, :ref:`steno3d.core.Surface <steno3dcoresurface>`, :ref:`steno3d.core.Volume <steno3dcorevolume>`, :ref:`steno3d.core.UserContent <steno3dcoreusercontent>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

