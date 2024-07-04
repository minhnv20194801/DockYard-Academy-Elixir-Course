defmodule Games.GuessingGame do
  def play do
    answer = Integer.to_string(Enum.random(1..10)) <> "\n"
    guess = IO.gets("Guess a number between 1 and 10:")

    cond do
      guess == answer -> "You win!"
      true ->
        IO.puts("Incorrect!")
        play()
    end
  end
end
