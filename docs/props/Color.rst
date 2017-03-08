.. _propscolor:

Color
=====

.. class:: props.Color

RGB, Hex, or string color prop

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs a color property. Examples of valid colors include:

    - 8-bit RGB colors with values betweeon 0-255 (e.g. [0 128 255])
    - MATLAB RGB colors with values between 0-1 (e.g. [0 .5 .5])
    - Hex string colors with 6 digits (e.g. '#0080FF')
    - Hex string colors with 3 digits (e.g. '#F50')
    - MATLAB color letters (e.g. 'y')
    - Standard, named web colors (e.g. 'papayawhip')
    - Random color ('random')

All of these are converted to and stored as their equivalent 8-bit RGB
color.

**Attributes** - No properties besides those inherited from :ref:`props.Prop <propsprop>`

Example:

.. code::

    ...
    class HasColorProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            ColorPropStruct = {                                     ...
                struct(                                             ...
                    'Name', 'FaceColor',                            ...
                    'Type', @props.Color,                           ...
                    'Doc', 'Color of the object',                   ...
                    'DefaultValue', 'random'                        ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Vector <propsvector>`, :ref:`props.Instance <propsinstance>`

