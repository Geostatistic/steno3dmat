.. _steno3dexamplescombine:

combine project examples
========================



Example 1: Combine three Steno3D :ref:`Projects <steno3dcoreproject>`

.. code::

    pointProj = steno3d.scatter(rand(100, 3)); close;
    lineProj = steno3d.line(-10:.1:0, sin(-10:.1:0), cos(-10:.1:0));
    volProj = steno3d.volume([1 1 1], rand(5, 7, 10)); close; close;
    example1 = steno3d.combine(pointProj, lineProj, volProj);
    clear pointProj lineProj volProj;

Example 2: Combine two Projects converted from MATLAB figures

.. code::

    figure; peaks; peaksProj = steno3d.convert(gca); close;
    figure; sphere; sphereProj = steno3d.convert(gca); close;
    example2 = steno3d.combine(peaksProj, sphereProj);
    example2.Title = 'Two-Surface Project';
    clear peaksProj sphereProj;

Example 3: Combine four Projects converted from a multi-axes figure

.. code::

    fig = figure;
    subplot(221); [x, y] = ndgrid(-3:.1:0, -3:.1:0); peaks(x, y);
    subplot(222); [x, y] = ndgrid(-3:.1:0, .2:.1:3); peaks(x, y);
    subplot(223); [x, y] = ndgrid(.2:.1:3, .2:.1:3); peaks(x, y);
    subplot(224); [x, y] = ndgrid(.2:.1:3, -3:.1:0); peaks(x, y);
    projs = steno3d.convert(fig);
    example3 = steno3d.combine(projs);
    close; clear fig x y projs;


You can run the above examples with:

.. code::

    steno3d.examples.combine

Then plot the projects with:

.. code::

    example1.plot(); % etc...



See also :ref:`steno3d.combine <steno3dcombine>`, :ref:`steno3d.convert <steno3dconvert>`, :ref:`steno3d.scatter <steno3dscatter>`, :ref:`steno3d.line <steno3dline>`, :ref:`steno3d.volume <steno3dvolume>`

