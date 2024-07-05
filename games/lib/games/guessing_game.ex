defmodule Games.GuessingGame do
  @moduledoc """
  Module to play the Guessing game, where user try to guess a number from 1 to 10
  """
  @spec play() :: :ok
  def play do
    Enum.random(1..10)
    |> replay(5)
  end

  @spec replay(String.t(), 0) :: :ok
  def replay(answer, 0) do
    IO.puts("You lose! the answer war #{answer}")
  end

  @spec replay(String.t(), integer()) :: :ok
  def replay(answer, attempt_count) do
    guess = String.to_integer(String.trim(IO.gets("Guess a number between 1 and 10:"), "\n"))

    cond do
      guess == answer ->
        IO.puts("You win!")

      guess > answer ->
        IO.puts("Too High!")
        replay(answer, attempt_count - 1)

      guess < answer ->
        IO.puts("Too Low!")
        replay(answer, attempt_count - 1)
    end
  end
end
