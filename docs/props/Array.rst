.. _propsarray:

Array
=====

.. class:: props.Array

Multi-dimensional float or int array prop

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs a numeric array property.

**Attributes** (in addition to those inherited from :ref:`props.Prop <propsprop>`):

Shape:
    A nested cell array describing the shape of the array where
    the n-th entry must correspond to size(array, n). If an
    entry is '*', that dimension can be any size. Note: The
    requirement for nesting the cell array is necessary to
    subvert MATLAB's default treatment of cell arrays contained
    in structs.

    Example:

         If :code:`Shape = {{1, 3, '*'}}`, valid array sizes include
         :code:`[1, 3, 1]`, :code:`[1, 3, 100]`, etc. Invalid array sizes
         include :code:`[1, 3]`, :code:`[1, 3, 100, 1]`, :code:`[3, 1, 100]`.

Binary:
    If true, array is written to binary when serialized to a
    file. If false, array is written as a string when
    serialized.

DataType:
    :code:`float` or :code:`int`

IndexArray:
    If true, the array is saved as as (array - 1) for
    compatibility with zero-indexed languages. If false,
    the array is saved as-is.

Example:

.. code::

    ...
    class HasArrayProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            ArrayPropStruct = {                                     ...
                struct(                                             ...
                    'Name', 'ThreeColumns',                         ...
                    'Type', @props.Array,                           ...
                    'Doc', 'Three column array, saved as binary',   ...
                    'Shape', {{'*', 3}},                            ...
                    'Binary', true,                                 ...
                    'DataType', 'float'                             ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Float <propsfloat>`, :ref:`props.Int <propsint>`, :ref:`props.Repeated <propsrepeated>`, :ref:`props.Image <propsimage>`

