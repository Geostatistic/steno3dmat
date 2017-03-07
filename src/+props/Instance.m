classdef Instance < props.Prop
%INSTANCE Prop that is an instance of a given class
%   This is a type of %%%ref[props.Prop](props.Prop) that can be used when a %%%ref[props.HasProps](props.HasProps)
%   class needs a property that is an instance of any Class. If the
%   instance class is also a subclass of %%%ref[props.HasProps](props.HasProps), it will be
%   recursively validated on a call to 'validate()'.
%
%
%
%   PROPERTIES (in addition to those inherited from %%%ref[props.Prop](props.Prop))
%       Class: Handle to the type of instance this prop requires. This may
%              be any MATLAB class. If the Class is another subclass of
%              props.HasProps it will benefit from additional recursive
%              validation. Even circular Class assignment (for example
%              having a class use itself as a PROPS.INSTANCE) can be
%              achieved by setting Class = eval('@CurcularClass'), as long
%              as the <a href="matlab: help eval
%              ">eval</a> function is valid at runtime.
%
%       Args: Cell array of default arguments used to construct the
%             DynamicDefault value of the class if Initialize is true. If
%             Initialize is false, Args are unused.
%
%       Initialize: Whether or not to auto-create an instance of the class
%                   for the property. If Initialize is true, valid Args
%                   must be provided as well. If Initialize is false,
%                   Required or ValidateDefault will likely need to be
%                   false as well. Otherwise, PROPS.INSTANCE will attempt
%                   to validate the uninitialized (empty) default value and
%                   probably fail.
%
%   Example:
%   %%%codeblock
%       ...
%       class HasInstanceProp < props.HasProps
%           properties (Hidden, SetAccess = immutable)
%               InstancePropStruct = {                                  ...
%                   struct(                                             ...
%                       'Name', 'FigureInstance',                       ...
%                       'Type', @props.Instance,                        ...
%                       'Doc', 'An auto-created figure property',       ...
%                       'Class', @matlab.ui.Figure,                     ...
%                       'Initialize', true                              ...
%                   )                                                   ...
%               }
%           end
%           ...
%       end
%
%   %%%seealso props.Prop, props.HasProps, props.Union, props.Repeated
%


    properties (SetAccess = ?props.Prop)
        Class
        Args
        Initialize = true
    end

    methods
        function obj = Instance(varargin)
            args = props.Prop.setPropDefaults(varargin,                 ...
                'Args', {});
            obj = obj@props.Prop(args{:});
            if isempty(obj.Class)
                error('props:instanceError',                            ...
                      'Instance props must specify a Class')
            end
        end

        function val = validate(obj, val)
            if isempty(val) && ~obj.Required
                return
            end
            classInfo = functions(obj.Class);
            if isa(val, classInfo.function)
                return
            end
            try
                val = obj.Class(val);
                return
            catch
            end
            try
                val = obj.Class(val{:});
                return
            catch
            end
            error('props:instanceError',                                ...
                  ['%s must be an instance of %s (or valid arguments '  ...
                   'to construct that class)'],                         ...
                  obj.Name, classInfo.function);
        end

        function obj = set.Initialize(obj, val)
            if ~islogical(val) || length(val(:)) ~= 1
                error('props:instanceError',                            ...
                      'Prop property `Initialize` must be true or false');
            end
            obj.Initialize = val;
        end

        function obj = set.Class(obj, val)
            if ~isa(val, 'function_handle')
                error('props:instanceError',                            ...
                      ['Prop property `Class` must be class '           ...
                       'constructor function handle']);
            end
            obj.Class = val;
        end

        function obj = set.Args(obj, val)
            if ~iscell(val)
                error('props:instanceError',                            ...
                      ['Prop property `Args` must be a cell array of '  ...
                       'Class constructor arguments.']);
            end
            obj.Args = val;
        end

        function val = DynamicDefault(obj)
            if obj.Initialize
                val = obj.Class(obj.Args{:});
            else
                val = obj.DefaultValue;
            end
        end

        function doc = dynamicDoc(obj, doctype)
            shortclass = strsplit(func2str(obj.Class), '.');
            shortclass = shortclass{end};
            if strcmp(doctype, 'matlab')
                doc = ['Class: <a href="matlab: help '                  ...
                       func2str(obj.Class) '">' shortclass '</a>'];
            else
                doc = ['Class: :ref:`' shortclass ' <'                  ...
                       strrep(func2str(obj.Class), '.', '') '>`'];
            end
        end

    end
end

