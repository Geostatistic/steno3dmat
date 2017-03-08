.. _steno3dtrisurf:

trisurf
=======

.. function:: steno3d.trisurf(...)

Create and plot a triangulated Steno3D Surface resource

:code:`steno3d.trisurf(triangles, X, Y, Z)` creates a Steno3D Project with a
Surface resource of triangulated faces. The surface is defined by
:code:`triangles`, n x 3 matrix of vertex indices, and :code:`X`, :code:`Y`, and :code:`Z`, equal-sized
vectors of vertex coordinates.

:code:`steno3d.trisurf(triangles, vertices)` creates a Steno3D Project with a
Surface resource defined by :code:`triangles`, n x 3 matrix of vertex indices,
and :code:`vertices`, m x 3 matrix of spatial coordinates.

:code:`steno3d.trisurf(..., color)` creates a Surface resource of the given
color, where :code:`color` is a 1x3 RGB color, hex color string, named color
string, or 'random'.

:code:`steno3d.trisurf(..., title1, data1, ..., titleN, dataN)` adds any number
of titled datasets to the Surface resource. :code:`title` must be a string and
:code:`data` must be an n x 1 or an m x 1 vector, where n is the number of
triangles and m is the number of vertices. If m == n, the data location
will default to triangles (to override this see :func:`steno3d.addData`).

:code:`steno3d.trisurf(project, ...)` adds the Surface resource to :code:`project`, an
existing Steno3D Project. :code:`project` may also be a figure or axes handle
that was created by a Steno3D plotting function.

:code:`project = steno3d.trisurf(...)` returns :code:`project`, the Steno3D Project that
contains the new Surface resource.

:code:`[project, SURFACE] = steno3d.trisurf(...)` returns :code:`project`, the Steno3D
Project, and :code:`SURFACE`, the new Surface resource.

:code:`steno3d.trisurf` is useful in conjunction with MATLAB triangulation
functions like :code:`convhull`. Unlike the MATLAB builtin :code:`trisurf`,
:code:`steno3d.trisurf` does not currently support triangulation objects, nor
does it support any additional property/value pairs. After creating a
Surface resource with :code:`steno3d.trisurf`, properties of the Surface object
can be directly modified.

Example:

.. code::

    x = [0 1 0 0]; y = [0 0 1 0]; z = [0 0 0 1];
    tris = convhull(x, y, z);
    [myProject, mySurface] = steno3d.trisurf(                       ...
        tris, x, y, z, 'r', 'Face Data', rand(4, 1)                 ...
    );
    mySurface.Title = 'Triangulated Surface';
    mySurface.Description = 'Convex hull triangles';
    myProject.Title = 'Project with one Surface';
    myProject.Public = true;
    steno3d.upload(myProject);


See more :ref:`EXAMPLES <steno3dexamplestrisurf>`

See also :ref:`steno3d.core.Surface <steno3dcoresurface>`, :ref:`steno3d.upload <steno3dupload>`, :ref:`steno3d.addData <steno3dadddata>`, :ref:`steno3d.addImage <steno3daddimage>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

