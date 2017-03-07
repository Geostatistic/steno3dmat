%OPTIONS: Adding options to resources in Steno3D
%   Most Steno3D objects have options to customize their appearance. These
%   are set with Options objects. See the specific Options type to see the
%   available options.
%
%   It is not necessary to construct options objects explicitly; they can
%   be created implicitly using cell arrays as shown in the example below.
%   %%%codeblock
%       % Initialize a Steno3D Surface resource
%       mySurface = steno3d.core.Surface;
%       mySurface.Mesh = steno3d.core.Mesh2DGrid(                    ...
%           'H1', ones(10, 1),                                       ...
%           'H2', ones(20, 1)                                        ...
%       );
%
%       % Explicit options construction (NOT RECOMMENDED)
%       myPoint.Opts = steno3d.core.opts.PointOptions(               ...
%           'Opacity', .75, 'Color', 'r'                             ...
%       );
%       myPoint.Mesh.Opts = steno3d.core.opts.Mesh2DOptions(         ...
%           'Wireframe', true                                        ...
%       );
%
%       % Implicit data binder construction (RECOMMENDED)
%       myPoint.Opts = {'Opacity', .75, 'Color', 'r'};
%       myPoint.Mesh.Opts = {'Wireframe', true};
%
%   %%%bold[Options Types]:
%   %%%class[PointOptions](steno3d.core.opts.PointOptions)   - Options for Steno3D %%%ref[Point](steno3d.core.Point)
%   %%%class[LineOptions](steno3d.core.opts.LineOptions)    - Options for Steno3D %%%ref[Line](steno3d.core.Line)
%   %%%class[SurfaceOptions](steno3d.core.opts.SurfaceOptions) - Options for Steno3D %%%ref[Surface](steno3d.core.Surface)
%   %%%class[VolumeOptions](steno3d.core.opts.VolumeOptions)  - Options for Steno3D %%%ref[Volume](steno3d.core.Volume)
%   %%%class[Mesh0DOptions](steno3d.core.opts.Mesh0DOptions)  - Options for Steno3D %%%ref[Mesh0D](steno3d.core.Mesh0D)
%   %%%class[Mesh1DOptions](steno3d.core.opts.Mesh1DOptions)  - Options for Steno3D %%%ref[Mesh1D](steno3d.core.Mesh1D)
%   %%%class[Mesh2DOptions](steno3d.core.opts.Mesh2DOptions)  - Options for Steno3D %%%ref[Mesh2D](steno3d.core.Mesh2D) and %%%ref[Mesh2DGrid](steno3d.core.Mesh2DGrid)
%   %%%class[Mesh3DOptions](steno3d.core.opts.Mesh3DOptions)  - Options for Steno3D %%%ref[Mesh3DGrid](steno3d.core.Mesh3DGrid)
%   %%%class[Options](steno3d.core.opts.Options)        - Abstract base class for Steno3D options
%
