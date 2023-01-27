defmodule Javex.ClassFile.ConstantPool do
  alias Javex.ClassFile.ConstantPool.{
    Utf8,
    Integer,
    Float,
    Long,
    Double,
    Class,
    String,
    Fieldref,
    Methodref,
    InterfaceMethodref,
    NameAndType,
    MethodHandle,
    MethodType,
    InvokeDynamic
  }

  @constants %{
    # implemented
    1 => Utf8,
    3 => Integer,
    4 => Float,
    5 => Long,
    6 => Double,
    # implemented
    7 => Class,
    # implemented
    8 => String,
    # implemented
    9 => Fieldref,
    # implemented
    10 => Methodref,
    11 => InterfaceMethodref,
    # implemented
    12 => NameAndType,
    15 => MethodHandle,
    16 => MethodType,
    18 => InvokeDynamic
  }

  def read_from(<<tag::size(8), binary::binary>>) do
    @constants[tag].read_from(binary)
  end
end
