defmodule Javex.ClassFile.Attribute.Code do
  defstruct [
    :attribute_length,
    :max_stack,
    :max_locals,
    :code_length,
    :code,
    :exception_table_length,
    :exception_table,
    :attributes_count,
    :attributes
  ]

  alias Javex.ClassFile.Attribute

  def read_from(
        <<
          attribute_length::size(32),
          max_stack::size(16),
          max_locals::size(16),
          code_length::size(32),
          code::size(code_length * 8),
          exception_table_length::size(16),
          exception_table::size(exception_table_length * 8),
          attributes_count::size(16),
          binary::binary
        >>,
        class_file
      ) do
    {attributes, binary} =
      if attributes_count == 0 do
        {[], binary}
      else
        1..attributes_count
        |> Enum.reduce({[], binary}, fn _, acc ->
          {attributes, binary} = acc
          {attribute, binary} = Attribute.read_from(binary, class_file)
          {[attribute | attributes], binary}
        end)
      end

    {
      %__MODULE__{
        attribute_length: attribute_length,
        max_stack: max_stack,
        max_locals: max_locals,
        code_length: code_length,
        code: code,
        exception_table_length: exception_table_length,
        exception_table: exception_table,
        attributes_count: attributes_count,
        attributes: attributes |> Enum.reverse()
      },
      binary
    }
  end
end
