classdef PropTestClass < props.HasProps
%PROPTESTCLASS Summary of this class goes here
%   Detailed explanation goes here
%
%   PROPTESTCLASS implements <a href="matlab: help props.HasProps
%   ">HasProps</a> for dynamic, type-checked <a href="matlab:
%   help props.Prop">properties</a>
%
%   OPTIONAL PROPERTIES:
%       ThreeColumns (<a href="matlab: help props.Array">props.Array</a>)
%           Three column array, saved as binary
%           Shape: {*, 3}, DataType: float
%
%       IsSomething (<a href="matlab: help props.Bool">props.Bool</a>)
%           Is it something?
%           Default: true
%
%       FaceColor (<a href="matlab: help props.Color">props.Color</a>)
%           Color of the object
%           Default: [214 39 40]
%
%       PositiveFloat (<a href="matlab: help props.Float">props.Float</a>)
%           A positive number
%           Minimum: 0
%           Default: 0
%
%       SomePicture (<a href="matlab: help props.Image">props.Image</a>)
%           Some PNG image
%
%       FigureInstance (<a href="matlab: help props.Instance">props.Instance</a>)
%           An auto-created figure property
%           Class: <a href="matlab: help matlab.ui.Figure">Figure</a>
%
%       Int0to10 (<a href="matlab: help props.Int">props.Int</a>)
%           An integer between 0 and 10
%           Minimum: 0, Maximum: 10
%           Default: 0
%
%       MultipleColors (<a href="matlab: help props.Repeated">props.Repeated</a>)
%           This propery can hold multiple colors
%           Type: props.Color
%
%       AnyString (<a href="matlab: help props.String">props.String</a>)
%           This property can be any string
%
%       ChoiceString (<a href="matlab: help props.String">props.String</a>)
%           This property can only be hi or bye
%           Choices: hi, bye
%           Default: 'hi'
%
%       CoercedChoiceString (<a href="matlab: help props.String">props.String</a>)
%           This coerces hi and bye to English
%           Choices: hi, bye
%           Default: 'hi'
%
%       StringOrInt (<a href="matlab: help props.Union">props.Union</a>)
%           This property is a string or an int>0
%           Types: props.Int (Minimum: 0), props.String
%           Default: 0
%
%       ViewDirection (<a href="matlab: help props.Vector">props.Vector</a>)
%           Three-component view direction vector
%           Shape: {1, 3}, DataType: float
%           Default: [0 0 1]
%
%   %%%seealso props.HasProps
%


    properties (Hidden, SetAccess = immutable)
        ArrayPropStruct = {                                             ...
            struct(                                                     ...
                'Name', 'ThreeColumns',                                 ...
                'Type', @props.Array,                                   ...
                'Doc', 'Three column array, saved as binary',           ...
                'Shape', {{'*', 3}},                                    ...
                'Binary', true,                                         ...
                'DataType', 'float'                                     ...
            )                                                           ...
        }
        BoolPropStruct = {                                              ...
            struct(                                                     ...
                'Name', 'IsSomething',                                  ...
                'Type', @props.Bool,                                    ...
                'Doc', 'Is it something?',                              ...
                'DefaultValue', true                                    ...
            )                                                           ...
        }
        ColorPropStruct = {                                             ...
            struct(                                                     ...
                'Name', 'FaceColor',                                    ...
                'Type', @props.Color,                                   ...
                'Doc', 'Color of the object',                           ...
                'DefaultValue', 'random'                                ...
            )                                                           ...
        }
        FloatPropStruct = {                                             ...
            struct(                                                     ...
                'Name', 'PositiveFloat',                                ...
                'Type', @props.Float,                                   ...
                'Doc', 'A positive number',                             ...
                'MinValue', 0                                           ...
            )                                                           ...
        }
        ImagePropStruct = {                                             ...
            struct(                                                     ...
                'Name', 'SomePicture',                                  ...
                'Type', @props.Image,                                   ...
                'Doc', 'Some PNG image'                                 ...
            )                                                           ...
        }
        InstancePropStruct = {                                          ...
            struct(                                                     ...
                'Name', 'FigureInstance',                               ...
                'Type', @props.Instance,                                ...
                'Doc', 'An auto-created figure property',               ...
                'Class', @matlab.ui.Figure,                             ...
                'Initialize', true                                      ...
            )                                                           ...
        }
        IntPropStruct = {                                               ...
            struct(                                                     ...
                'Name', 'Int0to10',                                     ...
                'Type', @props.Int,                                     ...
                'Doc', 'An integer between 0 and 10',                   ...
                'MinValue', 0,                                          ...
                'MaxValue', 10                                          ...
            )                                                           ...
        }
        RepeatedPropStruct = {                                          ...
            struct(                                                     ...
                'Name', 'MultipleColors',                               ...
                'Type', @props.Repeated,                                ...
                'Doc', 'This propery can hold multiple colors',         ...
                'PropType', struct(                                     ...
                    'Type', @props.Color                                ...
                )                                                       ...
            )                                                           ...
        }
        StringPropsStruct = {                                           ...
            struct(                                                     ...
                'Name', 'AnyString',                                    ...
                'Type', @props.String,                                  ...
                'Doc', 'This property can be any string'                ...
            ), struct(                                                  ...
                'Name', 'ChoiceString',                                 ...
                'Type', @props.String,                                  ...
                'Doc', 'This property can only be hi or bye',           ...
                'Choices', {{'hi', 'bye'}},                             ...
                'DefaultValue', 'hi'                                    ...
            ), struct(                                                  ...
                'Name', 'CoercedChoiceString',                          ...
                'Type', @props.String,                                  ...
                'Doc', 'This coerces hi and bye to English',            ...
                'Choices', struct(                                      ...
                    'hi', {{'hola', 'bonjour', 'guten tag'}},           ...
                    'bye', {{'adios', 'au revoir',                      ...
                             'auf Wiedersehen'}}                        ...
                ),                                                      ...
                'DefaultValue', 'hi'                                    ...
            )                                                           ...
        }
        UnionPropStruct = {                                             ...
            struct(                                                     ...
                'Name', 'StringOrInt',                                  ...
                'Type', @props.Union,                                   ...
                'Doc', 'This property is a string or an int>0',         ...
                'PropTypes', {{struct(                                  ...
                    'Type', @props.Int,                                 ...
                    'MinValue', 0                                       ...
                ), struct(                                              ...
                    'Type', @props.String                               ...
                )}}                                                     ...
            )                                                           ...
        }
        VectorPropStruct = {                                            ...
            struct(                                                     ...
                'Name', 'ViewDirection',                                ...
                'Type', @props.Vector,                                  ...
                'Doc', 'Three-component view direction vector',         ...
                'DefaultValue', 'Z'                                     ...
            )                                                           ...
        }
    end
end

