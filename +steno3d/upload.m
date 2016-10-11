function upload(fh, public)
% UPLOAD Convert Matlab figure or axes to Steno3D project and upload

    if isa(fh, 'steno3d.core.Project')
        projs = fh;
    elseif isgraphics(fh) && isa(fh.UserData, 'steno3d.core.Project')
        projs = fh.UserData;
    else
        try
            projs = steno3d.convert(fh);
        catch
            error('steno3d:uploadError', ['Invalid upload input. Please'...
                  'give a figure, axes, or, Steno3D project.'])
        end
    end
    for i=1:length(projs)
        if nargin == 2
            projs(i).Public = public;
        end
        projs(i).upload();
    end

end