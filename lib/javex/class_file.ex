defmodule Javex.ClassFile do
  # https://docs.oracle.com/javase/specs/jvms/se19/html/jvms-4.html#jvms-4.1
  defstruct [
    :magic,
    :minor_version,
    :major_version,
    :constant_pool_count,
    :constant_pool,
    :access_flags,
    :this_class,
    :super_class,
    :interfaces_count,
    :interfaces,
    :fields_count,
    :fields,
    :methods_count,
    :methods,
    :attributes_count,
    :attributs
  ]
end
