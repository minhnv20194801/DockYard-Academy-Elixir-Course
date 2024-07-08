defmodule GamesTest do
  use ExUnit.Case
  doctest Games

  test "current_score/1 retrieves the current score" do
    {:ok, _pid} = Games.ScoreTracker.start_link()
    assert Games.Score.current_score() == 0
  end

  test "add_points/1 adds points to the score" do
    {:ok, _pid} = Games.ScoreTracker.start_link()
    :ok = Games.Score.add_points(10)
    :ok = Games.Score.add_points(10)
    assert Games.Score.current_score() == 20
  end
end
