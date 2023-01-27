defmodule Javex.ClassFile.ConstantPool.NameAndType do
  defstruct [:name_index, :descriptor_index]

  def read_from(<<
        name_index::size(16),
        descriptor_index::size(16),
        binary::binary
      >>) do
    {
      %__MODULE__{
        name_index: name_index,
        descriptor_index: descriptor_index
      },
      binary
    }
  end
end
