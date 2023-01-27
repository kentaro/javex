defmodule Javex.ClassFile.Attribute do
  defstruct [
    :attribute_name_index,
    :attribute_length,
    :info
  ]

  def read_from(<<
        attribute_name_index::size(16),
        attribute_length::size(32),
        info::size(attribute_length * 8),
        binary::binary
      >>) do

    {
      %__MODULE__{
        attribute_name_index: attribute_name_index,
        attribute_length: attribute_length,
        info: info
      },
      binary
    }
  end
end
