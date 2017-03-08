.. _steno3dcombine:

combine
=======

.. function:: steno3d.combine(...)

Combine a list of Steno3D Projects into one Project

:code:`project = steno3d.combine(projects)` takes :code:`projects`, a list of Steno3D
:ref:`Projects <steno3dcoreproject>`, and combines their resources into one :code:`project`

:code:`project = steno3d.combine(project1, project2, ..., projectN)` combines
all the input projects into one :code:`project`.

Example:

.. code::

    peaks; peaksProj = steno3d.convert(gcf);
    sphere; sphereProj = steno3d.convert(gcf);
    comboProj = steno3d.combine(peaksProj, sphereProj);
    comboProj.Title = 'Two-Surface Project';


See more :ref:`EXAMPLES <steno3dexamplescombine>`

See also :ref:`steno3d.core.Project <steno3dcoreproject>`, :ref:`steno3d.convert <steno3dconvert>`

