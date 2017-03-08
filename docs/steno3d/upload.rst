.. _steno3dupload:

upload
======

.. function:: steno3d.upload(...)

Upload a figure, axes, or Steno3D Project to steno3d.com

:code:`steno3d.upload(handle)` uploads Steno3D :ref:`Project <steno3dcoreproject>` :code:`handle` to steno3d.com.
If :code:`handle` is a figure or axes created by a Steno3D plotting function,
the corresponding Project is uploaded. (Note: The the current state of
the Project will be uploaded, including modifications that may not yet
be reflected in the figure. You may wish to call :code:`plot()` on the project
prior to uploading to ensure all modifications are correct.) If :code:`handle`
is a figure or axes handle unassociated with a Steno3D Project, the
figure or axes is converted to Steno3D using :func:`steno3d.convert` then
uploaded.

:code:`steno3d.upload(handle, privacy)` sets the privacy of the Steno3D
Project on steno3d.com, where :code:`privacy` is 'public' or 'private'. If
:code:`privacy` is not specified, the Public boolean property of the Project
:code:`handle` is used. If that is not available, the default is 'private'.

:code:`url = steno3d.upload(...)` returns the :code:`url` of the uploaded project. :code:`url`
may also be a cell array of urls if multiple projects are uploaded
(for example, if a figure with multiple axes is converted to multiple
projects).

The privacy setting determines the project's visibility online. If it
is set to 'private', only you, the owner, can view it initially. View,
Edit, and Manage permissions can be granted through the web interface.
However, the number of private projects is limited on certain plans.
If the privacy is 'public', anyone can view the project on the public
`explore <https://steno3d.com/explore>`_ page. More information about plans is available `online <https://steno3d.com/pricing>`_.

Example:

.. code::

    steno3d.login();
    peaks; proj = steno3d.convert(gcf);
    url = steno3d.upload(proj, 'private');
    steno3d.logout();


See more :ref:`EXAMPLES <steno3dexamplesupload>`

See also :ref:`steno3d.convert <steno3dconvert>`, :ref:`steno3d.core.Project <steno3dcoreproject>`, :ref:`steno3d.login <steno3dlogin>`, :ref:`steno3d.logout <steno3dlogout>`

