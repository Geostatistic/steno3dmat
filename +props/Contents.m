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
%   HasProps - Class with dynamicaly created, declarative Props
%
% Prop Types:
%   Array    - Multi-dimensional float or int array property
%   Bool     - Boolean property
%   Color    - RGB, Hex, or string color property
%   Float    - Float property
%   Image    - PNG image property
%   Instance - Property that must be an instance of a given class
%   Int      - Integer property
%   Repeated - Property that is a repeated number of another type of property
%   String   - String property
%   Union    - Property that may be one of several different types of properties
%   Vector   - Three-component vector property
