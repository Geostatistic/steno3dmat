classdef Image < props.Prop
%IMAGE PNG image prop
%   This is a type of props.Prop that can be used when a props.HasProps
%   class needs an image property. Only PNG images are currently supported.
%   Valid values are either PNG filenames that can be read with <a href="
%   matlab: help imread">imread</a> or
%   valid PNG matrices already in MATLAB.
%
%   PROPERTIES - No properties besides those inherited from props.Prop
%
%   Example:
%       ...
%       class HasImageProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               ImagePropStruct = {                                     ...
%                   struct(                                             ...
%                       'Name', 'SomePicture',                          ...
%                       'Type', @props.Image,                           ...
%                       'Doc', 'Some PNG image'                         ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   See also props.Prop, props.HasProps, props.Array, props.Color
%


    methods
        function obj = Image(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'ValidateDefault', false);
            obj = obj@props.Prop(args{:});
        end

        function val = validate(obj, val)
            try
                val = imread(val, 'png');
                return
            catch
            end
            try
                imwrite(val, [tempname '.png'], 'png');
                return
            catch
            end
            error('props:imageError', ['%s must be a PNG image file or '...
                  'valid PNG matrix'], obj.Name)
        end

        function output = serialize(obj)
            obj.validate(obj.Value);
            try
                im = imread(obj.Value, 'png');
            catch
                im = obj.Value;
            end
            fname = [tempname '.png'];
            imwrite(im, fname, 'png');
            fid = fopen(fname, 'r');
            d = fread(fid, Inf, '*uint8');
            fclose(fid);
            output = struct('FileID', d, 'DType', 'png');
        end
        
        function n = nbytes(obj)
            obj.validate(obj.Value);
            try
                im = imread(obj.Value, 'png');
            catch
                im = obj.Value;
            end
            fname = [tempname '.png'];
            imwrite(im, fname, 'png');
            fdir = dir(fname);
            n = fdir.bytes;
        end
            

    end
end
