defmodule RubixCubeTest do
  use ExUnit.Case
  doctest RubixCube

  test "greets the world" do
    RubixCube.RubixCube.rotate_front_clockwise()
    RubixCube.RubixCube.show() |> IO.puts()
    IO.puts("Done!")
  end
end
