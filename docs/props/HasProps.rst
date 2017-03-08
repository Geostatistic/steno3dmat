.. _propshasprops:

HasProps
========

.. class:: props.HasProps

Class with dynamically created, declarative Props

PROPS.HASPROPS is designed to aid creation of classes by providing a
declarative interface for creating type-checked, validated and
cross-validated properties.

DECLARING DYNAMIC PROPS:
    The props of a PROPS.HASPROPS subclass are declared in an immutable
    property that is a cell array of structs. It is recommended but not
    required to set this property to 'Hidden' since it is unused after
    class instantiated.

    The required fields of each struct in this immutable cell array are
    'Name' (the name by which the prop value will be accessed), 'Type'
    (a handle to the type of prop), and 'Doc' (a description of the
    prop). Optional fields include 'Required' and 'DefaultValue', and
    specific types of props may have additional fields.

ADDING VALIDATION:
    Individual Props are validated, type-checked, and possibly coerced
    to new values when set. This validation logic is defined in the
    specific Prop class.

    PROPS.HASPROPS classes also have a framework for cross-validating
    properties. To utilize this, define a "validator()" method that
    checks prop combinations and errors if they are invalid. Then, when
    you call "validate()" on the PROPS.HASPROPS instance, all the
    validation methods will be called recursively.

INSTANTIATING THE CLASS:
    Upon instantiation, each struct declared in the immutable cell
    array will be converted into two properties: and accessible
    property, Name, that is used to get and set the prop value, and a
    hidden property, PR_Name, the underlying instance of props.Prop
    where the value is actually validated and stored.

    PROPS.HASPROPS allows you to assign prop values on instantiation by
    passing in Parameter/Value pairs. However, this requires defining a
    constructor method that passes varargin to the PROPS.HASPROPS
    constructor. If this constructor is not defined, the default
    constructor takes no arguments, and passing Parameter/Value pairs
    will result in an error.

For a substantial practical example, look at the Steno3D MATLAB
client on `github <https://github.com/3ptscience/steno3dmat>`_.

See also :ref:`props.Prop <propsprop>`

