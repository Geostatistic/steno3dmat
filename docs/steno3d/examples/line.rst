.. _steno3dexamplesline:

line plotting examples
======================



Example 1: Plot a Steno3D :ref:`Project <steno3dcoreproject>` with a :ref:`Line <steno3dcoreline>` from array input

.. code::

    x = 0:pi/10:4*pi;
    example1 = steno3d.line(x, cos(x+0.2), sin(x));
    clear x;

Example 2: Plot Project with red Line from segments and vertices

.. code::

    x = (0:pi/10:4*pi)';
    verts = [x cos(x+0.2) sin(x); x zeros(length(x), 2)];
    segs = [1:length(x); length(x) + (1:length(x))]';
    example2 = steno3d.line(segs, verts, 'r');
    clear x verts segs;

Example 3: Plot Project with two Lines with data

.. code::

    x = 0:pi/10:4*pi;
    example3 = steno3d.line(                                     ...
        x(:), cos(x(:)+0.2), sin(x(:)),                          ...
        'Vertex Data', x,                                        ...
        'Segment Data', (x(1:end-1) + x(2:end))/2                ...
    );
    steno3d.line(                                                ...
        example3, x, sin(x+0.2), cos(x), 'k',                    ...
        'Cosine Data', cos(x)                                    ...
    );
    clear x;

Example 4: Plot Project and Line, then edit the Line properties

.. code::

    x = 0:pi/10:4*pi;
    [example4, lin] = steno3d.line(x, cos(x+0.2), sin(x), 'b');
    example4.Title = 'Example 4 Project';
    lin.Title = 'Blue Line';
    lin.Opts.Opacity = .75;
    example4.plot();
    clear myLine x segs verts;


You can run the above examples with:

.. code::

    steno3d.examples.line

Then plot the projects with:

.. code::

    example1.plot(); % etc...



See also :ref:`steno3d.line <steno3dline>`, :ref:`steno3d.core.Line <steno3dcoreline>`, :ref:`steno3d.core.Project <steno3dcoreproject>`

