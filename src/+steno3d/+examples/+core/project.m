%Project examples:
%
%   %%%extractexamples
%
%   %%%runexamples
%
%   %%%seealso steno3d.core.Project, steno3d.core.Point, steno3d.core.Surface, steno3d.scatter, steno3d.volume
%


%   Example 1: Create a Steno3D %%%ref[Project](steno3d.core.Project) with one resource
pts = steno3d.core.Point(                                    ...
    'Mesh', {'Vertices', rand(100, 3)}                       ...
);
example1 = steno3d.core.Project;
example1.Resources = pts;
example1.plot;
clear pts;

%%%image /images/core-project-examples-images/core-project-example1.png

%   Example 2: Create a Project with multiple resources
pts = steno3d.core.Point(                                    ...
    'Mesh', {'Vertices', rand(100, 3)}                       ...
);
sfc = steno3d.core.Surface(                                  ...
    'Mesh', {'H1', 0.1*ones(10, 1), 'H2', 0.1*ones(10, 1)}   ...
);
example2 = steno3d.core.Project;
example2.Title = 'Example 2';
example2.Description = 'Project with two resources';
example2.Public = true;
example2.Resources = {pts, sfc};
example2.plot;
clear pts sfc;

%%%image /images/core-project-examples-images/core-project-example2.png

%   Example 3: Create a Project with one resource then append another resource
pts = steno3d.core.Point(                                    ...
    'Mesh', {'Vertices', rand(100, 3)}                       ...
);
example3 = steno3d.core.Project(                             ...
    'Title', 'Example 3',                                    ...
    'Description', 'Project with one or two resources',      ...
    'Public', false,                                         ...
    'Resources', pts                                         ...
);
sfc = steno3d.core.Surface(                                  ...
    'Mesh', {'H1', 0.1*ones(10, 1), 'H2', 0.1*ones(10, 1)}   ...
);
example3.Resources{end+1} = sfc;
example3.plot;
clear pts sfc;

%%%image /images/core-project-examples-images/core-project-example3.png

%   Example 4: Create a project and add to it with high-level functions
proj = steno3d.scatter(rand(100, 3));
steno3d.volume(proj, [1 1 1], rand(5, 10, 15));
proj.plot;

%%%image /images/core-project-examples-images/core-project-example4.png

