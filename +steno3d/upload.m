function upload(fh, public, combine)
% UPLOAD uploads to steno3d.com

    if nargin < 2
        public = false;
    end
    if nargin < 3
        combine = false;
    end
    
    projs = steno3d.fig2steno(fh, public, combine);
    for i=1:length(projs)
        projs(i).upload()
    end

end