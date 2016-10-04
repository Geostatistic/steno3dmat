function upgradeSteno3D()
%INSTALLSTENO3D add steno3d to the MATLAB environment
%
%   INSTALLSTENO3D() copies steno3dmat to '~/.steno3d_client/` and adds
%   it to the default MATLAB path
%   INSTALLSTENO3D(FOLDER) copies steno3dmat to FOLDER and adds it to the
%   default MATLAB path
%
%   The default install location for 'steno3dmat/' is '~/.steno3d_client/'
%   corresponding to the default location for other saved steno3d files.
%   However, you may wish to save it to the standard MATLAB toolbox
%   location. To do so, use:
%
%   >> installSteno3D([matlabroot filesep 'toolbox'])


    narginchk(0, 0);
    
    upgradepath = strsplit(mfilename('fullpath'), filesep);
    steno3dfolder = strjoin(upgradepath(1:end-1), filesep);
    
    if isdir([steno3dfolder '+props']) && isdir([steno3dfolder '+steno3d'])
        fprintf('Existing Steno3D installation found.');
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
    
    upgradefolder = [steno3dfolder 'temp_upgrade_dir' filesep];
    
    fname = [upgradefolder 'steno3dmat.zip'];
    
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
        fprintf(['\nError downloading the latest Steno3D release.\n'...
                 'For alternative installation instructions please '...
                 'checkout \nthe <a href="matlab: web(''https://'   ...
                 'github.com/3ptscience/steno3dmat/master/'','      ...
                 ' ''-browser'')">github page</a>\n\n'              ...
                 'Upgrade failed\n']);
        return
    end
    
    fprintf('Unzipping archive...\n');
    unzip(fname, upgradefolder);
    
    fprintf('Backing up old files...\n');
    copyfile(steno3dfolder, [upgradefolder 'steno3dmat_backup'])
    
    fprintf('Copying new files...\n');
    copyfile([upgradefolder 'steno3dmat'], steno3dfolder)
    
    fprintf('Running test...\n');
    success = false;
    try
        success = testSteno3D();
    catch ME
        if strcmp(ME.identifier, 'MATLAB:UndefinedFunction')
            addpath(steno3dfolder);
            try
                success = testSteno3D();
            catch
            end
            rmpath(steno3dfolder);
        end
    end
    
    
    if ~success
        fprintf('Tests failed... reverting to old version.\n');v
        copyfile([upgradefolder 'steno3dmat_backup'], steno3dfolder);
        fprintf(['Upgrade failed. Please file an issue on '             ...
                 '<a href="matlab: web(''https://github.com/3ptscience/'...
                 'steno3dmat/issues'', ''-browser'')">github</a>'       ...
                 '\nwith your MATLAB version and any other details you '...
                 'can provide.\n\n'])
    else
        fprintf('Success!\n\n');
    end
    remove = input('Delete temporary upgrade files? ([yes]/no)', 's');
    
    if isempty(remove) || strcmp(remove, 'yes')
        fprintf(['Deleting temporary directory: ' upgradefolder '\n'])
        rmdir(upgradefolder)
    end
    
end
