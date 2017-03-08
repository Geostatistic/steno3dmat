.. _propsunion:

Union
=====

.. class:: props.Union

Prop that may be one of several different types of props

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs a property that can be multiple types. When the property is
assigned, PROPS.UNION attempts to validate it as each type until it
succeeds.

**Attributes** (in addition to those inherited from :ref:`props.Prop <propsprop>`):

PropTypes:
    A nested cell array of structs that define the valid
    prop types. The structs in PropTypes require Type handle
    but do not require Name or Doc - those are inherited
    from the PROPS.UNION values. Note: The requirement for
    nesting the cell array is necessary to subvert MATLAB's
    default treatment of cell arrays contained in structs.
    See the example below for how this is implemented.

Example:

.. code::

    ...
    class HasUnionProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            UnionPropStruct = {                                     ...
                struct(                                             ...
                    'Name', 'StringOrInt',                          ...
                    'Type', @props.Union,                           ...
                    'Doc', 'This property is a string or an int>0', ...
                    'PropTypes', {{struct(                          ...
                        'Type', @props.Int,                         ...
                        'MinValue', 0                               ...
                    ), struct(                                      ...
                        'Type', @props.String                       ...
                    )}}                                             ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Int <propsint>`, :ref:`props.String <propsstring>`, :ref:`props.Repeated <propsrepeated>`, :ref:`props.Instance <propsinstance>`

