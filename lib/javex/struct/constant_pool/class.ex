defmodule Javex.Struct.ConstantPool.Class do
  defstruct [:name_index]

  def read_from(<<
        name_index::size(16),
        binary::binary
      >>) do
    {
      %__MODULE__{
        name_index: name_index
      },
      binary
    }
  end
end
