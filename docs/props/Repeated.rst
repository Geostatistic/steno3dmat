.. _propsrepeated:

Repeated
========

.. class:: props.Repeated

Prop that is a repeated number of another type of prop

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs a property that can be multiple values of one types.
PROPS.REPEATED stores the repeated values in a cell array; each value
is validated.

**Attributes** (in addition to those inherited from :ref:`props.Prop <propsprop>`):

PropType:
    A struct that defines another valid prop type. This
    struct requires Type handle but not Name or Doc - those
    are inherited from the PROPS.REPEATED values.

Example:

.. code::

    ...
    class HasRepeatedProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            RepeatedPropStruct = {                                  ...
                struct(                                             ...
                    'Name', 'MultipleColors',                       ...
                    'Type', @props.Repeated,                        ...
                    'Doc', 'This propery can hold multiple colors', ...
                    'PropType', struct(                             ...
                        'Type', @props.Color                        ...
                    )                                               ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Union <propsunion>`, :ref:`props.Array <propsarray>`, :ref:`props.Color <propscolor>`

