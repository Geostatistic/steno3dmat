.. _steno3dcore:

Core Resources
==============
 Command-line tools for building Steno3D objects from scratch


**Steno3D Project**:

 :class:`steno3d.core.Project` - Container of related Steno3D resources for plotting and uploading

**Composite Resource Classes**:

 :class:`steno3d.core.Point`   - Low-level Steno3D Point resource

 :class:`steno3d.core.Line`    - Low-level Steno3D Line resource

 :class:`steno3d.core.Surface` - Low-level Steno3D Surface resource

 :class:`steno3d.core.Volume`  - Low-level Steno3D Volume resource

**Mesh Classes**:

 :class:`steno3d.core.Mesh0D`     - Mesh for Steno3D Point resources

 :class:`steno3d.core.Mesh1D`     - Mesh for Steno3D Line resources

 :class:`steno3d.core.Mesh2D`     - Mesh for triangulated Steno3D Surface resources

 :class:`steno3d.core.Mesh2DGrid` - Mesh for gridded Steno3D Surface resources

 :class:`steno3d.core.Mesh3DGrdi` - Mesh for Steno3D Volume resources

**Data and Texture Classes**:

 :class:`steno3d.core.DataArray`      - Steno3D object to hold resource data

 :class:`steno3d.core.Texture2DImage` - Steno3D object to hold images and mapping to resources

**Options/Binders/Base classes**:

 :ref:`Options <steno3dcoreopts>`              - Steno3D options for various classes

 :ref:`Data Binders <steno3dcorebinders>`      - Binders to attach data to composite resources

 :class:`steno3d.core.CompositeResource` - Abstract base class for oPoint/Line/Surface/Volume

 :class:`steno3d.core.UserContent`       - Abstract base class for other top-level classes

See the :ref:`EXAMPLES <steno3dexamplescore>`


.. toctree::
    :maxdepth: 2
    :hidden:

    Project
    Point
    Line
    Surface
    Volume
    Mesh0D
    Mesh1D
    Mesh2D
    Mesh2DGrid
    Mesh3DGrid
    DataArray
    Texture2DImage
    opts/Contents
    binders/Contents
    CompositeResource
    UserContent
