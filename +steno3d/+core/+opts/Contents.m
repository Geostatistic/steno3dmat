% OPTS: Adding options to resources in Steno3D
%   Most Steno3D objects have options to customize their appearance. These
%   are set with Options objects. See the specific Options type to see the
%   available options.
%
%   It is not necessary to construct options objects explicitly; they can
%   be created implicitly using cell arrays as shown in the example below.
%
%   Example:
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
% Options Types:
%   PointOptions   - Options for Steno3D <a href="matlab:
%   help steno3d.core.Point">Point</a> objects
%   LineOptions    - Options for Steno3D <a href="matlab:
%   help steno3d.core.Line">Line</a> objects
%   SurfaceOptions - Options for Steno3D <a href="matlab:
%   help steno3d.core.Surface">Surface</a> objects
%   VolumeOptions  - Options for Steno3D <a href="matlab:
%   help steno3d.core.Volume">Volume</a> objects
%   Mesh0DOptions  - Options for Steno3D <a href="matlab:
%   help steno3d.core.Mesh0D">Mesh0D</a> objects
%   Mesh1DOptions  - Options for Steno3D <a href="matlab:
%   help steno3d.core.Mesh1D">Mesh1D</a> objects
%   Mesh2DOptions  - Options for Steno3D <a href="matlab: 
%   help steno3d.core.Mesh2D">Mesh2D</a> and <a href="matlab:
%   help steno3d.core.Mesh2DGrid">Mesh2DGrid</a> objects
%   Mesh3DOptions  - Options for Steno3D <a href="matlab:
%   help steno3d.core.Mesh3DGrid">Mesh3DGrid</a> objects
%   Options        - Base class for Steno3D options
%