function upload(fh, public)
% UPLOAD Convert Matlab figure or axes to Steno3D project and upload

    if nargin < 2
        public = false;
    end
    
    projs = steno3d.convert(fh);
    for i=1:length(projs)
        projs(i).public = public;
        projs(i).upload();
    end

end