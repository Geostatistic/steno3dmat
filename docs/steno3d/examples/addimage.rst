.. _steno3dexamplesaddimage:

addImage examples
=================



Example 1: Add a newly created PNG image to a :ref:`Point <steno3dcorepoint>` resource

.. code::

    pngFile = [tempname '.png'];
    imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
    [example1, pts] = steno3d.scatter(rand(1000, 3));
    steno3d.addImage(pts, pngFile, 1, 1);
    clear pngFile pts;

Example 2: Add three images to a :ref:`Surface <steno3dcoresurface>` with varying orientations

.. code::

    pngFile = [tempname '.png'];
    imwrite(imread('ngc6543a.jpg'), pngFile, 'png');
    [example2, sfc] = steno3d.surface(                           ...
        'X', 0:.1:1, 'Z', 0:.1:1, [0 0 0]                        ...
    );
    steno3d.addImage(sfc, pngFile, 'X', .25, 'Z', .25);
    steno3d.addImage(sfc, pngFile, 'X', .25, 'Z', .25,           ...
                     [.25 0 .25]);
    steno3d.addImage(sfc, pngFile, [-1 0 0], .5, [0 0 -1], .5,   ...
                     [1 0 1], 'Reversed Space Image');
    clear pngFile sfc;

Example 3: Project an image created with MATLAB texturemap on a sphere

.. code::

    fig = figure; [x, y, z] = sphere; surf(x, y, z);
    h = findobj('Type', 'surface');
    load earth; hemisphere = [ones(257,125), X, ones(257,125)];
    set(h, 'CData', flipud(hemisphere), 'FaceColor', 'texturemap');
    colormap(map); axis equal; view([90 0]);
    fig.Position = [fig.Position(1:3) fig.Position(3)];
    ax = gca; ax.Position = [0 0 1 1];
    pngFile = [tempname '.png'];
    print(fig, '-dpng', pngFile);
    close(fig)
    clear map X h hemisphere fig ax
    verts = [x(:) y(:) z(:)];
    tris = convhull(x(:), y(:), z(:));
    [example3, sfc] = steno3d.trisurf(tris, verts);
    steno3d.addImage(sfc, pngFile, 'X', 2, 'Z', 2, [-1 -1 -1],   ...
                     'Hemisphere');
    clear x y z verts tris sfc pngFile;


You can run the above examples with:

.. code::

    steno3d.examples.addimage

Then plot the projects with:

.. code::

    example1.plot(); % etc...



See also :ref:`steno3d.addImage <steno3daddimage>`, :ref:`steno3d.scatter <steno3dscatter>`, :ref:`steno3d.surface <steno3dsurface>`, :ref:`steno3d.trisurf <steno3dtrisurf>`

