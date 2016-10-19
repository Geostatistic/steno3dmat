% BINDERS: Adding data to resources in Steno3D
%   Steno3D uses data binders to bind <a href="
%   matlab: help steno3d.core.DataArray">DataArrays</a> to <a href="
%   matlab: help steno3d.core.CompositeResource">CompositeResources</a>.
%   Because of this, the "Data" property of a resource is a binder (or cell
%   array of binders). These binders each have two properties:
%
%       DATA - DataArray with title, description, array, etc.
%
%       LOCATION - Geometry element to which data is bound, either 'N'
%                  (nodes) or 'CC' (cell-centers).
%
%   It is not necessary to construct binder objects explicitly; they can be
%   created implicitly using cell arrays as shown in the example below.
%
%   Example:
%       % Initialize a Steno3D Point resource
%       myPoint = steno3d.core.Point;
%       myPoint.Mesh = steno3d.core.Mesh0D('Vertices', rand(100, 3));
%       randomData1 = steno3d.core.DataArray(                        ...
%           'Title', 'Random Point Data',                            ...
%           'Array', rand(100, 1)                                    ...
%       );
%       
%       % Explicit data binder construction (NOT RECOMMENDED)
%       myPoint.Data = steno3d.core.binders.PointBinder(             ...
%           'Location', 'N', 'Data', randomData1                     ...
%       );
%      
%       % Implicit data binder construction (RECOMMENDED)
%       myPoint.Data = {'Location', 'N', 'Data', randomData1};
%      
%       % Adding multiple datasets to one resource
%       randomData2 = steno3d.core.DataArray(                        ...
%           'Title', 'More Random Point Data',                       ...
%           'Array', rand(100, 1)                                    ...
%       );
%       randomData3 = steno3d.core.DataArray(                        ...
%           'Title', 'Another Random Point Data',                    ...
%           'Array', rand(100, 1)                                    ...
%       );
%       myPoint.Data = {                                             ...
%           {'Location', 'N', 'Data', randomData1},                  ...
%           {'Location', 'N', 'Data', randomData2},                  ...
%           {'Location', 'N', 'Data', randomData3}                   ...
%       };
%   
% Binder types:
%   PointBinder   - Bind data to nodes of a Steno3D <a href="matlab: help
%   steno3d.core.Point">Point</a>
%   LineBinder    - Bind data to segments or vertices of a Steno3D <a href=
%   "matlab: help steno3d.core.Line">Line</a>
%   SurfaceBinder - Bind data to faces or vertices of a Steno3D <a href=
%   "matlab: help steno3d.core.Surface">Surface</a>
%   VolumeBinder  - Bind data to cell centers of a Steno3D <a href=
%   "matlab: help steno3d.core.Volume">Volume</a>
%
%
%   For more examples see the DataArray <a href="matlab:
%   help steno3d.examples.core.data">EXAMPLES</a>.
%
%   See also STENO3D.CORE.DATAARRAY, STENO3D.ADDDATA
%
