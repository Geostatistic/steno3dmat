function extractcode(src)
%EXTRACTCODE Extract code from example docstring

    srcfile = which(src);
    srcfid = fopen(srcfile, 'r');
    tempfid = fopen([tempname '.m'], 'w+');
    cl = fgetl(srcfid);
    cont = false;
    while ~isempty(cl) && strcmp(cl(1), '%')
        cl = strtrim(cl(2:end));
        if length(cl) > 1 && strcmp(cl(1:2), '>>')
            cl = strtrim(cl(3:end));
        elseif ~isempty(cl) && ~strcmp(cl(1), '%') && ~cont
            cl = ['% ' cl];
        end
        if length(cl) > 2 && strcmp(cl(end-2:end), '...')
            cont = true;
        else
            cont = false;
        end
        fprintf(tempfid, [escape(cl) '\n']);
        cl = fgetl(srcfid);
    end
    fclose(srcfid);
    fseek(tempfid, 0, -1);
    display(fread(tempfid, inf, '*char')');
    
    okstring = input('Is code above ok? yes/[no]\n?? ', 's');
        
    if strcmp(okstring, 'yes')
        fseek(tempfid, 0, -1);
        srcfid = fopen(srcfile, 'a');
        fprintf(srcfid, '\n');
        fwrite(srcfid, fread(tempfid, inf, '*char'), '*char');
    end
end

function s = escape(s)
    s = strrep(strrep(s, '%', '%%'), '\', '\\');
end

