%Data Binders: Adding data to resources in Steno3D
%   Steno3D uses data binders to bind %%%ref[DataArrays](steno3d.core.DataArray) to %%%ref[CompositeResources](steno3d.core.CompositeResource).
%   Because of this, the "Data" property of a resource is a binder (or cell
%   array of binders). These binders each have two properties:
%
%       `Data`     - DataArray with title, description, array, etc.
%
%       `Location` - Geometry element to which data is bound, either 'N'
%                  (nodes) or 'CC' (cell-centers).
%
%   It is not necessary to construct binder objects explicitly; they can be
%   created implicitly using cell arrays as shown in the example below.
%   %%%codeblock
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
%   %%%bold[Binder types]:
%   %%%class[PointBinder](steno3d.core.binders.PointBinder)   - Bind data to nodes of a Steno3D %%%ref[Point](steno3d.core.Point)
%   %%%class[LineBinder](steno3d.core.binders.LineBinder)    - Bind data to segments or vertices of a Steno3D %%%ref[Line](steno3d.core.Line)
%   %%%class[SurfaceBinder](steno3d.core.binders.SurfaceBinder) - Bind data to faces or vertices of a Steno3D %%%ref[Surface](steno3d.core.Surface)
%   %%%class[VolumeBinder](steno3d.core.binders.VolumeBinder)  - Bind data to cell centers of a Steno3D %%%ref[Volume](steno3d.core.Volume)
%
%   For more examples see the DataArray %%%ref[examples](steno3d.examples.core.data)
%
%   %%%seealso steno3d.core.DataArray, steno3d.addData
%
%   %%%tree PointBinder LineBinder SurfaceBinder VolumeBinder
