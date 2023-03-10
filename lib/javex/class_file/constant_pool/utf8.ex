defmodule Javex.ClassFile.ConstantPool.Utf8 do
  defstruct [:length, :bytes]

  def read_from(<<
        length::size(16),
        bytes::bitstring-size(length * 8),
        binary::binary
      >>) do
    {
      %__MODULE__{
        length: length,
        bytes: bytes
      },
      binary
    }
  end
end
