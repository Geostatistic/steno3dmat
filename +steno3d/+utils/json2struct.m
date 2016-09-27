function [ s, json ] = json2struct( json )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    s = struct();
    if strcmp(json(1:2), '{}')
        json = json(3:end);
        return

    elseif ~strcmp(json(1:2), '{"')
        error('steno3d:jsonError','Invalid JSON encountered');
    end
    json = json(2:end);

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
        if ~strcmp(json(1:2), ': ')
            error('steno3d:jsonError','Invalid JSON encountered');
        end
        json = json(3:end);
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
                    val = [val str2double(json(1:ind(1)-1))];
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
            val = str2double(json(1:ind(1)-1));
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
        elseif ~strcmp(json(1:3), ', "')
            error('steno3d:jsonError','Invalid JSON encountered');
        else
            json = json(3:end);
        end
    end
end

