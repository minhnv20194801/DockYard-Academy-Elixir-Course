defmodule Games do
  @moduledoc """
  Documentation for `Games`.
  """

  @doc """
  """
  def main(args \\ []) do
    player = Keyword.get(args, :player, "Player")

    choice =
      IO.gets("""
      Hello #{player}
      What game would you like to play?
      1. Guessing Game
      2. Rock Paper Scissors
      3. Wordle

      enter "stop" to exit
      enter "score" to view your current score
      enter "change" to change into another player
      """)
      |> String.trim()

    case choice do
      "stop" ->
        :ok

      "change" ->
        player = IO.gets("Enter your player name: ") |> String.trim()
        main(player: player)

      "score" ->
        IO.puts("""
          ==================================================
          Your score is
          Guessing Game: #{Games.ScoreTracker.get(player, :guessing_game)}
          History: #{Enum.join(Games.ScoreTracker.history(player, :guessing_game))}
          High Score: #{Games.ScoreTracker.high_score(player, :guessing_game)}
          All-time high: #{Games.ScoreTracker.high_score(:guessing_game)}
          ==================================================
          Rock Paper Scissors: #{Games.ScoreTracker.get(player, :rock_paper_scissors)}
          History: #{Enum.join(Games.ScoreTracker.history(player, :rock_paper_scissors))}
          High Score: #{Games.ScoreTracker.high_score(player, :rock_paper_scissors)}
          All-time high: #{Games.ScoreTracker.high_score(:rock_paper_scissors)}
          ==================================================
          Wordle: #{Games.ScoreTracker.get(player, :wordle)}
          History: #{Enum.join(Games.ScoreTracker.history(player, :wordle))}
          High Score: #{Games.ScoreTracker.high_score(player, :wordle)}
          All-time high: #{Games.ScoreTracker.high_score(:wordle)}
          ==================================================
        """)

      "1" ->
        Games.ScoreTracker.new(player, :guessing_game)
        Games.GuessingGame.play(player)

      "2" ->
        Games.ScoreTracker.new(player, :rock_paper_scissors)
        Games.RockPaperScissors.play(player)

      "3" ->
        Games.ScoreTracker.new(player, :wordle)
        Games.Wordle.play(player)

      _ ->
        IO.puts("Invalid choice!")
    end

    unless choice == "stop" || choice == "change" do
      main(player: player)
    end
  end
end
