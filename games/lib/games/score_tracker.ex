defmodule Games.ScoreTracker do
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: :ScoreTracker)
  end

  def add_points(score_tracker_pid, points) do
    GenServer.cast(score_tracker_pid, {:add_points, points})
  end

  def current_score(score_tracker_pid) do
    GenServer.call(score_tracker_pid, :get_score)
  end

  def init(_args) do
    {:ok, 0}
  end

  def handle_cast({:add_points, points}, state) do
    {:noreply, state + points}
  end

  def handle_call(:get_score, _from, state) do
    {:reply, state, state}
  end
end
