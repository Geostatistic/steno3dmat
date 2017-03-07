classdef (Abstract) CompositeResource < steno3d.core.UserContent
%COMPOSITERESOURCE Abstract base class for Steno3D resources (Point, Line, etc)
%   Composite resources are the building blocks of Steno3D %%%ref[Projects](steno3d.core.Project). They
%   include %%%ref[Point](steno3d.core.Point), %%%ref[Line](steno3d.core.Line), %%%ref[Surface](steno3d.core.Surface), and %%%ref[Volume](steno3d.core.Volume). They all must have a mesh to
%   define their geometry. They may also have data bound to the mesh, image
%   textures, and options.
%
%   %%%seealso STENO3D.CORE.POINT, STENO3D.CORE.LINE, STENO3D.CORE.SURFACE,
%   STENO3D.CORE.VOLUME, STENO3D.CORE.USERCONTENT, STENO3D.CORE.PROJECT
%


    methods
        function obj = CompositeResource(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end

        function n = nbytes(obj)
        %NBYTES Estimate of the size of the resource in bytes.
            n = 0;
            if length(obj.findprop('Mesh')) == 1
                n = n + obj.Mesh.nbytes();
            end
            if length(obj.findprop('Data')) == 1
                for i = 1:length(obj.Data)
                    n = n + obj.Data{i}.Data.(                          ...
                        [obj.PROP_PREFIX 'Array']).nbytes();
                end
            end
            if length(obj.findprop('Textures')) == 1
                for i = 1:length(obj.Textures)
                    n = n + obj.Textures{i}.(                           ...
                        [obj.PROP_PREFIX 'Image']).nbytes();
                end
            end
        end
    end

    methods (Hidden)
        function validator(obj)
            mc = metaclass(obj);
            cls = strsplit(mc.Name, '.');
            cls = cls{end};
            for i = 1:length(obj.Data)
                if strcmpi(obj.Data{i}.Location, 'N')
                    validLength = obj.Mesh.nN;
                elseif strcmpi(obj.Data{i}.Location, 'CC')
                    validLength = obj.Mesh.nC;
                else
                    error('steno3d:resourceError', ['Data location '    ...
                          'must be "N" or "CC"']);
                end
                if length(obj.Data{i}.Data.Array) ~= validLength
                    error('steno3d:resourceError', ['Length mismatch '  ...
                          'of data array ' num2str(i) ' of ' cls        ...
                          ' object: ' obj.Title '\nArray Length: '      ...
                          num2str(length(obj.Data{i}.Data.Array))       ...
                          '\nExpected Length for location '             ...
                          obj.Data{i}.Location ': ' num2str(validLength)]);
                end
            end
            if steno3d.utils.User.isLoggedIn()
                user = steno3d.utils.User.currentUser();
                for i = 1:length(obj.Data)
                    sz = obj.Data{i}.Data.(                             ...
                         [obj.PROP_PREFIX 'Array']).nbytes;
                    if sz > user.FileSizeLimit
                        error('steno3d:resourceError',                  ...
                              ['File size ' num2str(sz) ' bytes '       ...
                               'exceeds file limit of '                 ...
                               num2str(user.FileSizeLimit) ' bytes']);
                    end
                end
                if length(obj.findprop('Textures')) == 1
                    for i = 1:length(obj.Textures)
                        sz = obj.Textures{i}.(                          ...
                             [obj.PROP_PREFIX 'Image']).nbytes;
                        if sz > user.FileSizeLimit
                            error('steno3d:resourceError',              ...
                                  ['Image file size ' num2str(sz)       ...
                                   ' bytes exceeds file limit of '      ...
                                   num2str(user.FileSizeLimit) ' bytes']);
                        end
                    end
                end
            end
        end

        function uploadChildren(obj, tabLevel)
            if length(obj.findprop('Mesh')) == 1
                obj.Mesh.uploadContent(tabLevel)
            end
            if length(obj.findprop('Data')) == 1
                for i = 1:length(obj.Data)
                    obj.Data{i}.Data.uploadContent(tabLevel)
                end
            end
            if length(obj.findprop('Textures')) == 1
                for i = 1:length(obj.Textures)
                    obj.Textures{i}.uploadContent(tabLevel)
                end
            end
        end

        function args = uploadArgs(obj)
            args = {'mesh', ['{"uid": "' obj.Mesh.PR__uid '"}']};
            data = '';
            for i = 1:length(obj.Data)
                data = [data '{"location": "' obj.Data{i}.Location      ...
                        '", "uid": "' obj.Data{i}.Data.PR__uid          ...
                        '"},'];
            end
            args = [args, {'data', ['[' data(1:end-1) ']']}];
            if length(obj.findprop('Textures')) == 1
                tex = '';
                for i = 1:length(obj.Textures)
                    tex = [tex '{"uid": "'                              ...
                           obj.Textures{i}.PR__uid '"},'];
                end
                args = [args, {'textures', ['[' tex(1:end-1) ']']}];
            end
            args = [args, uploadArgs@steno3d.core.UserContent(obj)];
        end
    end
end

