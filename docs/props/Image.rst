.. _propsimage:

Image
=====

.. class:: props.Image

PNG image prop

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs an image property. Only PNG images are currently supported.
Valid values are either PNG filenames that can be read with :code:`imread` or
valid PNG matrices already in MATLAB. Image will attempt to
coerce different image formats to PNG, but the success may be limited.

**Attributes** - No properties besides those inherited from :ref:`props.Prop <propsprop>`

Example:

.. code::

    ...
    class HasImageProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            ImagePropStruct = {                                     ...
                struct(                                             ...
                    'Name', 'SomePicture',                          ...
                    'Type', @props.Image,                           ...
                    'Doc', 'Some PNG image'                         ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Array <propsarray>`, :ref:`props.Color <propscolor>`

