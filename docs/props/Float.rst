.. _propsfloat:

Float
=====

.. class:: props.Float

Float prop

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs a float property.

**Attributes** (in addition to those inherited from :ref:`props.Prop <propsprop>`):

MinValue:
    The minimum allowed value for the property. The default
    is -Inf (no minimum).

MaxValue:
    The maximum allowed value for the property. The default
    is Inf (no maximum).

Example:

.. code::

    ...
    class HasFloatProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            FloatPropStruct = {                                     ...
                struct(                                             ...
                    'Name', 'PositiveFloat',                        ...
                    'Type', @props.Float,                           ...
                    'Doc', 'A positive number',                     ...
                    'MinValue', 0                                   ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Int <propsint>`, :ref:`props.Array <propsarray>`

