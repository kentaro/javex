defmodule Javex.ClassFile.Field do
  defstruct [
    :access_flags,
    :name_index,
    :descriptor_index,
    :attributes_count,
    :attributes
  ]

  alias Javex.ClassFile.Attribute

  def read_from(<<
        access_flags::size(16),
        name_index::size(16),
        descriptor_index::size(16),
        attributes_count::size(16),
        binary::binary
      >>) do
    {attributes, binary} =
      if attributes_count == 0 do
        {[], binary}
      else
        1..attributes_count
        |> Enum.reduce({[], binary}, fn _, acc ->
          {attributes, binary} = acc
          {attribute, binary} = Attribute.read_from(binary)
          {[attribute | attributes], binary}
        end)
      end

    {
      %__MODULE__{
        access_flags: access_flags,
        name_index: name_index,
        descriptor_index: descriptor_index,
        attributes_count: attributes_count,
        attributes: attributes
      },
      binary
    }
  end
end
