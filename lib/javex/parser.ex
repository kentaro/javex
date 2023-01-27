defmodule Javex.Parser do
  alias Javex.Struct.{
    Attribute,
    ClassFile,
    ConstantPool,
    Field,
    Method
  }

  def parse(binary) when is_binary(binary) do
    {%ClassFile{}, binary}
    |> parse_header()
    |> parse_constant_pool()
    |> parse_class()
    |> parse_interfaces()
    |> parse_fields()
    |> parse_methods()
    |> parse_attributes()
  end

  def parse_header({
        class_file,
        <<
          magic::size(32),
          minor_version::size(16),
          major_version::size(16),
          binary::binary
        >>
      }) do
    class_file =
      Map.merge(class_file, %{
        magic: magic,
        minor_version: minor_version,
        major_version: major_version
      })

    {class_file, binary}
  end

  def parse_constant_pool({
        class_file,
        <<
          constant_pool_count::size(16),
          binary::binary
        >>
      }) do
    {constant_pool, binary} =
      if constant_pool_count == 0 do
        {[], binary}
      else
        1..(constant_pool_count - 1)
        |> Enum.reduce({[], binary}, fn _, acc ->
          {constant_pool, binary} = acc
          {constant, binary} = ConstantPool.read_from(binary)
          {[constant | constant_pool], binary}
        end)
      end

    class_file =
      Map.merge(class_file, %{
        constant_pool_count: constant_pool_count,
        constant_pool: constant_pool |> Enum.reverse()
      })

    {class_file, binary}
  end

  def parse_class({
        class_file,
        <<
          access_flags::size(16),
          this_class::size(16),
          super_class::size(16),
          binary::binary
        >>
      }) do
    class_file =
      Map.merge(class_file, %{
        access_flags: access_flags,
        this_class: this_class,
        super_class: super_class
      })

    {class_file, binary}
  end

  def parse_interfaces({
        class_file,
        <<
          interfaces_count::size(16),
          binary::binary
        >>
      }) do
    {interfaces, binary} =
      if interfaces_count == 0 do
        {[], binary}
      else
        1..interfaces_count
        |> Enum.reduce({[], binary}, fn _, acc ->
          {interfaces, binary} = acc
          {interface, binary} = read_2bytes(binary)
          {[interface | interfaces], binary}
        end)
      end

    class_file =
      Map.merge(class_file, %{
        interfaces_count: interfaces_count,
        interfaces: interfaces |> Enum.reverse()
      })

    {class_file, binary}
  end

  def parse_fields({
        class_file,
        <<
          fields_count::size(16),
          binary::binary
        >>
      }) do
    {fields, binary} =
      if fields_count == 0 do
        {[], binary}
      else
        1..fields_count
        |> Enum.reduce({[], binary}, fn _, acc ->
          {fields, binary} = acc
          {field, binary} = Field.read_from(binary)
          {[field | fields], binary}
        end)
      end

    class_file =
      Map.merge(class_file, %{
        fields_count: fields_count,
        fields: fields |> Enum.reverse()
      })

    {class_file, binary}
  end

  def parse_methods({
        class_file,
        <<
          methods_count::size(16),
          binary::binary
        >>
      }) do
    {methods, binary} =
      if methods_count == 0 do
        {[], binary}
      else
        1..methods_count
        |> Enum.reduce({[], binary}, fn _, acc ->
          {methods, binary} = acc
          {method, binary} = Method.read_from(binary)
          {[method | methods], binary}
        end)
      end

    class_file =
      Map.merge(class_file, %{
        methods_count: methods_count,
        methods: methods |> Enum.reverse()
      })

    {class_file, binary}
  end

  def parse_attributes({
        class_file,
        <<
          attributes_count::size(16),
          binary::binary
        >>
      }) do
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

    class_file =
      Map.merge(class_file, %{
        attributes_count: attributes_count,
        attributes: attributes |> Enum.reverse()
      })

    {class_file, binary}
  end

  defp read_2bytes(<<
         field::size(16),
         binary::binary
       >>) do
    {field, binary}
  end
end
