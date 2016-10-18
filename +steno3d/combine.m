function proj = combine(varargin)
%COMBINE Combine a list of Steno3D Projects into one Project
%   PROJECT = STENO3D.COMBINE(PROJECTS) takes a list of Steno3D PROJECTS
%   and combines their resources into one PROJECT
%
%   PROJECT = STENO3D.COMBINE(PROJECT1, PROJECT2, ..., PROJECTN) combines
%   all the input projects into one PROJECT.
%
%   Example:
%       peaks; peaksProj = steno3d.convert(gcf);
%       sphere; sphereProj = steno3d.convert(gcf);
%       comboProj = STENO3D.COMBINE(peaksProj, sphereProj);
%       assert(length(comboProj.Resources) > 1)
%       comboProj.Title = 'Two surface project';
%       comboProj.Public = true;
%       comboProj.upload();
%
%   See also STENO3D.CORE.PROJECT, STENO3D.CONVERT
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
        error('steno3d:convertError', ['steno3d.utils.combine requires '...
              'input of type "steno3d.core.Project"']);
    end

    fprintf([tabLevel 'Combining projects...\n'])
    combProj = steno3d.core.Project('Title', 'MATLAB Project');
    
    for i = 1:length(proj)
        if ~strcmp(proj(i).Title, 'MATLAB Project')
            combProj.Description = [combProj.Description proj(i).Title ', '];
        end
        combProj.Resources = [combProj.Resources proj(i).Resources];
    end
    
    if ~isempty(combProj.Description)
        combProj.Description = ['Includes: '                            ...
                                combProj.Description(1:end-2)];
    end
    proj = combProj;


end

