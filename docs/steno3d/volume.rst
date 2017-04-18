.. _steno3dvolume:

volume
======

.. function:: steno3d.volume(...)

Create and plot a Steno3D Volume resource

:code:`steno3d.volume(data)` creates a Steno3D Project with a Volume resource
defined by :code:`data`, an m x n x p matrix. The data values are plotted on
cell-centers with unit widths. Cell boundaries are defined by x = 0:m,
y = 0:n, and z = 0:p.

:code:`steno3d.volume(origin, data)` creates a Steno3D Project with a Volume
resource as above, offset by 1 x 3 :code:`origin` vector. Cell boundaries are
defined by x = origin(1) + (0:m), y = origin(2) + (0:n), and
z = origin(3) + (0:p).

:code:`steno3d.volume(X, Y, Z, data)` creates a Steno3D Project with a Volume
resource as above. :code:`X`, :code:`Y`, and :code:`Z` are vectors of cell boundaries (with
sizes n x 1, m x 1, and p x 1, respectively) OR of cell widths (with
sizes (n-1) x 1, (m-1) x 1, and (p-1) x 1, respectively). Since the
volume dimensions are given by :code:`X`, :code:`Y`, and :code:`Z` in this case, :code:`data` may also
be a m*n*p x 1 vector.

:code:`steno3d.volume(X, Y, Z, origin, data)` creates a Steno3D Project with a
Volume resource as above, offset by 1 x 3 :code:`origin` vector. This is
useful when :code:`X`, :code:`Y`, and :code:`Z` are cell widths.

:code:`steno3d.volume(..., title1, data1, ..., titleN, dataN)` adds any number
of titled datasets to the Volume resource. :code:`title` must be a string and
:code:`data` must be a matrix of size m x n x p (or m*n*p x 1 if :code:`X`, :code:`Y`, and :code:`Z`
are provided). :code:`title`/:code:`data` pairs may replace the standalone :code:`data`
matrices above. (For more details see :func:`steno3d.addData`)

:code:`steno3d.volume(project, ...)` adds the Volume resource to :code:`project`, an
existing Steno3D Project. :code:`project` may also be a figure or axes handle
that was created by a Steno3D plotting function.

:code:`project = steno3d.volume(...)` returns :code:`project`, the Steno3D Project that
contains the new Volume resource.

:code:`[project, volume] = steno3d.volume(...)` returns :code:`project`, the Steno3D
Project, and :code:`volume`, the new Volume resource.

:code:`steno3d.volume` does not have a MATLAB builtin counterpart. When
plotting a Steno3D Volume locally, its boundaries are displayed in a
similar way as **slice**, but when uploaded to steno3d.com, the entire
volume is available for plotting, slicing, and isosurfacing. After
creating a Volume resource with :code:`steno3d.volume`, properties of the
Volume object can be directly modified.

Example:

.. code::

    [xvals, yvals, zvals] = ndgrid(-7.5:4:7.5, -9:2:9, -9.5:9.5);
    [proj, vol] = steno3d.volume(                                   ...
        4*ones(5, 1), 2*ones(10, 1), ones(20, 1), [-10 -10 -10],    ...
        'X-Values', xvals, 'Y-Values', yvals, 'Z-Values', zvals     ...
    );
    vol.Title = 'Example Volume';
    vol.Description = 'Volume with x, y, and z data';
    vol.Title = 'Project with one Volume';
    proj.Public = true;
    steno3d.upload(proj);


See more :ref:`EXAMPLES <steno3dexamplesvolume>`

See also :ref:`steno3d.core.Volume <steno3dcorevolume>`, :ref:`steno3d.upload <steno3dupload>`, :ref:`steno3d.addData <steno3dadddata>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

