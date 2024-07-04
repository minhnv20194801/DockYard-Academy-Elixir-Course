defmodule Games.RockPaperScissors do
  def play do
    perfect_ai = fn player_choice ->
      case player_choice do
        "rock" -> "paper"
        "paper" -> "scissors"
        "scissors" -> "rock"
      end
    end

    loser_ai = fn player_choice ->
      case player_choice do
        "rock" -> "scissors"
        "paper" -> "rock"
        "scissors" -> "paper"
      end
    end

    match_result_calculator = fn player1_choice, player2_choice ->
      player1_winning_choice = perfect_ai.(player2_choice)
      player1_losing_choice = loser_ai.(player2_choice)

      case player1_choice do
        ^player1_winning_choice -> "Player 1 wins!"
        ^player1_losing_choice -> "Player 2 wins!"
        _ -> "Draw"
      end
    end

    ai_choice = Enum.random(["rock", "paper", "scissors"])
    player_choice = String.trim(IO.gets("Choose rock, paper, or scissors: "), "\n")

    cond do
      match_result_calculator.(ai_choice, player_choice) == "Player 1 wins!" ->
        "You lose! #{ai_choice} beats #{player_choice}."

      match_result_calculator.(player_choice, ai_choice) == "Player 1 wins!" ->
        "You win! #{player_choice} beats #{ai_choice}."

      true ->
        "It's a tie!"
    end
  end
end
