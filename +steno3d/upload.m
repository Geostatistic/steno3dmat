function upload(fh, public)
% UPLOAD uploads to steno3d.com

    if nargin < 2
        public = false;
    end
    
    projs = steno3d.convert(fh);
    for i=1:length(projs)
        projs(i).upload()
    end

end