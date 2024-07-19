defmodule RubixCube do
  @moduledoc """
  Documentation for `RubixCube`.
  """

  def main(args \\ []) do
    RubixCube.RubixCube.show() |> IO.puts()

    choice =
      IO.gets("""
      1. Rotate left up
      2. Rotate left down
      3. Rotate right up
      4. Rotate right down
      5. Rotate front clockwise
      6. Rotate front counter clockwise
      7. Rotate back clockwise
      8. Rotate back counter clockwise
      9. Rotate top left
      10. Rotate top right
      11. Rotate bottom left
      12. Rotate bottom right

      enter "stop" to exit
      enter "check" to see if the rubix is solved
      enter "save" to save your progress
      """)
      |> String.trim()

    case choice do
      "stop" ->
        {:ok, json} = Jason.encode(RubixCube.RubixCube.get())
        File.write("rubix_save_state", json)
        IO.puts("Your progress have been saved")
        :ok

      "save" ->
        {:ok, json} = Jason.encode(RubixCube.RubixCube.get())
        File.write("rubix_save_state", json)
        IO.puts("Your progress have been saved")

      "check" ->
        if RubixCube.RubixCube.check() do
          IO.puts("CONGRATULATIONS! YOU HAVE SOLVED THE RUBIX")
        else
          IO.puts("This rubix doesn't look right...")
        end

      "1" ->
        RubixCube.RubixCube.rotate_left_up()

      "2" ->
        RubixCube.RubixCube.rotate_left_down()

      "3" ->
        RubixCube.RubixCube.rotate_right_up()

      "4" ->
        RubixCube.RubixCube.rotate_right_down()

      "5" ->
        RubixCube.RubixCube.rotate_front_clockwise()

      "6" ->
        RubixCube.RubixCube.rotate_front_counter_clockwise()

      "7" ->
        RubixCube.RubixCube.rotate_back_clockwise()

      "8" ->
        RubixCube.RubixCube.rotate_back_counter_clockwise()

      "9" ->
        RubixCube.RubixCube.rotate_top_left()

      "10" ->
        RubixCube.RubixCube.rotate_top_right()

      "11" ->
        RubixCube.RubixCube.rotate_bottom_left()

      "12" ->
        RubixCube.RubixCube.rotate_bottom_right()

      _ ->
        IO.puts("Invalid choice!")
    end

    unless choice == "stop" do
      main(args)
    end
  end
end
