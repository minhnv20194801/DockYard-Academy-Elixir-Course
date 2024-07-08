defmodule Games.Score do
  def add_points(points) do
    Process.whereis(:ScoreTracker)
    |> Games.ScoreTracker.add_points(points)
  end

  def current_score() do
    Process.whereis(:ScoreTracker)
    |> Games.ScoreTracker.current_score()
  end
end
