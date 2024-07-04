defmodule GamesWordleTest do
  use ExUnit.Case

  test "feedback/0 all green" do
    assert Games.Wordle.feedback("toast", "toast") == [:green, :green, :green, :green, :green]
  end

  test "feedback/0 all yellow" do
    assert Games.Wordle.feedback("toast", "oatts") == [:yellow, :yellow, :yellow, :yellow, :yellow]
  end

  test "feedback/0 all grey" do
    assert Games.Wordle.feedback("toast", "jimmy") == [:grey, :grey, :grey, :grey, :grey]
  end

  test "feedback/0 some green, yellow, and grey" do
    assert Games.Wordle.feedback("toast", "tosth") == [:green, :green, :yellow, :yellow, :grey]
  end

  test "feedback/0 edge case" do
    assert Games.Wordle.feedback("XXXAA", "AAAAY") == [:yellow, :grey, :grey, :green, :grey]
  end
end
