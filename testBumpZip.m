function testBumpZip()
%TESTBUMPZIP Helper function to run tests, bump version, and zip files

    resp = input('Are docs built? ([yes]/no)', 's');
    if ~isempty(resp) && ~strcmp(resp, 'yes')
        return
    end
    resp = input('Are all changes committed? ([yes]/no)', 's');
    if ~isempty(resp) && ~strcmp(resp, 'yes')
        return
    end
    if ~strcmp([pwd filesep 'testBumpZip'], mfilename('fullpath'))
        fprintf(['Please execute testBumpZip from within steno3dmat '   ...
                 'directory\n']);
        return
    end
    testpath = which('testSteno3D');
    if strfind(testpath, 'build')

        fprintf('Running tests\n');
        success = testSteno3D();

        if ~success
            fprintf('Tests failed\n');
            return
        end
    else
        fprintf(['Steno3D path must be build directory:\n' testpath '\n']);
        return
    end

    if exist('releases/steno3dmat.zip')
        prevVer = steno3d.version();
        fprintf(['Old version: ' prevVer '\n'])
        fprintf('Please bump the version then continue\n');
        pause

        fprintf('Stashing old release locally\n');
        system(['mv releases/steno3dmat.zip '                              	...
                'releases/steno3dmat.' prevVer '.zip']);
    end

    fprintf('Zipping files\n');
    cd ..
    zip('steno3dmat/releases/steno3dmat.zip',                           ...
        {'steno3dmat/build/+steno3d/*',                                 ...
         'steno3dmat/build/+props/*',                                   ...
         'steno3dmat/build/installSteno3D.m',                           ...
         'steno3dmat/build/uninstallSteno3D.m',                         ...
         'steno3dmat/build/upgradeSteno3D.m',                           ...
         'steno3dmat/build/testSteno3D.m',                              ...
         'steno3dmat/LICENSE',                                          ...
         'steno3dmat/README'});
    cd steno3dmat/

    fprintf('Add releases/steno3dmat.zip to the release on github\n')
