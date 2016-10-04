function [s, json] = json2struct(json)
%JSON2STRUCT Converts json strings to matlab structs
%
% This is used to parse the output of urlread. It is limited to only the
% functionality required by steno3d.

    if strcmp(json(1:2), '{}')
        s = struct();
        json = json(3:end);
        return
    elseif strcmp(json(1:2), '{"')
        s = struct();
        json = json(2:end);
    elseif strcmp(json(1:3), '[{"')
        s = {};
        json = json(2:end);
        while true
            [subs, rem] = steno3d.utils.json2struct(json);
            s{end+1} = subs;
            json = rem;
            if strcmp(json(1), ']')
                json = json(2:end);
                return
            end
        end
    else
        error('steno3d:jsonError','Invalid JSON encountered');
    end

    while true
        if strcmp(json(1:2), ', ')
            json = json(3:end);
        end
        if ~strcmp(json(1), '"')
            error('steno3d:jsonError','Invalid JSON encountered');
        end
        json = json(2:end);
        ind = strfind(json, '"');
        field = strrep(json(1:ind(1)-1), ':', '_');
        json = json(ind(1)+1:end);
        
        if strcmp(json(1:2), ': ')
            json = json(3:end);
        elseif strcmp(json(1), ':')
            json = json(2:end);
        else
            error('steno3d:jsonError','Invalid JSON encountered');
        end
        if strcmp(json(1), '[')
            val = {};
            json = json(2:end);
            while true
                if strcmp(json(1), '[')
                    error('steno3d:jsonError','Invalid JSON encountered');
                elseif strcmp(json(1), '"')
                    json = json(2:end);
                    ind = strfind(json, '"');
                    val = [val {json(1:ind(1)-1)}];
                    json = json(ind(1)+1:end);

                elseif strcmp(json(1), '{')
                    [subs, rem] = steno3d.utils.json2struct(json);
                    val = [val {subs}];
                    json = rem;
                else
                    cind = strfind(json, ',');
                    bind = strfind(json, ']');
                    if isempty(cind)
                        ind = bind;
                    else
                        ind = min(cind(1), bind(1));
                    end
                    v = json(1:ind(1)-1);
                    if strcmpi(v, 'true')
                        v = true;
                    elseif strcmpi(v, 'false')
                        v = false;
                    else
                        v = str2double(v);
                    end
                    val = [val v];
                    json = json(ind(1):end);
                end
                if strcmp(json(1), ']')
                    json = json(2:end);
                    break
                elseif ~strcmp(json(1:2), ', ')
                    error('steno3d:jsonError','Invalid JSON encountered');
                else
                    json = json(3:end);
                end
            end
        elseif strcmp(json(1), '{')
            [val, rem] = steno3d.utils.json2struct(json);
            json = rem;
        elseif strcmp(json(1), '"')
            json = json(2:end);
            ind = strfind(json, '"');
            val = json(1:ind(1)-1);
            json = json(ind(1)+1:end);
        else
            cind = strfind(json, ',');
            bind = strfind(json, '}');
            if isempty(cind)
                ind = bind;
            else
                ind = min(cind(1), bind(1));
            end
            val = json(1:ind(1)-1);
            if strcmpi(val, 'true')
                val = true;
            elseif strcmpi(val, 'false')
                val = false;
            else
                val = str2double(val);
            end
            
            json = json(ind(1):end);
        end
        try
            s.(field) = val;
        catch
            fprintf(['Ignoring JSON field "' field '" - hopefully '     ...
                     'this does not cause trouble...\n']);
        end
        if strcmp(json(1), '}')
            json = json(2:end);
            break
        elseif strcmp(json(1:3), ', "')
            json = json(3:end);
        elseif strcmp(json(1:2), ',"')
            json = json(2:end);
        else
            error('steno3d:jsonError','Invalid JSON encountered');
        end
    end
end

