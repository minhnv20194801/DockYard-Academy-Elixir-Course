defmodule Games.GuessingGame do
  def play do
    answer = Enum.random(1..10)
    |> replay
  end

  def replay(answer) do
    IO.puts(answer)
    guess = String.to_integer(String.trim(IO.gets("Guess a number between 1 and 10:"), "\n"))

    cond do
      guess == answer -> "You win!"
      guess > answer ->
        IO.puts("Too High!")
        replay(answer)
      guess < answer ->
        IO.puts("Too Low!")
        replay(answer)
    end
  end
end
