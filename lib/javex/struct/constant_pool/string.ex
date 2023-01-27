defmodule Javex.Struct.ConstantPool.String do
  defstruct [:string_index]

  def read_from(<<
        string_index::size(16),
        binary::binary
      >>) do
    {
      %__MODULE__{
        string_index: string_index
      },
      binary
    }
  end
end
