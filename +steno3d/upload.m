function upload(fh)
% UPLOAD uploads to steno3d.com

    projs = steno3d.fig2steno(fh);
    for i=1:length(projs)
        projs(i).upload()
    end

end