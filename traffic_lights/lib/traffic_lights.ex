defmodule TrafficLights do
  use GenServer

  @impl true
  def init(_opts) do
    {:ok, :green}
  end

  @impl true
  def handle_cast(:transition, state) do
    case state do
      :green ->
        {:noreply, :yellow}

      :yellow ->
        {:noreply, :red}

      :red ->
        {:noreply, :green}
    end
  end

  @impl true
  def handle_call(:current_light, _from, state) do
    {:reply, state, state}
  end
end
