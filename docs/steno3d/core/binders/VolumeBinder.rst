.. _steno3dcorebindersvolumebinder:

VolumeBinder
============

.. class:: steno3d.core.binders.VolumeBinder

Bind data to cell centers of a Steno3D Volume

For usage details, see the :ref:`binders help <steno3dcorebinders>`.

**VolumeBinder** implements :ref:`props.HasProps <propshasprops>` for dynamic, type-checked :ref:`properties <propsprop>`

**Required Properties**:

    **Location** (:class:`props.String`) - Location of the data on mesh, Choices: CC, Default: 'CC'

    **Data** (:class:`props.Instance`) - Volume data array, Class: :ref:`DataArray <steno3dcoreDataArray>`



See the volume :ref:`EXAMPLES <steno3dexamplescorevolume>`

See also :ref:`steno3d.core.binders <steno3dcorebinders>`, :ref:`steno3d.core.DataArray <steno3dcoredataarray>`, :ref:`steno3d.core.Volume <steno3dcorevolume>`

