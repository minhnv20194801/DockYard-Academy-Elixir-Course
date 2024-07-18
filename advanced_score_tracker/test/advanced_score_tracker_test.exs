defmodule AdvancedScoreTrackerTest do
  use ExUnit.Case
  doctest AdvancedScoreTracker

  test "greets the world" do
    assert AdvancedScoreTracker.hello() == :world
  end

  test "new/2 player start new game" do
    Games.ScoreTracker.new(:player1, :ping_pong)
    0 = Games.ScoreTracker.get(:player1, :ping_pong)
  end

  test "add/3 add player score to tracker" do
    Games.ScoreTracker.add(:player2, :ping_pong, 10)
    Games.ScoreTracker.add(:player2, :ping_pong, 10)
    20 = Games.ScoreTracker.get(:player2, :ping_pong)
  end

  test "history/2 check player score history" do
    Games.ScoreTracker.new(:player3, :ping_pong)
    Games.ScoreTracker.new(:player3, :ping_pong)
    Games.ScoreTracker.add(:player3, :ping_pong, 10)
    Games.ScoreTracker.add(:player3, :ping_pong, 10)
    [0, 20] =  Games.ScoreTracker.history(:player3, :ping_pong)
  end

  test "high_score/2 return player game high score" do
    Games.ScoreTracker.add(:player4, :ping_pong, 10)
    Games.ScoreTracker.add(:player4, :ping_pong, 10)
    20 = Games.ScoreTracker.high_score(:player4, :ping_pong)
  end

  test "high_score/1 return all player all-time game high score" do
    Games.ScoreTracker.new(:player5, :ping_pong)
    Games.ScoreTracker.add(:player5, :ping_pong, 10)
    Games.ScoreTracker.add(:player5, :ping_pong, 10)
    Games.ScoreTracker.add(:player5, :ping_pong, 10)

    30 =  Games.ScoreTracker.high_score(:ping_pong)
  end
end
