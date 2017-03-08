.. _propsprop:

Prop
====

.. class:: props.Prop

Basic property with no given type

Used with subclasses of :ref:`props.HasProps <propshasprops>`, a PROPS.PROP instance is
created dynamically on class instantiation based on a declarative,
immutable property of the props.HasProps class. For more information
about to use PROPS.PROP, see :ref:`props.HasProps <propshasprops>`, a <a href="matlab: help props.examples.CandyJar
">simple example</a>, or the
specific types listed below.

**Attributes**:

Value:
    The saved value of the PROPS.PROP.

Name:
    The name used to access the value of PROPS.PROP from the
    props.HasProps class.

Doc:
    A description of the specific PROPS.PROP on a props.HasProps
    class.

Required:
    Whether or not the PROPS.PROP must be given a value for a
    props.HasProps instance to pass validation.

ValidateDefault:
    Whether or not the DefaultValue must pass
    validation.

DefaultValue:
    The default value when the PROPS.PROP is accessed
    prior to getting set.

See also :ref:`PROPS.HASPROPS <propshasprops>`, :ref:`PROPS.ARRAY <propsarray>`, :ref:`PROPS.BOOL <propsbool>`, :ref:`PROPS.COLOR <propscolor>`, :ref:`PROPS.FLOAT <propsfloat>`, :ref:`PROPS.IMAGE <propsimage>`, :ref:`PROPS.INSTANCE <propsinstance>`, :ref:`PROPS.INT <propsint>`, :ref:`PROPS.REPEATED <propsrepeated>`, :ref:`PROPS.STRING <propsstring>`, :ref:`PROPS.UNION <propsunion>`, :ref:`PROPS.VECTOR <propsvector>`

