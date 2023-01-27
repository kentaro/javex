defmodule Javex.ClassFile.Attribute.LineNumberTableItem do
  defstruct [
    :start_pc,
    :line_number
  ]

  def read_from(<<
        start_pc::size(16),
        line_number::size(16),
        binary::binary
      >>) do
    {
      %__MODULE__{
        start_pc: start_pc,
        line_number: line_number
      },
      binary
    }
  end
end
