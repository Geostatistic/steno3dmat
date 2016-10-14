% PROPS: MATLAB Package to package to build declarative, validated classes
%        by <a href="matlab: web('https://www.3ptscience.com',
%        '-browser')">3pt Science</a>
%
% Version 0.0.1
%
% The Props MATLAB package facilitates the creation of classes with
% type-checked, validated properties through a relatively simple,
% declarative interface.
% 
% Base Classes:
%   Prop     - Basic property with no given type
%   HasProps - Class with dynamically created, declarative Props
%
% Prop Types:
%   Array    - Multi-dimensional float or int array prop
%   Bool     - Boolean prop
%   Color    - RGB, Hex, or string color prop
%   Float    - Float prop
%   Image    - PNG image prop
%   Instance - Prop that is an instance of a given class
%   Int      - Integer prop
%   Repeated - Prop that is a repeated number of another type of prop
%   String   - String prop
%   Union    - Prop that may be one of several different types of props
%   Vector   - Three-component vector prop
%
% Additional Packages
%   examples - Example classes and scripts with Props implementation
%   utils    - Supplemental utilities for HasProps classes
%
