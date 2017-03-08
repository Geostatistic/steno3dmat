.. _steno3dline:

line
====

.. function:: steno3d.line(...)

Create and plot a Steno3D Line resource

:code:`steno3d.line(X, Y, Z)` creates a Steno3D :ref:`Project <steno3dcoreproject>` with a :ref:`Line <steno3dcoreline>` resource
defined by vectors :code:`X`, :code:`Y`, and :code:`Z`. If :code:`X`, :code:`Y`, and :code:`Z` are matrices of the same
size, only one Line resource is created but separate columns are
disconnected.

:code:`steno3d.line(segments, vertices)` creates a Steno3D Project with a Line
resource defined by :code:`segments`, n x 2 matrix of vertex indices, and
:code:`vertices`, m x 3 matrix of spatial coordinates.

:code:`steno3d.line(..., color)` creates a Line resource of the given color,
where :code:`color` is a 1x3 RGB color, hex color string, named color string,
or 'random'.

:code:`steno3d.line(..., title1, data1, ..., titleN, dataN)` adds any number of
titled datasets to the Line resource. :code:`title` must be a string and :code:`data`
must be an n x 1 or an m x 1 vector, where n is the number of segments
and m is the number of vertices. If m == n, the data location will
default to segments. Data may also be added with :func:`steno3d.addData`.

:code:`steno3d.line(project, ...)` adds the Line resource to :code:`project,` an
existing Steno3D Project. :code:`project` may also be a figure or axes handle
that was created by a Steno3D plotting function.

:code:`project = steno3d.line(...)` returns :code:`project`, the Steno3D Project that
contains the new Line resource.

:code:`[project, line] = steno3d.line(...)` returns :code:`project`, the Steno3D
Project, and :code:`line`, the new Line resource.

Unlike the MATLAB builtin :code:`line` function, :code:`steno3d.line` requires 3D data
and does not support any additional property/value pairs. After
creating a Line resource with :code:`steno3d.line`, properties of the Line
object can be directly modified.

Example:

.. code::

    x = 0:pi/10:4*pi;
    [proj, lin] = steno3d.line(                                     ...
        x, cos(x), sin(x), 'k', 'Cosine Vert Data', cos(x)          ...
    );
    lin.Title = 'Example Line';
    lin.Description = 'Trig functions with random data';
    proj.Title = 'Project with one Line';
    proj.upload()


See more :ref:`EXAMPLES <steno3dexamplesline>`

See also :ref:`steno3d.core.Line <steno3dcoreline>`, :ref:`steno3d.upload <steno3dupload>`, :ref:`steno3d.addData <steno3dadddata>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

