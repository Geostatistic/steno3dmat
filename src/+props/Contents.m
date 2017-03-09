%Props MATLAB Package:
%
%   The Props MATLAB package facilitates the creation of classes with
%   type-checked, validated properties through a relatively simple,
%   declarative interface.
%
%   %%%bold[Base Classes]:
%   %%%class[Prop](props.Prop)     - Basic property with no given type
%   %%%class[HasProps](props.HasProps) - Class with dynamically created, declarative Props
%
%   %%%bold[Prop Types]:
%   %%%class[Array](props.Array)    - Multi-dimensional float or int array prop
%   %%%class[Bool](props.Bool)     - Boolean prop
%   %%%class[Color](props.Color)    - RGB, Hex, or string color prop
%   %%%class[Float](props.Float)    - Float prop
%   %%%class[Image](props.Image)    - PNG image prop
%   %%%class[Instance](props.Instance) - Prop that is an instance of a given class
%   %%%class[Int](props.Int)      - Integer prop
%   %%%class[Repeated](props.Repeated) - Prop that is a repeated number of another type of prop
%   %%%class[String](props.String)   - String prop
%   %%%class[Union](props.Union)    - Prop that may be one of several different types of props
%   %%%class[Vector](props.Vector)   - Three-component vector prop
%
%   %%%note
%       Props requires MATLAB R2014b or greater %%%versioncheck
%
%   %%%tree Prop HasProps Array Bool Color Float Image Instance Int Repeated String Union Vector
