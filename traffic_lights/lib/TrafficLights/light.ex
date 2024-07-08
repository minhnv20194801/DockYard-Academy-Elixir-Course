defmodule TrafficLights.Light do
  def start_link(opts) do
    GenServer.start_link(TrafficLights, nil, opts)
  end

  def current_light(pid) do
    GenServer.call(pid, :current_light)
  end

  def transition(pid) do
    GenServer.cast(pid, :transition)
  end
end
