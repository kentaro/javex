defmodule Javex.ClassFile.Attribute do
  alias Javex.ClassFile.Attribute.{
    Code,
    LineNumberTable,
    SourceFile
  }

  @constants %{
    "Code" => Code,
    "LineNumberTable" => LineNumberTable,
    "SourceFile" => SourceFile
  }

  def read_from(
        <<
          attribute_name_index::size(16),
          binary::binary
        >>,
        class_file
      ) do
    attribute_name =
      class_file.constant_pool
      |> Enum.at(attribute_name_index - 1)
      |> Map.get(:bytes)

    Map.get(@constants, attribute_name).read_from(binary, class_file)
  end
end
