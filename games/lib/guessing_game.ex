defmodule Games.GuessingGame do
  def play do
    answer = Enum.random(1..10)

    (IO.gets("Guess a number between 1 and 10:") == Integer.to_string(answer) <> "\n" &&
       "You win!") || "Incorrect!"
  end
end
