defmodule Games.RockPaperScissors do
  @moduledoc """
  Module to play the game Rock-paper-scissors
  """
  @spec play() :: String.t()
  def play do
    ai_choice = Enum.random(["rock", "paper", "scissors"])
    player_choice = String.trim(IO.gets("Choose rock, paper, or scissors: "), "\n")

    winner_choice = winning_choice(ai_choice)
    loser_choice = losing_choice(ai_choice)
    case player_choice do
      ^winner_choice -> IO.puts("You win! #{player_choice} beats #{ai_choice}.")
      ^loser_choice -> IO.puts("You lose! #{ai_choice} beats #{player_choice}.")
      _ -> IO.puts("It's a tie!")
    end
  end

  defp winning_choice(choice) do
    case choice do
      "rock" -> "paper"
      "paper" -> "scissors"
      "scissors" -> "rock"
    end
  end

  defp losing_choice(choice) do
    case choice do
      "rock" -> "scissors"
      "paper" -> "rock"
      "scissors" -> "paper"
    end
  end
end
