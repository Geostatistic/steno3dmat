.. _steno3dscatter:

scatter
=======

.. function:: steno3d.scatter(...)

Create and plot a Steno3D Point resource

:code:`steno3d.scatter(XYZ)` creates a Steno3D Project with a Point resource
defined by n x 3 matrix :code:`XYZ`.

:code:`steno3d.scatter(X, Y, Z)` creates a Steno3D Project with a Point
resource defined by equal-sized vectors or matrices :code:`X`, :code:`Y`, and :code:`Z`.

:code:`steno3d.scatter(..., color)` creates a Point resource of the give color,
where :code:`color` is a 1x3 RGB color, hex color string, named color string,
or 'random'.

:code:`steno3d.scatter(..., title1, data1, ..., titleN, dataN)` adds any number
of titled datasets to the Point resource. :code:`title` must be a string and
:code:`data` must be an matrix or vector that, when flattened, is length n,
where n is the number of points. (For more details see :func:`steno3d.addData`)

:code:`steno3d.scatter(project, ...)` adds the Point resource to :code:`project`, an
existing Steno3D Project. :code:`project` may also be a figure or axes handle
that was created by a Steno3D plotting function

:code:`project = steno3d.scatter(...)` returns :code:`project`, the Steno3D Project
that contains the new Point resource.

:code:`[project, points] = steno3d.scatter(...)` returns :code:`project`, the Steno3D
Project, and :code:`points`, the new Point resource.

:code:`steno3d.scatter` is more similar to the MATLAB builtin function :code:`scatter3`
than the builtin function :code:`scatter` since it requres a 3D dataset.
Unlike the builtin functions, :code:`steno3d.scatter` does not support any
additional property/value pairs. After creating a Point resource with
:code:`steno3d.scatter`, properties for the Point object can be directly
modified.

Example:

.. code::

    x = 0:pi/10:4*pi;
    [myProject, myPoints] = steno3d.scatter(                        ...
        [x(:) cos(x(:)+0.2) sin(x(:))], [0 .5 .5],                  ...
        'Random Data', rand(size(x))                                ...
    );
    myPoints.Title = 'Example Points';
    myPoints.Description = 'Trig functions with random data';
    myProject.Title = 'Project with one set of Points';
    myProject.Public = true;
    steno3d.upload(myProject);


See more :ref:`EXAMPLES <steno3dexamplesscatter>`

See also :ref:`steno3d.core.Point <steno3dcorepoint>`, :ref:`steno3d.upload <steno3dupload>`, :ref:`steno3d.addData <steno3dadddata>`, :ref:`steno3d.addImage <steno3daddimage>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

