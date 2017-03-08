.. _propsbool:

Bool
====

.. class:: props.Bool

Boolean prop

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs a boolean property.

**Attributes** - No properties besides those inherited from :ref:`props.Prop <propsprop>`

Example:

.. code::

    ...
    class HasBoolProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            BoolPropStruct = {                                      ...
                struct(                                             ...
                    'Name', 'IsSomething',                          ...
                    'Type', @props.Bool,                            ...
                    'Doc', 'Is it something?',                      ...
                    'DefaultValue', true                            ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Int <propsint>`

