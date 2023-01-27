defmodule Javex.Struct.ConstantPool.Fieldref do
  defstruct [:class_index, :name_and_type_index]

  def read_from(<<
        class_index::size(16),
        name_and_type_index::size(16),
        binary::binary
      >>) do
    {
      %__MODULE__{
        class_index: class_index,
        name_and_type_index: name_and_type_index
      },
      binary
    }
  end
end
