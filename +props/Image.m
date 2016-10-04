classdef Image < props.Prop
%IMAGE Summary of this class goes here
%   Detailed explanation goes here

    methods
        function obj = Image(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'ValidateDefault', false,                               ...
                'PropInfo', 'a PNG image file or valid PNG matrix');
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
            error('steno3d:propError', '%s must be %s',                 ...
                  obj.Name, obj.PropInfo)
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
