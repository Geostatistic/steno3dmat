% Steno3D Project examples
%
%   Example 1:
%       % Create a Steno3D Point resource
%       pts = steno3d.core.Point(                                    ...
%              'Mesh', {'Vertices', rand(100, 3)}                       ...
%          );
%       % Create a Steno3D Project
%       example1 = steno3d.core.Project;
%       % Add the resource to the Project
%       example1.Resources = pts;
%       clear pts
%
%   Example 2:
%       % Create multiple Steno3D resources
%       pts = steno3d.core.Point(                                    ...
%              'Mesh', {'Vertices', rand(100, 3)}                       ...
%          );
%       sfc = steno3d.core.Surface(                                  ...
%              'Mesh', {'H1', 0.1*ones(10, 1), 'H2', 0.1*ones(10, 1)}   ...
%          );
%       % Create a Steno3D Project
%       example2 = steno3d.core.Project;
%       % Give the Project a title and description and make it public
%       example2.Title = 'Example 2';
%       example2.Description = 'Project with two resources';
%       example2.Public = true;
%       % Add the resources to the Project as a cell array
%       example2.Resources = {pts, sfc};
%       clear pts sfc
%
%   Example 3:
%       % Create a Steno3D resources
%       pts = steno3d.core.Point(                                    ...
%              'Mesh', {'Vertices', rand(100, 3)}                       ...
%          );
%       % Create a Steno3D Project that contains pts
%       example3 = steno3d.core.Project(                             ...
%              'Title', 'Example 3',                                    ...
%              'Description', 'Project with one or two resources',      ...
%              'Public', false,                                         ...
%              'Resources', pts                                         ...
%          );
%       % Create another Steno3d resource
%       sfc = steno3d.core.Surface(                                  ...
%              'Mesh', {'H1', 0.1*ones(10, 1), 'H2', 0.1*ones(10, 1)}   ...
%          );
%       % Add sfc to the existing Project
%       example3.Resources{end+1} = sfc;
%       clear pts sfc
%
%   Example 4:
%       % Create a Steno3D Project using a plotting function
%       example4 = steno3d.scatter(rand(100, 3));
%       % Add a resource to the project with another plotting function
%       steno3d.volume(example4, [1 1 1], rand(5, 10, 15));
%
%   You can <a href="matlab: steno3d.examples.core.project
%   ">click here</a> to run the above examples or type:
%       steno3d.examples.core.project
%   Then plot the projects with:
%       example1.plot(); % etc...
%
%   See also
%


% Example 1:
% Create a Steno3D Point resource
pts = steno3d.core.Point(                                    ...
    'Mesh', {'Vertices', rand(100, 3)}                       ...
);
% Create a Steno3D Project
example1 = steno3d.core.Project;
% Add the resource to the Project
example1.Resources = pts;
clear pts

% Example 2:
% Create multiple Steno3D resources
pts = steno3d.core.Point(                                    ...
    'Mesh', {'Vertices', rand(100, 3)}                       ...
);
sfc = steno3d.core.Surface(                                  ...
    'Mesh', {'H1', 0.1*ones(10, 1), 'H2', 0.1*ones(10, 1)}   ...
);
% Create a Steno3D Project
example2 = steno3d.core.Project;
% Give the Project a title and description and make it public
example2.Title = 'Example 2';
example2.Description = 'Project with two resources';
example2.Public = true;
% Add the resources to the Project as a cell array
example2.Resources = {pts, sfc};
clear pts sfc

% Example 3:
% Create a Steno3D resources
pts = steno3d.core.Point(                                    ...
    'Mesh', {'Vertices', rand(100, 3)}                       ...
);
% Create a Steno3D Project that contains pts
example3 = steno3d.core.Project(                             ...
    'Title', 'Example 3',                                    ...
    'Description', 'Project with one or two resources',      ...
    'Public', false,                                         ...
    'Resources', pts                                         ...
);
% Create another Steno3d resource
sfc = steno3d.core.Surface(                                  ...
    'Mesh', {'H1', 0.1*ones(10, 1), 'H2', 0.1*ones(10, 1)}   ...
);
% Add sfc to the existing Project
example3.Resources{end+1} = sfc;
clear pts sfc

% Example 4:
% Create a Steno3D Project using a plotting function
example4 = steno3d.scatter(rand(100, 3));
% Add a resource to the project with another plotting function
steno3d.volume(example4, [1 1 1], rand(5, 10, 15));
