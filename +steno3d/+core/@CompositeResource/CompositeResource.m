classdef CompositeResource < steno3d.core.UserContent
%COMPOSITERESOURCE Summary of this class goes here
%   Detailed explanation goes here
    
    properties
    end
    
    methods (Hidden)
        
        function uploadChildren(obj, tabLevel)
            if obj.findprop('Mesh')
                obj.Mesh.uploadContent(tabLevel)
            end
            if obj.findprop('Data')
                for i = 1:length(obj.Data)
                    obj.Data{i}.Data.uploadContent(tabLevel)
                end
            end
            if obj.findprop('Textures')
                for i = 1:length(obj.Textures)
                    obj.Textures{i}.uploadContent(tabLevel)
                end
            end
        end
    end
    
end

