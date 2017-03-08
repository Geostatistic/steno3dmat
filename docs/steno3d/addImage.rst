.. _steno3daddimage:

addImage
========

.. function:: steno3d.addImage(...)

Add a PNG image to an existing Steno3d resource

:code:`steno3d.addImage(resource, pngfile, width, height)` scales PNG image
:code:`pngfile` to size :code:`width` x :code:`height`, then projects it in a direction
perpendicular to the horizontal plane onto the Steno3D :code:`resource`
(:ref:`Point <steno3dcorepoint>` or :ref:`Surface <steno3dcoresurface>`).

:code:`steno3d.addImage(resource, pngfile, dir1, dim1, dir2, dim2)` scales and
reshapes the PNG image :code:`pngfile` so its x-axis lies along :code:`dir1` with
length :code:`dim1` and its y-axis lies along :code:`dir2` with length :code:`dim2`. :code:`dir1` and
:code:`dir2` are either a 1 x 3 vector or 'X', 'Y' or 'Z'. The image is then
projected in a direction perpendicular to :code:`dir1` and :code:`dir2` (the
:code:`dir1`-cross-:code:`dir2` direction) onto the Steno3D :code:`resource`.

:code:`steno3d.addImage(..., origin)` shifts the origin of the image by 1 x 3
vector :code:`origin`, prior to projection onto the :code:`resource`.

:code:`steno3d.addImage(..., title)` gives the image a :code:`title` string. If no
:code:`title` is provided, the image will be titled based on the PNG file name.

Images can only be added to Points or Surfaces. Also, the images are
simply projected straight onto the Resource. This is different than
MATLAB's 'texturemap' face coloring that wraps the image based on the
underlying surface geometry. To map data to the geometry, use
:func:`steno3d.addData` instead.

Also, when plotting projects locally, images only show up as dashed
outlines at the position they are projected from. To see the result of
adding the image, you must upload the project and view it on
steno3d.com.

Example:

.. code::

        [x, y, z] = sphere; surf(x, y, z); h = findobj('Type', 'surface');
    load earth; hemisphere = [ones(257,125), X, ones(257,125)];
    set(h, 'CData', flipud(hemisphere), 'FaceColor', 'texturemap');
    colormap(map); axis equal; view([90 0]);
    fig = gcf; fig.Position = [fig.Position(1:3) fig.Position(3)];
    ax = gca; ax.Position = [0 0 1 1];
    pngFile = [tempname '.png'];
    print(fig, '-dpng', tempFile);
        verts = [x(:) y(:) z(:)];
    tris = convhull(x(:), y(:), z(:));
    [proj, sfc] = steno3d.trisurf(tris, verts);
        steno3d.addImage(sfc, pngFile, 'X', 2, 'Z', 2, [-1 -1 -1],      ...
                     'Hemisphere');


See more :ref:`EXAMPLES <steno3dexamplesaddimage>`

See also :ref:`steno3d.core.Texture2DImage <steno3dcoretexture2dimage>`, :ref:`steno3d.addData <steno3dadddata>`, :ref:`steno3d.trisurf <steno3dtrisurf>`

