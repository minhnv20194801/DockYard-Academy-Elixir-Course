defmodule Games.RockPaperScissors do
  @moduledoc """
  Documentation for `Games.RockPaperScissors`.
  """
  @type choice :: String.t()

  @doc """
  Starts the game.

  ## Examples

      Games.RockPaperScissors.play()
  """
  def play(player) do
    ai_choice = Enum.random(["rock", "paper", "scissors"])
    player_choice = IO.gets("Choose rock, paper, or scissors: ") |> String.trim()

    message =
      cond do
        ai_choice == player_choice ->
          "It's a tie!"

        beats?(player_choice, ai_choice) ->
          Games.ScoreTracker.add(player, :rock_paper_scissors, 10)
          # Games.ScoreTracker.add_points(10)
          "You win!"

        beats?(ai_choice, player_choice) ->
          "You lose!"

        true ->
          "Invalid choice!"
      end

    IO.puts(message)

    choice = IO.gets("Would you like to continue? (Y/n) ") |> String.trim()

    case choice do
      "n" -> :ok
      _ -> play(player)
    end
  end

  @spec beats?(choice(), choice()) :: boolean()
  defp beats?(choice1, choice2),
    do: {choice1, choice2} in [{"rock", "scissors"}, {"paper", "rock"}, {"scissors", "paper"}]
end
