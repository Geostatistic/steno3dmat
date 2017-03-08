.. _steno3dcoreproject:

Project
=======

.. class:: steno3d.core.Project

Container of related Steno3D resources for plotting and uploading

Creating projects is the reason the Steno3D MATLAB toolbox exists. A
:code:`Project` contains one or more related :ref:`Point <steno3dcorepoint>`, :ref:`Line <steno3dcoreline>`, :ref:`Surface <steno3dcoresurface>`, or :ref:`Volume <steno3dcorevolume>`
resources. They can be created and edited using the high-level plotting
interface or the low-level command line interface.

Once a :code:`Project` is created, it can be plotted in MATLAB with the :code:`plot()`
function. This allows an initial visualization to verify the :code:`Project` is
constructed correctly. After the :code:`Project` is complete in MATLAB, it can
be uploaded to steno3d.com with the :code:`upload()` function. This validates
the :code:`Project`, checks user quotas, and uploads the :code:`Project`. The URL of
the uploaded :code:`Project` is returned and can also be accessed with the
:code:`url()` function.

**Project** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Public** (:class:`props.Bool`) - Public visibility on steno3d.com, Default: false

    **Resources** (:class:`props.Repeated`) - Composite resources the project contains, Type: props.Instance (Class: :ref:`CompositeResource <steno3dcoreCompositeResource>`)

**Optional Properties**:

    **Title** (:class:`props.String`) - Content title

    **Description** (:class:`props.String`) - Content description



See the :ref:`EXAMPLES <steno3dexamplescoreproject>`

See also :ref:`steno3d.core.CompositeResource <steno3dcorecompositeresource>`, :ref:`steno3d.core.UserContent <steno3dcoreusercontent>`

