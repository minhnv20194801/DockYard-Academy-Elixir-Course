defmodule Greeting do
  @moduledoc """
  Documentation for `Greeting`.
  """

  @doc """
  Hello world.
  """
  def hello do
    :world
  end

  def main(args) do
    {opts, _word, _erroes} = OptionParser.parse(args, switches: [upcase: :boolean])
    IO.puts(opts[:upcase] && String.upcase("Good morning!") || "Good morning!")
  end
end
