defmodule TrafficLightsGridTest do
  use ExUnit.Case
  doctest TrafficLights

  test "transition/1 from green -> yellow -> red -> green" do
    {:ok, pid} = TrafficLights.Grid.start_link([])

    :ok = TrafficLights.Grid.transition(pid)

    [:yellow, :green, :green, :green, :green] = TrafficLights.Grid.current_lights(pid)

    :ok = TrafficLights.Grid.transition(pid)
    :ok = TrafficLights.Grid.transition(pid)
    :ok = TrafficLights.Grid.transition(pid)
    :ok = TrafficLights.Grid.transition(pid)
    :ok = TrafficLights.Grid.transition(pid)

    [:red, :yellow, :yellow, :yellow, :yellow] = TrafficLights.Grid.current_lights(pid)

    :ok = TrafficLights.Grid.transition(pid)
    :ok = TrafficLights.Grid.transition(pid)
    :ok = TrafficLights.Grid.transition(pid)
    :ok = TrafficLights.Grid.transition(pid)
    :ok = TrafficLights.Grid.transition(pid)

    [:green, :red, :red, :red, :red] = TrafficLights.Grid.current_lights(pid)
  end
end
