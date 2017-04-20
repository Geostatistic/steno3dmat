function buildFromSrc()

    items = {'images', 'Makefile', 'conf.py'};

    for i=1:3
        src_exists = exist([pwd filesep 'src' filesep items{i}]);
        docs_exist = exist([pwd filesep 'docs' filesep items{i}]);
        if ~src_exists && docs_exist
            movefile([pwd filesep 'docs' filesep items{i}], [pwd filesep 'src']);
        elseif src_exists && docs_exist
            error('steno3d:buildError',                                     ...
                  ['dual item ' items{i} ' found in docs and src']);
        elseif ~src_exists && ~docs_exist
            error('steno3d:buildError', ['no item ' items{i} ' found']);
        end
    end
    if exist([pwd filesep 'docs'])
        rmdir([pwd filesep 'docs'], 's');
    end
    if exist([pwd filesep 'steno3dmat'])
        rmdir([pwd filesep 'steno3dmat'], 's');
    end
    addpath([pwd filesep 'src']);
    buildFolderFromSrc('docs');
    buildFolderFromSrc('build');
    rmpath([pwd filesep 'src']);
end

function buildFolderFromSrc(buildtype)
%BUILDFROMSRC Builds docs and build directories from src
%
%   BUILDFROMSRC('build') builds the matlab files in ./steno3dmat/
%
%   BUILDFROMSRC('docs') builds the sphinx rst files in ./docs/
%   After building docs, you must run 'make html' from within the docs/
%   directory at the command line. This requires sphinx to be installed.
%


    if ~strcmp(buildtype, 'build') && ~strcmp(buildtype, 'docs')
        error('steno3d:buildError', 'build type must be docs or build');
    end

    ignore = {
        [pwd filesep 'src' filesep 'conf.py'],
        [pwd filesep 'src' filesep 'Makefile'],
        [pwd filesep 'src' filesep 'images']
    };
    if strcmp(buildtype, 'docs')
        ignore = [ignore; {
            [pwd filesep 'src' filesep 'Contents.m'],
            [pwd filesep 'src' filesep '+props' filesep '+examples'],
            [pwd filesep 'src' filesep '+props' filesep '+utils'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep '+convert'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep '+convert'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep 'consolidate.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep 'extractcode.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep 'get.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep 'json2struct.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep 'matverchk.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep 'post.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep 'urlreadpost.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep 'urlreadwrite.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils' filesep 'User.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+examples' filesep 'testall.m'],
        }];
    else
        ignore = [ignore; {
            [pwd filesep 'src' filesep '+props' filesep '+utils' filesep 'autodoc.m'],
            [pwd filesep 'src' filesep '+props' filesep '+utils' filesep 'autodocstring.m'],
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils'],
        }];
    end

    if strcmp(buildtype, 'build')
        builddir = 'steno3dmat';
    else
        builddir = buildtype;
    end
    copyFolder([pwd filesep 'src'], [pwd filesep builddir], pwd, buildtype, ignore);

    if strcmp(buildtype, 'docs')
        movefile([pwd filesep 'src' filesep 'conf.py'], [pwd filesep 'docs']);
        movefile([pwd filesep 'src' filesep 'Makefile'], [pwd filesep 'docs']);
        writeIndex(pwd);
        movefile([pwd filesep 'src' filesep 'images'], [pwd filesep 'docs']);
    else
        copyfile(                                                       ...
            [pwd filesep 'src' filesep '+props' filesep '+utils' filesep 'autodoc.m'], ...
            [pwd filesep 'steno3dmat' filesep '+props' filesep '+utils' filesep 'autodoc.m'] ...
        );
        copyfile(                                                       ...
            [pwd filesep 'src' filesep '+props' filesep '+utils' filesep 'autodocstring.m'], ...
            [pwd filesep 'steno3dmat' filesep '+props' filesep '+utils' filesep 'autodocstring.m'] ...
        );
        copyfile(                                                       ...
            [pwd filesep 'src' filesep '+steno3d' filesep '+utils'], ...
            [pwd filesep 'steno3dmat' filesep '+steno3d' filesep '+utils'] ...
        );
        copyfile([pwd filesep 'LICENSE'], [pwd filesep 'steno3dmat']);
        copyfile([pwd filesep 'README'], [pwd filesep 'steno3dmat']);
    end

end

function copyFolder(source, dest, base, buildtype, ignore)
    if exist(dest)
        error('steno3d:buildError',                                     ...
              ['destination directory ' dest ' exists - please delete']);
    end
    if ~exist(source)
        error('steno3d:buildError',                                     ...
              ['source directory ' source ' does not exist']);
    end

    mkdir(dest);

    items = dir(source);

    for i = 1:length(items)
        name = items(i).name;
        srcitem = [source filesep name];
        destitem = [dest filesep name];

        if strcmp(name, '.') || strcmp(name, '..')
            continue;
        end

        skip = false;
        for j = 1:length(ignore)
            if strcmp(srcitem, ignore{j})
                skip = true;
            end
        end
        if skip
            continue;
        end

        if strcmp(buildtype, 'docs')
            destitem = strrep(strrep(destitem, '+', ''), '.m', '.rst');
        end

        if items(i).isdir
            copyFolder(srcitem, destitem, base, buildtype, ignore);
            continue
        end

        if ~strcmp(name(end-1:end), '.m')
            error('steno3d:buildError',                                 ...
                  ['unrecognized source file ' name]);
        end

        srcfid = fopen(srcitem, 'r');
        destfid = fopen(destitem, 'w');

        if strcmp(buildtype, 'docs')
            docname = strrep(destitem, [base filesep 'docs'], '');
            docname = strrep(docname, '.rst', '');
            docname = strrep(docname, filesep, '');
            newline = sphinxHeader(lower(docname));
            newline = [newline '\n\n'];
            fprintf(destfid, newline);
        end

        srcline = fgetl(srcfid);
        while isempty(srcline) || all(srcline ~= -1)
            if strcmp(buildtype, 'build')
                newline = buildFormat(srcline, srcitem);
            else
                newline = sphinxFormat(srcline, srcitem);
                if newline == -1
                    break;
                end
            end
            newline = [strrep(newline, '%', '%%') '\n'];
            fprintf(destfid, newline);
            srcline = fgetl(srcfid);
        end

        fclose(srcfid);
        fclose(destfid);
    end
end

function writeIndex(basedir)
    readmefid = fopen([basedir filesep 'README.rst'], 'r');
    indexfid = fopen([basedir filesep 'docs' filesep 'index.rst'], 'w');

    fprintf(indexfid, '.. _index:\n\n');
    fprintf(indexfid, 'Steno3D MATLAB Client\n=====================\n\n');
    srcline = fgetl(readmefid);
    while isempty(srcline) || all(srcline ~= -1)
        fprintf(indexfid, [escape(srcline) '\n']);
        srcline = fgetl(readmefid);
    end


    fprintf(indexfid, '\nContents\n********\n\n');
    fprintf(indexfid, '.. toctree::\n    :maxdepth: 2\n\n');
    fprintf(indexfid, '    steno3d/Contents\n');
    fprintf(indexfid, '    props/Contents\n');
    fprintf(indexfid, '    installSteno3D\n');
    fprintf(indexfid, '    upgradeSteno3D\n');
    fprintf(indexfid, '    uninstallSteno3D\n');
    fprintf(indexfid, '    testSteno3D\n\n');
    fprintf(indexfid, 'Index\n*****\n\n* :ref:`genindex`\n');
    fclose(readmefid);
    fclose(indexfid);
end


function absfuncname = absname(srcitem)
    absfuncname = strsplit(srcitem, ['src' filesep]);
    absfuncname = absfuncname{2};
    absfuncname = strrep(absfuncname, '.m', '');
    absfuncname = strrep(absfuncname, filesep, '.');
    absfuncname = strrep(absfuncname, '+', '');
end

function header = sphinxHeader(filestring)
    if ~strcmp(filestring, 'contents')
        filestring = strrep(filestring, 'contents', '');
    end
    header = ['.. _' filestring ':'];
end

function srcline = buildFormat(srcline, srcitem)

    srcline = strrep(srcline, '\', '\\');

    %Extract examples
    if strfind(srcline, '%%%extractexamples')
        exfid = fopen(srcitem, 'r');
        exline = fgetl(exfid);
        while ~isempty(exline)
            exline = fgetl(exfid);
        end
        while isempty(exline)
            exline = fgetl(exfid);
        end
        srcline = '';
        incomment = true;
        while isempty(exline) || all(exline ~= -1)
            if isempty(exline)
                srcline = [srcline '%\n'];
                incomment = true;
            elseif length(exline) >= 8 && strcmp(exline(1:8), '%%%image')
            elseif incomment && length(exline) >= 1 && strcmp(exline(1), '%')
                if any(exline(2:min(end, 4)) ~= ' ')
                    error('steno3d:builderror', ['bad example line: ' escape(exline)]);
                end
                srcline = [srcline exline '\n'];
            elseif incomment && length(exline) >= 1 && ~strcmp(exline(1), '%')
                incomment = false;
                srcline = [srcline '%\n%       ' exline '\n'];
            elseif ~incomment
                srcline = [srcline '%       ' exline '\n'];
            else
                error('steno3d:builderror', ['bad example line: ' escape(exline)]);
            end
            exline = fgetl(exfid);
        end
        srcline = [srcline '%'];
        fclose(exfid);
    end

    %Run example text
    if strfind(srcline, '%%%runexamples')
        srcline = [                                                     ...
            '%   You can <a href="matlab: ' absname(srcitem) '">click ' ...
            'here</a> to run the above examples or type:\n'             ...
            '%       ' absname(srcitem) '\n'                            ...
            '%   Then plot the projects with:\n'                        ...
            '%       example1.plot(); % etc...\n%'                      ...
        ];
    end

    %version check
    vercheck = [
        '(<a href="matlab: '                                    ...
        'fprintf(''Required version: 2014b\\n''); '             ...
        'fprintf([''Your version: '' version(''-release'') ''\\n'']); '...
        'if verLessThan(''matlab'', ''8.4'') '                  ...
        'fprintf(''Please upgrade to the latest version of MATLAB.\\n''); '...
        'else '                                                 ...
        'fprintf(''MATLAB version is valid.\\n''); '            ...
        'end">Check your version</a>)'                          ...
    ];
    srcline = strrep(srcline, '%%%versioncheck', vercheck);

    %notes
    srcline = strrep(srcline, '%%%note', 'Note:');

    %code blocks
    srcline = strrep(srcline, '%%%codeblock', '');

    %see also references
    if length(srcline) >=14 && strcmp(srcline(1:14), '%   %%%seealso')
        seealsos = strsplit(srcline);
        srcline = '%   See also ';
        for i = 3:length(seealsos)
            ref = upper(seealsos{i});
            lastline = strsplit(srcline, '\\n');
            lastline = lastline{end};
            if length(lastline) + length(ref) > 80
                ref = ['\n%   ' ref];
            end
            srcline = [srcline ref ' '];
        end
        srcline = srcline(1:end-1);
    end
    if strfind(srcline, '%%%seealso')
        error('steno3d:builderror', ['bad see also format: ' escape(srcline)]);
    end

    %bold
    srcline = regexprep(srcline, '%%%bold\[(?<text>.*?)\]', '$<text>');

    %code
    if mod(length(strfind(srcline, '`')), 2) ~= 0
        error('steno3d:builderror', ['code replacement error: ' escape(srcline)]);
    end
    srcline = regexprep(srcline, '(?<prefix>([^(:>)]|^))`(?<code>.*?)`', '$<prefix>${upper($<code>)}');

    %references/func/class/matlabrefs
    srcline = regexprep(srcline, '%%%(func|class|ref|matlabref)\[(?<name>.*?)\]\((?<ref>.*?)\)', '<a href="matlab: help $<ref>">$<name></a>');

    %link
    srcline = regexprep(srcline, '%%%link\[(?<name>.*?)\]\((?<ref>.*?)\)', '<a href="matlab: web(''$<ref>'',''-browser'')">$<name></a>');

    %props doc
    if strfind(srcline, '%%%properties')
        obj = eval(absname(srcitem));
        srcline = [props.utils.autodocstring(obj, 'matlab') '%'];
    end

    %toctree
    if strfind(srcline, '%%%tree')
        srcline = '';
    end

    %images
    if strfind(srcline, '%%%image')
        srcline = '';
    end

    if strfind(srcline, '%%%')
        error('steno3d:builderror', ['tag replacement failed: ' escape(srcline)]);
    end
end

function srcline = sphinxFormat(srcline, srcitem)
    %Deal with first line (function or class definition)
    if length(srcline) >= 8 && strcmp(srcline(1:8), 'function')
        funcname = strsplit(srcline, '(');
        funcname = funcname{1};
        funcname = strsplit(funcname);
        funcname = funcname{end};
        absfuncname = absname(srcitem);
        srcline = [funcname '\n' repmat('=', 1, length(funcname)) '\n\n'];
        srcline = [srcline '.. function:: ' absfuncname '(...)\n'];
        return
    end
    if length(srcline) >= 8 && strcmp(srcline(1:8), 'classdef')
        funcname = strsplit(srcline);
        if strcmp(funcname{2}, '(Abstract)')
            funcname = funcname{3};
        else
            funcname = funcname{2};
        end
        absfuncname = strsplit(srcitem, ['src' filesep]);
        absfuncname = absfuncname{2};
        absfuncname = strrep(absfuncname, '.m', '');
        absfuncname = strrep(absfuncname, filesep, '.');
        absfuncname = strrep(absfuncname, '+', '');
        srcline = [funcname '\n' repmat('=', 1, length(funcname)) '\n\n'];
        srcline = [srcline '.. class:: ' absfuncname '\n'];
        return
    end

    %Deal with end of comment block
    if isempty(srcline) || ~strcmp(srcline(1), '%')
        srcline = -1;
        return
    end

    %Deal with empty comment lines
    if strcmp(srcline, '%')
        srcline = '';
        return
    end

    %Deal with comment blocks - should either have no space after % or 3 spaces
    if length(srcline) >= 2 && ~strcmp(srcline(2), ' ')
        srcline = srcline(2:end);
        docstring = strsplit(srcline, ':');
        if length(docstring) == 1
            firstspace = strfind(docstring{1}, ' ');
            srcline = [srcline(firstspace(1)+1:end) '\n'];
        else
            srcline = [docstring{1} '\n' repmat('=', 1, length(docstring{1}))];
            srcline = [srcline '\n' strjoin(docstring(2:end), '') '\n'];
        end
    elseif length(srcline) > 4 && strcmp(srcline(1:4), '%   ')
        srcline = srcline(5:end);
    else

        error('steno3d:builderror', ['bad source line: ' escape(srcline) ' in file ' srcitem]);
    end

    %Extract examples
    if strfind(srcline, '%%%extractexamples')
        exfid = fopen(srcitem, 'r');
        exline = fgetl(exfid);
        while ~isempty(exline)
            exline = fgetl(exfid);
        end
        while isempty(exline)
            exline = fgetl(exfid);
        end
        srcline = '';
        incomment = true;
        while isempty(exline) || all(exline ~= -1)
            if isempty(exline)
                srcline = [srcline '\n'];
                incomment = true;
            elseif length(exline) >= 8 && strcmp(exline(1:8), '%%%image')
                srcline = [srcline strrep(exline, '%%%image', '.. image::') '\n'];
            elseif incomment && length(exline) >= 1 && strcmp(exline(1), '%')
                if any(exline(2:min(end, 4)) ~= ' ')
                    error('steno3d:builderror', ['bad example line: ' escape(exline)]);
                end
                srcline = [srcline exline(5:end) '\n'];
            elseif incomment && length(exline) >= 1 && ~strcmp(exline(1), '%')
                incomment = false;
                srcline = [srcline '\n.. code::\n\n    ' exline '\n'];
            elseif ~incomment
                srcline = [srcline '    ' exline '\n'];
            else
                error('steno3d:builderror', ['bad example line: ' escape(exline)]);
            end
            exline = fgetl(exfid);
        end
        fclose(exfid);
    end

    %Run example text
    if strfind(srcline, '%%%runexamples')
        srcline = [                                                     ...
            'You can run the above examples with:\n\n'                  ...
            '.. code::\n\n'                                             ...
            '    ' absname(srcitem) '\n\n'                              ...
            'Then plot the projects with:\n\n'                          ...
            '.. code::\n\n'                                             ...
            '    example1.plot(); % etc...\n\n'                         ...
        ];
    end

    %version check
    srcline = strrep(srcline, '%%%versioncheck', '');

    %notes
    srcline = strrep(srcline, '%%%note', '.. note::\n');

    %code blocks
    srcline = strrep(srcline, '    %%%codeblock', '\n    .. code::\n');
    srcline = strrep(srcline, '%%%codeblock', '\n.. code::\n');

    %see also references
    if length(srcline) >=10 && strcmp(srcline(1:10), '%%%seealso')
        seealsos = strsplit(srcline);
        srcline = 'See also ';
        for i = 2:length(seealsos)
            ref = strrep(seealsos{i}, ',', '');
            srcline = [srcline ':ref:`' ref ' <' lower(strrep(ref, '.', '')) '>`, '];
        end
        srcline = srcline(1:end-2);
    end

    %bold
    srcline = regexprep(srcline, '%%%bold\[(?<text>.*?)\]', '**$<text>**');

    %code
    if mod(length(strfind(srcline, '`')), 2) ~= 0
        error('steno3d:builderror', ['code replacement error: ' escape(srcline)]);
    end
    srcline = regexprep(srcline, '(?<prefix>([^(:>)]|^))`(?<code>.*?)`', '$<prefix>:code:`$<code>`');

    %references
    srcline = regexprep(srcline, '%%%ref\[(?<name>.*?)\]\((?<ref>.*?)\)', ':ref:`$<name> <${strrep(lower($<ref>), ''.'', '''')}>`');

    %func/class
    srcline = regexprep(srcline, '%%%(func|class)\[(?<name>.*?)\]\((?<ref>.*?)\)', ':$1:`$<ref>`');

    %matlabref
    srcline = regexprep(srcline, '%%%matlabref\[(?<name>.*?)\]\((?<ref>.*?)\)', '**$<name>**');

    %link
    srcline = regexprep(srcline, '%%%link\[(?<name>.*?)\]\((?<ref>.*?)\)', '`$<name> <$<ref>>`_');

    %props
    if strfind(srcline, '%%%properties')
        obj = eval(absname(srcitem));
        srcline = props.utils.autodocstring(obj, 'sphinx');
    end

    %fix up Contents.m files
    if ~isempty(srcline) && strcmp(srcline(1), ':') && strcmp(srcitem(end-9:end), 'Contents.m')
        srcline = ['\n ' srcline];
    end

    if strfind(srcline, '%%%tree')
        sources = strsplit(srcline, '%%%tree');
        sources = strrep(sources{2}, ' ', '\n    ');
        srcline = ['\n.. toctree::\n    :maxdepth: 2\n    :hidden:\n' sources];
    end

    %image
    if strfind(srcline, '%%%image')
        srcline = strrep(srcline, '%%%image', '.. image::');
        srcline = ['|\n\n' srcline '\n\n|'];
    end

    srcline = strrep(srcline, '''@', '''\\@');

    if strfind(srcline, '%%%')
        error('steno3d:builderror', ['tag replacement failed: ' escape(srcline)]);
    end
end


function s = escape(s)
    s = strrep(strrep(s, '%', '%%'), '\', '\\');
end

