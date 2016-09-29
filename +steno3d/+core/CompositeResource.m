classdef CompositeResource < steno3d.core.UserContent
%COMPOSITERESOURCE Summary of this class goes here
%   Detailed explanation goes here

    properties
    end

    methods
        function obj = CompositeResource(varargin)
            obj = obj@steno3d.core.UserContent(varargin{:});
        end
    end

    methods (Hidden)

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
                        '", "uid": "' obj.Data{i}.Data.PR__uid ...
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

