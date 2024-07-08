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
    Games.ScoreTracker.start_link()
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
    enter "score" to view your current score
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

      "score" ->
        IO.puts("""

        ===========================================
        Your score is #{Games.Score.current_score()}
        ===========================================

        """)

        play()

      _ ->
        play()
    end
  end
end
