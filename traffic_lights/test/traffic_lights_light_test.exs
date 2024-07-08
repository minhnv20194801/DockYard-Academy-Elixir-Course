defmodule TrafficLightsTest do
  use ExUnit.Case
  doctest TrafficLights

  test "start_link/1 with default options" do
    {:ok, pid} = TrafficLights.Light.start_link([])
    assert TrafficLights.Light.current_light(pid) == :green
  end

  test "transition/1 from green -> yellow -> red -> green" do
    {:ok, pid} = TrafficLights.Light.start_link([])

    :green = TrafficLights.Light.current_light(pid)
    :ok = TrafficLights.Light.transition(pid)

    :yellow = TrafficLights.Light.current_light(pid)
    :ok = TrafficLights.Light.transition(pid)

    :red = TrafficLights.Light.current_light(pid)
    :ok = TrafficLights.Light.transition(pid)

    :green = TrafficLights.Light.current_light(pid)
  end
end
