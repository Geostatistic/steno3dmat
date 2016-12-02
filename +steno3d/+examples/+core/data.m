%Steno3D DataArray construction examples
%
%   Example 1: Create a <a href="matlab: help steno3d.core.Point
%   ">Point</a> resource and add a <a href="matlab:
%   help steno3d.core.DataArray">DataArray</a> with random data
%       pts = steno3d.core.Point;
%       pts.Mesh = steno3d.core.Mesh0D;
%       pts.Mesh.Vertices = rand(100, 3);
%       dat = steno3d.core.DataArray;
%       dat.Title = 'Random Point Data';
%       dat.Array = rand(100, 1);
%       % Note: Data is bound with a cell array. This implicitly creates
%       % a <a href="matlab: help steno3d.core.binders
%       ">binder</a>. location must be specified; for points, the only
%       % available option is 'N' (nodes)
%       pts.Data = {                                                 ...
%           'Location', 'N',                                         ...
%           'Data', dat                                              ...
%       };
%       example1 = steno3d.core.Project(                             ...
%           'Title', 'Data: Example 1',                              ...
%           'Resources', pts                                         ...
%       );
%       clear pts dat
%
%   Example 2: Create a <a href="matlab: help steno3d.core.Surface
%   ">Surface</a> and add node and cell-center DataArrays
%       sfc = steno3d.core.Surface;
%       sfc.Mesh = steno3d.core.Mesh2DGrid;
%       sfc.Mesh.H1 = ones(5, 1);
%       sfc.Mesh.H2 = ones(10, 1);
%       ccValues = rand(5, 10);
%       datCC = steno3d.core.DataArray;
%       datCC.Title = 'Random Cell-Centered Data';
%       datCC.Array = ccValues(:);
%       nValues = rand(6, 11);
%       datN = steno3d.core.DataArray;
%       datN.Title = 'Random Node Data';
%       datN.Array = nValues(:);
%       sfc.Data{1} = {                                              ...
%           'Location', 'CC',                                        ...
%           'Data', datCC                                            ...
%       };
%       sfc.Data{2} = {                                              ...
%           'Location', 'N',                                         ...
%           'Data', datN                                             ...
%       };
%       example2 = steno3d.core.Project(                             ...
%           'Title', 'Data: Example 2',                              ...
%           'Resources', sfc                                         ...
%       );
%       clear sfc datCC datN ccValues nValues
%
%   You can <a href="matlab: steno3d.examples.core.data
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.core.data
%   Then plot the projects with:
%       example1.plot(); % etc...
%
%
%   See also STENO3D.CORE.DATAARRAY, STENO3D.CORE.BINDERS,
%   STENO3D.CORE.POINT, STENO3D.CORE.MESH0D, STENO3D.CORE.SURFACE,
%   STENO3D.CORE.MESH2DGRID, STENO3D.CORE.PROJECT
%


%Example 1: Create a Point resource and add a DataArray with random data
pts = steno3d.core.Point;
pts.Mesh = steno3d.core.Mesh0D;
pts.Mesh.Vertices = rand(100, 3);
dat = steno3d.core.DataArray;
dat.Title = 'Random Point Data';
dat.Array = rand(100, 1);
pts.Data = {                                                 ...
    'Location', 'N',                                         ...
    'Data', dat                                              ...
};
example1 = steno3d.core.Project(                             ...
    'Title', 'Data: Example 1',                              ...
    'Resources', pts                                         ...
);
clear pts dat

%Example 2: Create a Surface and add node and cell-center DataArrays
sfc = steno3d.core.Surface;
sfc.Mesh = steno3d.core.Mesh2DGrid;
sfc.Mesh.H1 = ones(5, 1);
sfc.Mesh.H2 = ones(10, 1);
ccValues = rand(5, 10);
datCC = steno3d.core.DataArray;
datCC.Title = 'Random Cell-Centered Data';
datCC.Array = ccValues(:);
nValues = rand(6, 11);
datN = steno3d.core.DataArray;
datN.Title = 'Random Node Data';
datN.Array = nValues(:);
sfc.Data{1} = {                                              ...
    'Location', 'CC',                                        ...
    'Data', datCC                                            ...
};
sfc.Data{2} = {                                              ...
    'Location', 'N',                                         ...
    'Data', datN                                             ...
};
example2 = steno3d.core.Project(                             ...
    'Title', 'Data: Example 2',                              ...
    'Resources', sfc                                         ...
);
clear sfc datCC datN ccValues nValues