defmodule Games.GuessingGame do
  def play do
    Enum.random(1..10)
    |> replay(5)
  end

  def replay(answer) do
    guess = String.to_integer(String.trim(IO.gets("Guess a number between 1 and 10:"), "\n"))

    cond do
      guess == answer ->
        "You win!"

      guess > answer ->
        IO.puts("Too High!")
        replay(answer)

      guess < answer ->
        IO.puts("Too Low!")
        replay(answer)
    end
  end

  def replay(answer, 0) do
    IO.puts("You lose! the answer war #{answer}")
  end

  def replay(answer, attempt_count) do
    guess = String.to_integer(String.trim(IO.gets("Guess a number between 1 and 10:"), "\n"))

    cond do
      guess == answer ->
        "You win!"

      guess > answer ->
        IO.puts("Too High!")
        replay(answer, attempt_count - 1)

      guess < answer ->
        IO.puts("Too Low!")
        replay(answer, attempt_count - 1)
    end
  end
end
