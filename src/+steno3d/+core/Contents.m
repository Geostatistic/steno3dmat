%Core Resources: Command-line tools for building Steno3D objects from scratch
%
%   %%%bold[Steno3D Project]:
%   %%%class[Project](steno3d.core.Project) - Container of related Steno3D resources for plotting and uploading
%
%   %%%bold[Composite Resource Classes]:
%   %%%class[Point](steno3d.core.Point)   - Low-level Steno3D Point resource
%   %%%class[Line](steno3d.core.Line)    - Low-level Steno3D Line resource
%   %%%class[Surface](steno3d.core.Surface) - Low-level Steno3D Surface resource
%   %%%class[Volume](steno3d.core.Volume)  - Low-level Steno3D Volume resource
%
%   %%%bold[Mesh Classes]:
%   %%%class[Mesh0D](steno3d.core.Mesh0D)     - Mesh for Steno3D Point resources
%   %%%class[Mesh1D](steno3d.core.Mesh1D)     - Mesh for Steno3D Line resources
%   %%%class[Mesh2D](steno3d.core.Mesh2D)     - Mesh for triangulated Steno3D Surface resources
%   %%%class[Mesh2DGrid](steno3d.core.Mesh2DGrid) - Mesh for gridded Steno3D Surface resources
%   %%%class[Mesh3DGrid](steno3d.core.Mesh3DGrid) - Mesh for Steno3D Volume resources
%
%   %%%bold[Data and Texture Classes]:
%   %%%class[DataArray](steno3d.core.DataArray)      - Steno3D object to hold resource data
%   %%%class[Texture2DImage](steno3d.core.Texture2DImage) - Steno3D object to hold images and mapping to resources
%
%   %%%bold[Options/Binders/Base classes]:
%   %%%ref[Options](steno3d.core.opts)              - Steno3D options for various classes
%   %%%ref[Data Binders](steno3d.core.binders)      - Binders to attach data to composite resources
%   %%%class[CompositeResource](steno3d.core.CompositeResource) - Abstract base class for oPoint/Line/Surface/Volume
%   %%%class[UserContent](steno3d.core.UserContent)       - Abstract base class for other top-level classes
%
%   See the %%%ref[EXAMPLES](steno3d.examples.core)
%
%   %%%tree Project Point Line Surface Volume Mesh0D Mesh1D Mesh2D Mesh2DGrid Mesh3DGrid DataArray Texture2DImage opts/Contents binders/Contents CompositeResource UserContent
