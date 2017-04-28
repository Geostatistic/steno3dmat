%DataArray construction examples:
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso steno3d.core.DataArray, steno3d.core.binders, steno3d.core.Point, steno3d.core.Mesh0D, steno3d.core.Surface, steno3d.core.Mesh2DGrid, steno3d.core.Project
%


%   Example 1: Create a %%%ref[Point](steno3d.core.Point) resource and add a %%%ref[DataArray](steno3d.core.DataArray) with random data
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
example1.plot;
clear pts dat

%%%image /images/core-DataArray-examples-images/core-data-example1.png

%   Example 2: Create a %%%ref[Surface](steno3d.core.Surface) and add node and cell-center DataArrays
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
example2.plot;
clear sfc datCC datN ccValues nValues

%%%image /images/core-DataArray-examples-images/core-data-example2.png
