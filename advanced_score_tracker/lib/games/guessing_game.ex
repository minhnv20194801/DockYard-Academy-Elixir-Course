defmodule Games.GuessingGame do
  @moduledoc """
  Documentation for `Games.GuessingGame`.
  """
  def play(player, answer \\ nil, attempt \\ 1) do
    answer = answer || Enum.random(1..10)
    guess = IO.gets("Guess a number between 1 and 10: ") |> String.trim() |> String.to_integer()

    cond do
      answer == guess ->
        Games.ScoreTracker.add(player, :guessing_game, 10)
        IO.puts("You win!")
        choice = IO.gets("Would you like to continue? (Y/n) ") |> String.trim()

        case choice do
          "n" -> :ok
          _ -> play(player)
        end

      attempt == 5 ->
        IO.puts("You lose! The answer was #{answer}!")

        choice = IO.gets("Would you like to continue? (Y/n) ") |> String.trim()

        case choice do
          "n" -> :ok
          _ -> play(player)
        end

      guess < answer ->
        IO.puts("Too low!")
        play(player, answer, attempt + 1)

      guess > answer ->
        IO.puts("Too high!")
        play(player, answer, attempt + 1)
    end
  end
end
