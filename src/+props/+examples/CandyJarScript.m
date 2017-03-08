%   Command Window
%   **************
%   >> cj = props.examples.CandyJar
%
%   cj =
%
%     CandyJar with properties:
%
%       MaximumAmount: 0
%          CandyBrand: ''
%       CurrentAmount: 0
%
%   >> cj.CandyBrand = 'Props Pops';
%   >> cj.MaximumAmount = 25;
%   >> cj.CurrentAmount = cj.MaximumAmount;
%   >> cj.CurrentAmount = cj.CurrentAmount - 1;
%   >> cj.CurrentAmount
%
%   ans =
%
%       24
%
%   >> cj.CurrentAmount = 20.5;
%   Error using props.Int/validate
%   CurrentAmount must be an integer
%   ...
%
%   >> cj.CandyBrand = true;
%   Error using props.String/validate
%   CandyBrand must be a string
%   ...
%
%   >> cj
%
%   cj =
%
%     CandyJar with properties:
%
%       MaximumAmount: 25
%          CandyBrand: 'Props Pops'
%       CurrentAmount: 24
%
%   >> cj.PR_CurrentAmount
%
%   ans =
%
%     Int with properties:
%
%              MinValue: -Inf
%              MaxValue: Inf
%                 Value: 24
%                  Name: 'CurrentAmount'
%                   Doc: 'Number of candy pieces in the jar'
%              PropInfo: 'a single integer'
%              Required: 1
%       ValidateDefault: 1
%          DefaultValue: 0
%
%   >> cj.Validate;
%   >> cj.CurrentAmount = 100;
%   >> cj.Validate;
%   Error using CandyJar/validator
%   Current amount of candy is greater than maximum amount
%   ...
%
%   **************
%
%   See also props.examples.CandyJar, props.HasProps, props.Prop
%


cj = props.examples.CandyJar
cj.CandyBrand = 'Props Pops';
cj.MaximumAmount = 25;
cj.CurrentAmount = cj.MaximumAmount;
cj.CurrentAmount = cj.CurrentAmount - 1;
cj.CurrentAmount
cj.CurrentAmount = 20.5;  % Errors
cj.CandyBrand = true;  % Errors
cj
cj.PR_CurrentAmount
cj.Validate;
cj.CurrentAmount = 100;
cj.Validate;  % Errors
