classdef CandyJar < props.HasProps
%   ---- CandyJar.m -------------------------------------------------------
%   classdef CandyJar < PROPS.HASPROPS
%   %CANDYJAR Object to describe the contents of a candy jar
%
%   properties (Hidden, SetAccess = immutable)
%   %PROPERTIES Define three props for CandyJar:
%   %   CandyBrand (String) - Brand of candy in the jar
%   %   CurrentAmount (Int) - Number of candy pieces in the jar
%   %   MaximumAmount (Int) - Maximum candy capacity of the jar
%
%       CandyJarProps = {                                               ...
%           struct(                                                     ...
%               'Name', 'CandyBrand',                                   ...
%               'Type', @props.String,                                  ...
%               'Doc', 'Brand of candy in the jar',                     ...
%           ), struct(                                                  ...
%               'Name', 'CurrentAmount',                                ...
%               'Type', @props.Int,                                     ...
%               'Doc', 'Number of candy pieces in the jar',             ...
%           ), struct(                                                  ...
%               'Name', 'MaximumAmount',                                ...
%               'Type', @props.Int,                                     ...
%               'Doc', 'Maximum candy capacity of the jar',             ...
%           )                                                           ...
%       }
%   end
%
%   methods
%       function obj = CandyJar(varargin)
%       %CANDYJAR Constructor passes all input arguments to props.HasProps
%       %   This allows for prop assignment at instantiation through
%       %   Property/Value pairs
%           obj = obj@props.HasProps(varargin{:});
%       end
%   end
%
%   methods (Hidden)
%       function validator(obj)
%       %VALIDATOR Ensures that CurrentAmount never exceeds MaximumAmount
%       %   This will be called from "obj.validate()"
%           if obj.CurrentAmount > obj.MaximumAmount
%               error('candyjar:validationError', ['Current amount of ' ...
%                     'candy is greater than maximum amount']);
%           end
%       end
%   end
%
%   end
%   -----------------------------------------------------------------------
%
%   An <a href="matlab: help props.examples.CandyJarScript
%   ">example script using a CandyJar instance</a> is also available.
%
%   %%%seealso props.HasProps, props.Prop, props.String, props.Int,
%   props.examples.CandyJarScript
%

%CANDYJAR Object to describe the contents of a candy jar

properties (Hidden, SetAccess = immutable)
%PROPERTIES Define three props for CandyJar:
%   CandyBrand (String) - Brand of candy in the jar
%   CurrentAmount (Int) - Number of candy pieces in the jar
%   MaximumAmount (Int) - Maximum candy capacity of the jar

    CandyJarProps = {                                                   ...
        struct(                                                         ...
            'Name', 'CandyBrand',                                       ...
            'Type', @props.String,                                      ...
            'Doc', 'Brand of candy in the jar'                          ...
        ), struct(                                                      ...
            'Name', 'CurrentAmount',                                    ...
            'Type', @props.Int,                                         ...
            'Doc', 'Number of candy pieces in the jar'                  ...
        ), struct(                                                      ...
            'Name', 'MaximumAmount',                                    ...
            'Type', @props.Int,                                         ...
            'Doc', 'Maximum candy capacity of the jar'                  ...
        )                                                               ...
    }
end

methods
    function obj = CandyJar(varargin)
    %CANDYJAR Constructor passes all input arguments to props.HasProps
    %   This allows for prop assignment at instantiation through
    %   Property/Value pairs
        obj = obj@props.HasProps(varargin{:});
    end
end

methods (Hidden)
    function validator(obj)
    %VALIDATOR Ensures that CurrentAmount never exceeds MaximumAmount
    %   This will be called from "obj.validate()"
        if obj.CurrentAmount > obj.MaximumAmount
            error('candyjar:validationError', ['Current amount of '     ...
                  'candy is greater than maximum amount']);
        end
    end
end

end
