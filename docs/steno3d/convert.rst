.. _steno3dconvert:

convert
=======

.. function:: steno3d.convert(...)

Convert MATLAB figure or axes into a Steno3D Project

:code:`project = steno3d.convert(handle)` converts the figure or axes :code:`HANDLE`
to :code:`PROJECT`, a Steno3D :ref:`Project <steno3dcoreproject>` or list of Projects.

:code:`project = steno3d.convert(..., parameter, value)` converts the figure or
axes :code:`handle` using the given :code:`parameter`/:code:`value` pairs. Available parameters
are:

    **CombineAxes**: true or false (default: true)
        If HANDLE is a figure with multiple axes and CombineAxes is
        false, a separate project will be created for each axes.
        If HANDLE is a figure with multiple axes and CombineAxes is
        true, the contents of all axes will be added to one project.
        If HANDLE is an axes or a figure with one axes, CombineAxes has
        no effect.
    **CombineResources**: true or false (default: true)
        If CombineResources is false, every MATLAB graphics object
        encountered will produce a separate Steno3D Resource.
        If CombineResources is true, this function attempts to combine
        similar graphics objects into single Steno3D Resources. This
        includes combining multiple data sets with identical underlying
        geometry and appending similar resources with the same data
        titles (or no data). Although this parameter exists, it is
        recommended to build resources carefully using the Steno3D
        plotting rather than relying on correct conversion of MATLAB
        graphics.

Supported MATLAB graphics types include contour, group, image, line,
patch, scatter, and surface. These cover the majority of MATLAB builtin
plotting functions. Currently, unsupported MATLAB graphics types
include polaraxes, transform, area, bar, errorbar, quiver, stair, stem,
rectangle, text, light, and function objects.

Additionally, not all properties of the graphics are supported by
Steno3D. Most notably, variable color data is not supported; only
one-element data is currently allowed. Other unsupported aspects are
different line/marker types, variable alpha data, camera/lighting, etc.
After converting a MATLAB figure to a Steno3D Project, you may plot the
project to ensure all the required features were converted.

If you would like to see additional support please submit an issue on
`github <https://github.com/3ptscience/steno3dmat/issues>`_ or consider `contributing <https://github.com/3ptscience/steno3dmat>`_.

Example:

.. code::

    peaks;
    peaksProj = steno3d.convert(gcf);

See more :ref:`EXAMPLES <steno3dexamplesconvert>`

See also :ref:`steno3d.core.Project <steno3dcoreproject>`, :ref:`steno3d.combine <steno3dcombine>`

