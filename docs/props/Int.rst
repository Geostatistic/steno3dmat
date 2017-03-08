.. _propsint:

Int
===

.. class:: props.Int

Integer prop

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs an integer property.

**Attributes** - No properties besides those inherited from :ref:`props.Float <propsfloat>`

Example:

.. code::

    ...
    class HasIntProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            IntPropStruct = {                                       ...
                struct(                                             ...
                    'Name', 'Int0to10',                             ...
                    'Type', @props.Int,                             ...
                    'Doc', 'An integer between 0 and 10',           ...
                    'MinValue', 0,                                  ...
                    'MaxValue', 10                                  ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Float <propsfloat>`, :ref:`props.Array <propsarray>`, :ref:`props.Bool <propsbool>`

