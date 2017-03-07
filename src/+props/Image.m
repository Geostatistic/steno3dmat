classdef Image < props.Prop
%IMAGE PNG image prop
%   This is a type of %%%ref[props.Prop](props.Prop) that can be used when a %%%ref[props.HasProps](props.HasProps)
%   class needs an image property. Only PNG images are currently supported.
%   Valid values are either PNG filenames that can be read with %%%matlabref[imread](imread) or
%   valid PNG matrices already in MATLAB. Image will attempt to
%   coerce different image formats to PNG, but the success may be limited.
%
%   PROPERTIES - No properties besides those inherited from %%%ref[props.Prop](props.Prop)
%
%   Example:
%   %%%codeblock
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
%   %%%seealso props.Prop, props.HasProps, props.Array, props.Color
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
            try
                val = imread(val);
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
