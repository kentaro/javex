defmodule Javex.ClassFile.Attribute.SourceFile do
  defstruct [
    :attribute_length,
    :sourcefile_index
  ]

  def read_from(
        <<
          attribute_length::size(32),
          sourcefile_index::size(16),
          binary::binary
        >>,
        _class_file
      ) do
    {
      %__MODULE__{
        attribute_length: attribute_length,
        sourcefile_index: sourcefile_index
      },
      binary
    }
  end
end
