.. _propsinstance:

Instance
========

.. class:: props.Instance

Prop that is an instance of a given class

This is a type of :ref:`props.Prop <propsprop>` that can be used when a :ref:`props.HasProps <propshasprops>`
class needs a property that is an instance of any Class. If the
instance class is also a subclass of :ref:`props.HasProps <propshasprops>`, it will be
recursively validated on a call to 'validate()'.

**Attributes** (in addition to those inherited from :ref:`props.Prop <propsprop>`):

Class:
    Handle to the type of instance this prop requires. This may
    be any MATLAB class. If the Class is another subclass of
    props.HasProps it will benefit from additional recursive
    validation. Even circular Class assignment (for example
    having a class use itself as a PROPS.INSTANCE) can be
    achieved by setting Class = eval('\@CurcularClass'), as long
    as the :code:`eval` function is valid at runtime.

Args:
    Cell array of default arguments used to construct the
    DynamicDefault value of the class if Initialize is true. If
    Initialize is false, Args are unused.

Initialize:
    Whether or not to auto-create an instance of the class
    for the property. If Initialize is true, valid Args
    must be provided as well. If Initialize is false,
    Required or ValidateDefault will likely need to be
    false as well. Otherwise, PROPS.INSTANCE will attempt
    to validate the uninitialized (empty) default value and
    probably fail.

Example:

.. code::

    ...
    class HasInstanceProp < props.HasProps
        properties (Hidden, SetAccess = immutable)
            InstancePropStruct = {                                  ...
                struct(                                             ...
                    'Name', 'FigureInstance',                       ...
                    'Type', @props.Instance,                        ...
                    'Doc', 'An auto-created figure property',       ...
                    'Class', @matlab.ui.Figure,                     ...
                    'Initialize', true                              ...
                )                                                   ...
            }
        end
        ...
    end

See also :ref:`props.Prop <propsprop>`, :ref:`props.HasProps <propshasprops>`, :ref:`props.Union <propsunion>`, :ref:`props.Repeated <propsrepeated>`

