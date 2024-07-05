defmodule Games do
  @moduledoc """
  Documentation for `Games`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Games.hello()
      :world

  """
  def hello do
    :world
  end

  def main(_args) do
    play()
  end

  defp play() do
    IO.gets("""
    ===========================================
    What game would you like to play?
    1. Guessing Game
    2. Rock Paper Scissors
    3. Wordle

    enter "stop" to exit
    ===========================================
    """)
    |> String.trim("\n")
    |> String.downcase()
    |> case do
      x when x in ["guessing game", "1"] ->
        Games.GuessingGame.play()
        play()

      x when x in ["rock paper scissors", "2"] ->
        Games.RockPaperScissors.play()
        play()

      x when x in ["wordle", "3"] ->
        Games.Wordle.play()
        play()

      "stop" ->
        IO.puts("Thank you for playing! Hope you have a great time!")

      _ ->
        play()
    end
  end
end
