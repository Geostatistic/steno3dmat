function upgradeSteno3D(beta)
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


    narginchk(0, 1);
    
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
    
    
    if nargin == 0
        beta = false;
    elseif strcmpi(beta, 'beta') || strcmpi(beta, 'pre')
        beta = true;
    end 
    
    
    if ~islogical(beta)
        error('steno3d:upgradeError', 'Invalid input argument');
    end
    
    fname = [upgradefolder 'steno3dmat.zip'];
    if beta
        try
            fprintf('Downloading latest beta version... ');
            urlwrite(['https://raw.githubusercontent.com/3ptscience/'   ...
                      'steno3dmat/master/releases/steno3dmat.beta.zip'],...
                     fname);
        catch
            fprintf('no beta version found.\n');
            beta = false;
        end
    end
    
    if ~beta
        fprintf('Downloading latest stable version...');
        try
            urlwrite(['https://raw.githubusercontent.com/3ptscience/'   ...
                      'steno3dmat/master/releases/steno3dmat.zip'], ...
                     fname);
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
