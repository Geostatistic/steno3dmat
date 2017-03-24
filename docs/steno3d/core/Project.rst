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



**Available Methods**:

* **upload**:

    :code:`p.upload()` validates and uploads to steno3d.com the project or
    array of projects :code:`p`.

    :code:`url = p.upload()` returns the :code:`url` or URLs of the uploaded
    project(s).

* **url**:

    :code:`url = p.url()` returns the :code:`url` of an uploaded project :code:`p` or cell
    array of URLs if :code:`p` is an array of projects. This method raises
    an error if a project isn't uploaded.

* **plot**:

    :code:`p.plot()` plots the project :code:`p` in a new figure window. If :code:`p` is
    an array of multiple projects, each is plotted in a new
    window.

    :code:`p.plot(ax)` plots the project(s) :code:`p` in an existing axes :code:`ax`.

    :code:`ax = p.plot(...)` returns :code:`ax`, the axes handle of the plot or a
    cell array of axes handles if :code:`p` is an array of multiple projects.

    It is recommended to call :code:`plot` with no arguments (not provide
    :code:`ax` ). This prevents loss of graphics objects unrelated to the
    project and ensures that uploading the axes will correctly
    upload the project.

See the :ref:`EXAMPLES <steno3dexamplescoreproject>`

See also :ref:`steno3d.core.CompositeResource <steno3dcorecompositeresource>`, :ref:`steno3d.core.UserContent <steno3dcoreusercontent>`

