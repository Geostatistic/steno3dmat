function upgradeSteno3D()
%`upgradeSteno3D` Download and install the latest version of Steno3D
%   `upgradeSteno3D()` checks for an existing Steno3D installation, downloads
%   the latest release of Steno3D to a temporary directory, tests the new
%   version of Steno3D, and if tests pass, replaces the old version.
%
%   On login, Steno3D checks if the current version is out of date. If so,
%   the user will be prompted to `upgradeSteno3D()`
%
%   %%%seealso steno3d.login, uninstallSteno3D, installSteno3D, testSteno3D
%


    narginchk(0, 0);

    upgradepath = strsplit(mfilename('fullpath'), filesep);
    steno3dmatfolder = strjoin(upgradepath(1:end-1), filesep);
    steno3dfolder = strjoin(upgradepath(1:end-2), filesep);

    if isdir([steno3dmatfolder filesep '+props']) &&                    ...
            isdir([steno3dmatfolder filesep '+steno3d'])
        fprintf('Existing Steno3D installation found.\n');
    else
        fprintf(['Existing Steno3D installation could not be found. \n' ...
                 'Please ensure upgradeSteno3D.m is located inside \n'  ...
                 'the original steno3dmat/ installation folder. \nIf '  ...
                 'upgrade issues persist, you may download and \n'      ...
                 'reinstall Steno3D from <a href="matlab: web('         ...
                 '''https://github.com/3ptscience/steno3dmat/master/'','...
                 ' ''-browser'')">github</a>\n\nUpgrade failed\n']);
         return
    end

    upgradefolder = [steno3dfolder filesep 'steno3dmat_upgrade'];
    if ~exist(upgradefolder, 'file')
        mkdir(upgradefolder);
    end

    fname = [upgradefolder filesep 'steno3dmat.zip'];

    fprintf('Downloading latest version...');
    try
        resp_str = urlread(['https://api.github.com/repos/3ptscience/'  ...
                            'steno3dmat/releases/latest']);
        resp = steno3d.utils.json2struct(resp_str);
        if ~isempty(resp.assets)
            for i = 1:length(resp.assets)
                if strcmp(resp.assets{i}.name, 'steno3dmat.zip')
                    zipurl = resp.assets{i}.browser_download_url;
                    break
                end
            end
        else
            zipurl = resp.zipball_url;
        end
        urlwrite(zipurl, fname);

        fprintf('success!\n');
    catch
        fprintf(['\nError downloading the latest Steno3D release.\n'    ...
                 'For alternative installation instructions please '    ...
                 '\nsee the <a href="matlab: web(''https://'            ...
                 'github.com/3ptscience/steno3dmat/master/'','          ...
                 ' ''-browser'')">github page</a>.\n\n'                 ...
                 'Upgrade failed\n']);
        return
    end

    fprintf('Unzipping archive...\n');
    unzip(fname, upgradefolder);

    fprintf('Backing up old files...\n');
    backupfolder = [upgradefolder filesep 'steno3dmat_backup'];
    copyfile(steno3dmatfolder, backupfolder)

    fprintf('Copying new files...\n');
    copyfile([upgradefolder filesep 'steno3dmat'], steno3dmatfolder)

    fprintf('Running test...\n');
    success = false;
    try
        success = testSteno3D();
    catch ME
        if strcmp(ME.identifier, 'MATLAB:UndefinedFunction')
            addpath(steno3dmatfolder);
            try
                success = testSteno3D();
            catch
            end
            rmpath(steno3dmatfolder);
        end
    end


    if ~success
        revert = input(['Tests failed... revert to old version? '       ...
                        '([yes]/no)'], 's');
        if isempty(revert) || strcmp(revert, 'yes')
            copyfile(backupfolder, steno3dmatfolder);
            fprintf('Upgrade failed. ');
        end
        fprintf(['Please file an issue on '             ...
                 '<a href="matlab: web(''https://github.com/3ptscience/'...
                 'steno3dmat/issues'', ''-browser'')">github</a>'       ...
                 '\nwith your MATLAB version and any other details you '...
                 'can provide.\n\n'])
    else
        fprintf('Success!\n\n');
    end
    remove = input('Delete temporary upgrade files? ([yes]/no)', 's');

    if isempty(remove) || strcmp(remove, 'yes')
        fprintf('Deleting temporary directory:\n%s\n', upgradefolder);
        rmdir(upgradefolder, 's');
    end
end
