.. _props:

Props MATLAB Package
====================



The Props MATLAB package facilitates the creation of classes with
type-checked, validated properties through a relatively simple,
declarative interface.

**Base Classes**:

 :class:`props.Prop`     - Basic property with no given type

 :class:`props.HasProps` - Class with dynamically created, declarative Props

**Prop Types**:

 :class:`props.Array`    - Multi-dimensional float or int array prop

 :class:`props.Bool`     - Boolean prop

 :class:`props.Color`    - RGB, Hex, or string color prop

 :class:`props.Float`    - Float prop

 :class:`props.Image`    - PNG image prop

 :class:`props.Instance` - Prop that is an instance of a given class

 :class:`props.Int`      - Integer prop

 :class:`props.Repeated` - Prop that is a repeated number of another type of prop

 :class:`props.String`   - String prop

 :class:`props.Union`    - Prop that may be one of several different types of props

 :class:`props.Vector`   - Three-component vector prop

.. note::

    Props requires MATLAB R2014b or greater 


.. toctree::
    :maxdepth: 2
    :hidden:

    Prop
    HasProps
    Array
    Bool
    Color
    Float
    Image
    Instance
    Int
    Repeated
    String
    Union
    Vector
