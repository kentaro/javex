defmodule Javex do
  @moduledoc """
  Documentation for `Javex`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Javex.hello()
      :world

  """
  def run(file_name) when is_binary(file_name) do
    file_name
    |> File.read()
    |> run()
  end

  def run({:ok, binary}) do
    binary
    |> Javex.Parser.parse()
    |> Javex.VM.run()
  end

  def run({:error, reason}) do
    raise("Error: #{reason}")
  end
end
