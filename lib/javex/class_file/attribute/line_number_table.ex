defmodule Javex.ClassFile.Attribute.LineNumberTable do
  defstruct [
    :attribute_length,
    :line_number_table_length,
    :line_number_table
  ]

  alias Javex.ClassFile.Attribute.LineNumberTableItem

  def read_from(
        <<
          attribute_length::size(32),
          line_number_table_length::size(16),
          binary::binary
        >>,
        _class_file
      ) do
    {line_number_table, binary} =
      if line_number_table_length == 0 do
        {[], binary}
      else
        1..line_number_table_length
        |> Enum.reduce({[], binary}, fn _, acc ->
          {line_number_table, binary} = acc
          {item, binary} = LineNumberTableItem.read_from(binary)
          {[item | line_number_table], binary}
        end)
      end

    {
      %__MODULE__{
        attribute_length: attribute_length,
        line_number_table_length: line_number_table_length,
        line_number_table: line_number_table |> Enum.reverse()
      },
      binary
    }
  end
end
