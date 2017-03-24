.. _steno3dsurface:

surface
=======

.. function:: steno3d.surface(...)

Create and plot a gridded Steno3D Surface resource

:code:`steno3d.surface(Z)` creates a Steno3D Project with a Surface grid
resource. Heights are defined by :code:`Z`, an m x n matrix. Values are plotted
with unit spacing, where x and y values equal 0:m-1 and 0:n-1,
respectively.

:code:`steno3d.surface(origin, Z)` creates a Steno3D Project with a Surface
resource. :code:`origin` is a 1 x 3 vector offset; x and y values correspond to
origin(1) + (0:m-1) and origin(2) + (0:n-1), and heights equal to
:code:`Z` + origin(3).

:code:`steno3d.surface(X, Y)` creates a Steno3D Project with a flat grid
Surface in the horizontal plane with x and y node values corresponding
to vectors :code:`X` and :code:`Y`, respectively.

:code:`steno3d.surface(dir1, h1, dir2, h2, origin)` creates a Steno3D Project
with a flat grid Surface in an arbitrary plane. The plane is defined by
1 x 3 axes vectors, :code:`dir1` and :code:`dir2`, node locations along those axes, :code:`h1`
and :code:`h2`, and a 1 x 3 :code:`origin` vector. :code:`dir1` and :code:`dir2` may also be 'X', 'Y',
or 'Z' in addition to 1 x 3 axes. For example, the following all
produce the same result:

.. code::

    steno3d.surface(0:10, 0:20)
    steno3d.surface([1 0 0], 0:10, [0 1 0], 0:20, [0 0 0])
    steno3d.surface('X', 0:10, 'Y', 0:20, [0 0 0])

:code:`steno3d.surface(..., Z)` creates a Steno3D Project and Surface grid with
node heights :code:`Z`, an n x m matrix, where m is the length of :code:`X` or :code:`h1` and
n is the length of :code:`Y` or :code:`h2`. :code:`Z` may also be a length m*n vector.

:code:`steno3d.surface(..., color)` creates a Surface resource of the given
color, where :code:`color` is a 1x3 RGB color, hex color string, named color
string, or 'random'.

:code:`steno3d.surface(..., title1, data1, ..., titleN, dataN)` adds any number
of titled datasets to the Surface resource. :code:`title` must be a string and
:code:`data` must be a matrix of size m x n or m*n x 1 for node data or a
matrix of size (m-1) x (n-1) or (m-1)*(n-1) x 1 for face data, where n
is the length(`X:code:`), length(`h1:code:`), or size(`Z:code:`, 1) and m is the length(`Y`),
length(`h2:code:`), or size(`Z`, 2). (For more details see :func:`steno3d.addData`)

:code:`steno3d.surface(..., title1, png1, ..., titleN, pngN)` adds any number
of titled images to the Surface resource. :code:`title` must be a string and
:code:`png` must be a png file. The image will be stretched to span the
entire grid surface. Any number of datasets and textures may be applied
to an individual Surface. (For more details see :func:`steno3d.addImage`)

:code:`steno3d.surface(project, ...)` adds the Surface resource to :code:`project`, an
existing Steno3D Project. :code:`project` may also be a figure or axes handle
that was created by a Steno3D plotting function.

:code:`project = steno3d.surface(...)` returns :code:`project`, the Steno3D Project
that contains the new Surface resource.

:code:`[project, surface] = steno3d.surface(...)` returns :code:`project`, the Steno3D
Project, and :code:`surface`, the new Surface resource.

An important difference between :code:`steno3d.surface` the MATLAB builtin
**surface** function is data ordering. This function uses ordering produced
by the function **ndgrid**, where size(Z) == [length(x) length(y)].
The builtin surface function uses ordering produced by the function
**meshgrid**, where size(Z) = [length(y) length(x)]. Also,
:code:`steno3d.surface` does not support additional property/value pairs; after
creating the Surface, its properties may be directly modified.

Example:

.. code::

    pngFile = [tempname '.png'];
    imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
    [myProject, mySurface] = steno3d.surface(                       ...
        'X', 0:20, 'Z', 0:25, [0 0 -25], rand(21, 26), 'k',         ...
        'Increasing Numbers', 1:20*25, 'Space Image', pngFile       ...
    );
    mySurface.Title = 'Space Image';
    mySurface.Description = ['Vertical surface with some random '   ...
                             'bumps and a space image'];
    myProject.Title = 'Project with one Surface';
    myProject.Pulbic = true;
    steno3d.upload(myProject);


See more :ref:`EXAMPLES <steno3dexamplessurface>`

See also :ref:`steno3d.core.Surface <steno3dcoresurface>`, :ref:`steno3d.upload <steno3dupload>`, :ref:`steno3d.addData <steno3dadddata>`, :ref:`steno3d.addImage <steno3daddimage>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

