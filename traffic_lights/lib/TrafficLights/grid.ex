defmodule TrafficLights.Grid do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  def current_lights(pid) do
    GenServer.call(pid, :current_lights)
  end

  def transition(pid) do
    GenServer.cast(pid, :transition)
  end

  def init(_opts) do
    initial_list =
      Enum.map(1..5, fn _ ->
        {:ok, pid} = TrafficLights.Light.start_link([])
        pid
      end)
    {:ok, initial_list}
  end

  def handle_cast(:transition, state) do
    green_index =
      Enum.find_index(state, fn pid ->
        TrafficLights.Light.current_light(pid) == :green
      end)

    yellow_index =
      Enum.find_index(state, fn pid ->
        TrafficLights.Light.current_light(pid) == :yellow
      end)

    red_index =
      Enum.find_index(state, fn pid ->
        TrafficLights.Light.current_light(pid) == :red
      end)

    cond do
      green_index != nil ->
        TrafficLights.Light.transition(Enum.at(state, green_index))

      yellow_index != nil ->
        TrafficLights.Light.transition(Enum.at(state, yellow_index))

      red_index != nil ->
        TrafficLights.Light.transition(Enum.at(state, red_index))
    end

    {:noreply, state}
  end

  def handle_call(:current_lights, _from, state) do
    current_lights_state = Enum.map(state, fn pid ->
      TrafficLights.Light.current_light(pid)
    end)

    {:reply, current_lights_state, state}
  end
end
