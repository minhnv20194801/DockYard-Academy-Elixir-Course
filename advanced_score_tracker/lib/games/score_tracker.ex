defmodule Games.ScoreTracker do
  use Agent

  def start_link(initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def new(player, game) do
    player_scores =
      Map.get(
        Agent.get(__MODULE__, fn state ->
          state
        end),
        player,
        %{}
      )

    game_scores =
      Map.put(player_scores, game, Map.get(player_scores, game, []) ++ [0])

    Agent.cast(__MODULE__, fn state ->
      Map.put(state, player, game_scores)
    end)
  end

  def history(player, game) do
    Agent.get(__MODULE__, fn state -> Map.get(Map.get(state, player, %{}), game, []) end)
  end

  def get(player, game) do
    Agent.get(__MODULE__, fn state ->
      List.last(Map.get(Map.get(state, player, %{}), game, [0]))
    end)
  end

  def add(player, game, points) do
    Agent.cast(__MODULE__, fn state ->
      game_scores =
        Map.get(Map.get(state, player, %{}), game, [0])

      new_game_scores =
        List.update_at(game_scores, -1, fn score ->
          score + points
        end)

      Map.put(state, player, Map.put(Map.get(state, player, %{}), game, new_game_scores))
    end)
  end

  def high_score(player, game) do
    Agent.get(__MODULE__, fn state ->
      Enum.reduce(Map.get(Map.get(state, player, %{}), game, []), 0, fn score, acc ->
        if score > acc do
          score
        else
          acc
        end
      end)
    end)
  end

  def high_score(game) do
    Agent.get(__MODULE__, fn state ->
      Enum.reduce(state, 0, fn {player, _player_map}, acc ->
        player_high_score =
          Enum.reduce(Map.get(Map.get(state, player, %{}), game, [0]), 0, fn score, acc ->
            if score > acc do
              score
            else
              acc
            end
          end)

        if player_high_score > acc do
          player_high_score
        else
          acc
        end
      end)
    end)
  end
end
