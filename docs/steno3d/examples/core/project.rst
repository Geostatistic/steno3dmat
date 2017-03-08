.. _steno3dexamplescoreproject:

Project examples
================



Example 1: Create a Steno3D :ref:`Project <steno3dcoreproject>` with one resource

.. code::

    pts = steno3d.core.Point(                                    ...
        'Mesh', {'Vertices', rand(100, 3)}                       ...
    );
    example1 = steno3d.core.Project;
    example1.Resources = pts;
    clear pts;

Example 2: Create a Project with multiple resources

.. code::

    pts = steno3d.core.Point(                                    ...
        'Mesh', {'Vertices', rand(100, 3)}                       ...
    );
    sfc = steno3d.core.Surface(                                  ...
        'Mesh', {'H1', 0.1*ones(10, 1), 'H2', 0.1*ones(10, 1)}   ...
    );
    example2 = steno3d.core.Project;
    example2.Title = 'Example 2';
    example2.Description = 'Project with two resources';
    example2.Public = true;
    example2.Resources = {pts, sfc};
    clear pts sfc;

Example 3: Create a Project with one resource then append another

.. code::

    pts = steno3d.core.Point(                                    ...
        'Mesh', {'Vertices', rand(100, 3)}                       ...
    );
    example3 = steno3d.core.Project(                             ...
        'Title', 'Example 3',                                    ...
        'Description', 'Project with one or two resources',      ...
        'Public', false,                                         ...
        'Resources', pts                                         ...
    );
    sfc = steno3d.core.Surface(                                  ...
        'Mesh', {'H1', 0.1*ones(10, 1), 'H2', 0.1*ones(10, 1)}   ...
    );
    example3.Resources{end+1} = sfc;
    clear pts sfc;

Example 4: Create a project and add to it with high-level functions

.. code::

    example4 = steno3d.scatter(rand(100, 3));
    steno3d.volume(example4, [1 1 1], rand(5, 10, 15));


You can run the above examples with:

.. code::

    steno3d.examples.core.project

Then plot the projects with:

.. code::

    example1.plot(); % etc...



See also :ref:`steno3d.core.Project <steno3dcoreproject>`, :ref:`steno3d.core.Point <steno3dcorepoint>`, :ref:`steno3d.core.Surface <steno3dcoresurface>`, :ref:`steno3d.scatter <steno3dscatter>`, :ref:`steno3d.volume <steno3dvolume>`

