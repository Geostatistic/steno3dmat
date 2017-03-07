function proj = combine(varargin)
%COMBINE Combine a list of Steno3D Projects into one Project
%   `project = steno3d.combine(projects)` takes `projects`, a list of Steno3D
%   %%%ref[Projects](steno3d.core.Project), and combines their resources into one `project`
%
%   `project = steno3d.combine(project1, project2, ..., projectN)` combines
%   all the input projects into one `project`.
%
%   Example:
%   %%%codeblock
%       peaks; peaksProj = steno3d.convert(gcf);
%       sphere; sphereProj = steno3d.convert(gcf);
%       comboProj = steno3d.combine(peaksProj, sphereProj);
%       comboProj.Title = 'Two-Surface Project';
%
%
%   See more %%%ref[EXAMPLES](steno3d.examples.combine)
%
%   %%%seealso STENO3D.CORE.PROJECT, STENO3D.CONVERT
%


    steno3d.utils.matverchk();
    narginchk(1, inf);
    if ischar(varargin{end})
        tabLevel = varargin{end};
        varargin = varargin(1:end-1);
    else
        tabLevel = '';
    end
    try
        assert(~isempty(varargin));
        assert(isa(varargin{1}, 'steno3d.core.Project'));
        proj = varargin{1}(:);
        for i = 2:length(varargin)
            proj = [proj; varargin{i}(:)];
        end
    catch
        error('steno3d:combineError', ['steno3d.combine requires '      ...
              'input of type "steno3d.core.Project"']);
    end
    fprintf([tabLevel 'Combining projects...\n'])
    combProj = steno3d.core.Project('Title', 'MATLAB Project');
    for i = 1:length(proj)
        if ~strcmp(proj(i).Title, 'MATLAB Project')
            combProj.Description = [combProj.Description proj(i).Title  ...
                                    ', '];
        end
        combProj.Resources = [combProj.Resources proj(i).Resources];
    end
    if ~isempty(combProj.Description)
        combProj.Description = ['Includes: '                            ...
                                combProj.Description(1:end-2)];
    end
    proj = combProj;
    fprintf([tabLevel '... Project combination complete!\n']);
end

