classdef LineBinder < props.HasProps
%LINEBINDER Bind data to segments or vertices of a Steno3D Line
%   For usage details, see the <a href="matlab: help steno3d.core.binders
%   ">binders help</a>.
%
%   LINEBINDER implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   REQUIRED PROPERTIES:
%       Location (<a href="matlab: help props.String">props.String</a>)
%           Location of the data on mesh
%           Choices: CC, N
%
%       Data (<a href="matlab: help props.Instance">props.Instance</a>)
%           Line data array
%           Class: <a href="matlab: help steno3d.core.DataArray
%           ">DataArray</a>
%
%
%   See the line <a href="matlab: help steno3d.core.examples.line
%   ">EXAMPLES</a>
%
%   See also STENO3D.CORE.BINDERS, STENO3D.CORE.DATAARRAY,
%   STENO3D.CORE.LINE
%


    properties (Hidden, SetAccess = immutable)
        LBinderProps = {                                                ...
            struct(                                                     ...
                'Name', 'Location',                                     ...
                'Type', @props.String,                                  ...
                'Doc', 'Location of the data on mesh',                  ...
                'Choices', struct(                                      ...
                    'CC', {{'FACE', 'FACES', 'CELLCENTER', 'SEGMENT',   ...
                            'CELLCENTERS','EDGE', 'EDGES', 'SEGMENTS'}},...
                    'N', {{'VERTEX', 'VERTICES', 'NODE', 'NODES',       ...
                           'ENDPOINT', 'ENDPOINTS'}}                    ...
                ),                                                      ...
                'ValidateDefault', false,                               ...
                'Required', true                                        ...
            ), struct(                                                  ...
                'Name', 'Data',                                         ...
                'Type', @props.Instance,                                ...
                'Doc', 'Line data array',                               ...
                'Class', @steno3d.core.DataArray,                       ...
                'Required', true                                        ...
            )                                                           ...
        }
    end

    methods
        function obj = LineBinder(varargin)
            obj = obj@props.HasProps(varargin{:});
        end
    end
end

