function testBumpZip(codainput)
    resp = input('Are all changes committed? ([yes]/no)');
    if ~isempty(resp)
        return
    end
    if ~strcmp([pwd filesep 'testBumpZip'], mfilename('fullpath'))
        fprintf(['Please execute testBumpZip from within steno3dmat '   ...
                 'directory\n']);
        return
    end
    success = testSteno3D();

    if ~success
        fprintf('Tests failed\n');
        return
    end
    
    fprintf('Stashing old release\n');
    system(['mv releases/steno3dmat.zip '                              	...
            'releases/steno3dmat.' steno3d.utils.version() '.zip']);
    system('git add -A');
    system(['git commit -m "Archive steno3dmat.zip to steno3dmat.'      ...
            steno3d.utils.version() '.zip"']);
    
    fprintf('Bumping version\n');
    system(['coda ' codainput]);
    
    fprintf('Zipping files\n');
    cd ..
    zip('steno3dmat/releases/steno3dmat.zip', ...
        {'steno3dmat/+steno3d/*',   ...
         'steno3dmat/+props/*',     ...
         'steno3dmat/installSteno3D.m', ...
         'steno3dmat/uninstallSteno3D.m', ...
         'steno3dmat/upgradeSteno3D.m', ...
         'steno3dmat/testSteno3D.m', ...
         'steno3dmat/LICENSE', ...
         'steno3dmat/README'});
    cd steno3dmat/
    
    fprintf('Committing new version\n');
    system('git add releases/steno3dmat.zip');
    system(['git commit -m "Release steno3dmat.zip version '            ...
            steno3d.utils.versio() '"']);
    