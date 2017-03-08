.. _propsvector:

Vector
======

.. class:: props.Vector

Three-component vector prop

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs a vector property. PROPS.VECTOR is a props.Array with
different default values. Overriding these defaults is allowed but not
recommended; just use props.Array instead. PROPS.VECTOR also allows the
values 'X', 'Y', and 'Z'; these are converted to [1 0 0], [0 1 0], and
[0 0 1], respectively.

**Attributes** - No properties besides those inherited from :ref:`props.Array <propsarray>`

Example:

.. code::

    ...
    class HasVectorProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            VectorPropStruct = {                                    ...
                struct(                                             ...
                    'Name', 'ViewDirection',                        ...
                    'Type', @props.Vector,                          ...
                    'Doc', 'Three-component view direction vector', ...
                    'DefaultValue', 'Z'                             ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Array <propsarray>`, :ref:`props.Float <propsfloat>`

