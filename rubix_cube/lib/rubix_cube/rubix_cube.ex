defmodule RubixCube.RubixCube do
  alias Utils.Matrix

  use GenServer

  defstruct front: [[:red, :red, :red], [:red, :red, :red], [:red, :red, :red]],
            top: [[:blue, :blue, :blue], [:blue, :blue, :blue], [:blue, :blue, :blue]],
            bottom: [[:green, :green, :green], [:green, :green, :green], [:green, :green, :green]],
            left: [[:white, :white, :white], [:white, :white, :white], [:white, :white, :white]],
            right: [
              [:yellow, :yellow, :yellow],
              [:yellow, :yellow, :yellow],
              [:yellow, :yellow, :yellow]
            ],
            back: [
              [:orange, :orange, :orange],
              [:orange, :orange, :orange],
              [:orange, :orange, :orange]
            ]

  def start_link(opts) do
    initial_state = Keyword.get(opts, :state) || %RubixCube.RubixCube{}
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def show() do
    GenServer.call(__MODULE__, :show)
  end

  def check() do
    GenServer.call(__MODULE__, :check)
  end

  def rotate_left_up() do
    GenServer.cast(__MODULE__, :rotate_left_up)
  end

  def rotate_left_down() do
    GenServer.cast(__MODULE__, :rotate_left_down)
  end

  def rotate_right_up() do
    GenServer.cast(__MODULE__, :rotate_right_up)
  end

  def rotate_right_down() do
    GenServer.cast(__MODULE__, :rotate_right_down)
  end

  def rotate_front_clockwise() do
    GenServer.cast(__MODULE__, :rotate_front_clockwise)
  end

  def rotate_front_counter_clockwise() do
    GenServer.cast(__MODULE__, :rotate_front_counter_clockwise)
  end

  def rotate_back_clockwise() do
    GenServer.cast(__MODULE__, :rotate_back_clockwise)
  end

  def rotate_back_counter_clockwise() do
    GenServer.cast(__MODULE__, :rotate_back_counter_clockwise)
  end

  def rotate_top_left() do
    GenServer.cast(__MODULE__, :rotate_top_left)
  end

  def rotate_top_right() do
    GenServer.cast(__MODULE__, :rotate_top_right)
  end

  def rotate_bottom_left() do
    GenServer.cast(__MODULE__, :rotate_bottom_left)
  end

  def rotate_bottom_right() do
    GenServer.cast(__MODULE__, :rotate_bottom_right)
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:check, _from, state) do
    is_solved =
      Enum.all?([:front, :top, :back, :bottom, :left, :right], fn face ->
        Enum.all?(Map.get(state, face), fn row ->
          MapSet.new(row)
          |> MapSet.size() == 1
        end) &&
          Enum.all?(Matrix.transpose(Map.get(state, face)), fn col ->
            MapSet.new(col)
            |> MapSet.size() == 1
          end)
      end)

    {:reply, is_solved, state}
  end

  def handle_call(:show, _from, state) do
    top_face =
      Enum.map(state.top, fn row ->
        Enum.map(row, fn color ->
          cond do
            color in [:red, "red"] ->
              IO.ANSI.red() <> "T"

            color in [:blue, "blue"] ->
              IO.ANSI.blue() <> "T"

            color in [:yellow, "yellow"] ->
              IO.ANSI.yellow() <> "T"

            color in [:green, "green"] ->
              IO.ANSI.green() <> "T"

            color in [:white, "white"] ->
              IO.ANSI.white() <> "T"

            color in [:orange, "orange"] ->
              IO.ANSI.color(5, 3, 0) <> "T"
          end
        end)
      end)

    front_face =
      Enum.map(state.front, fn row ->
        Enum.map(row, fn color ->
          cond do
            color in [:red, "red"] ->
              IO.ANSI.red() <> "F"

            color in [:blue, "blue"] ->
              IO.ANSI.blue() <> "F"

            color in [:yellow, "yellow"] ->
              IO.ANSI.yellow() <> "F"

            color in [:green, "green"] ->
              IO.ANSI.green() <> "F"

            color in [:white, "white"] ->
              IO.ANSI.white() <> "F"

            color in [:orange, "orange"] ->
              IO.ANSI.color(5, 3, 0) <> "F"
          end
        end)
      end)

    bottom_face =
      Enum.map(state.bottom, fn row ->
        Enum.map(row, fn color ->
          cond do
            color in [:red, "red"] ->
              IO.ANSI.red() <> "Bo"

            color in [:blue, "blue"] ->
              IO.ANSI.blue() <> "Bo"

            color in [:yellow, "yellow"] ->
              IO.ANSI.yellow() <> "Bo"

            color in [:green, "green"] ->
              IO.ANSI.green() <> "Bo"

            color in [:white, "white"] ->
              IO.ANSI.white() <> "Bo"

            color in [:orange, "orange"] ->
              IO.ANSI.color(5, 3, 0) <> "Bo"
          end
        end)
      end)

    back_face =
      Enum.map(state.back, fn row ->
        Enum.map(row, fn color ->
          cond do
            color in [:red, "red"] ->
              IO.ANSI.red() <> "Ba"

            color in [:blue, "blue"] ->
              IO.ANSI.blue() <> "Ba"

            color in [:yellow, "yellow"] ->
              IO.ANSI.yellow() <> "Ba"

            color in [:green, "green"] ->
              IO.ANSI.green() <> "Ba"

            color in [:white, "white"] ->
              IO.ANSI.white() <> "Ba"

            color in [:orange, "orange"] ->
              IO.ANSI.color(5, 3, 0) <> "Ba"
          end
        end)
      end)

    left_face =
      Enum.map(state.left, fn row ->
        Enum.map(row, fn color ->
          cond do
            color in [:red, "red"] ->
              IO.ANSI.red() <> "L"

            color in [:blue, "blue"] ->
              IO.ANSI.blue() <> "L"

            color in [:yellow, "yellow"] ->
              IO.ANSI.yellow() <> "L"

            color in [:green, "green"] ->
              IO.ANSI.green() <> "L"

            color in [:white, "white"] ->
              IO.ANSI.white() <> "L"

            color in [:orange, "orange"] ->
              IO.ANSI.color(5, 3, 0) <> "L"
          end
        end)
      end)

    right_face =
      Enum.map(state.right, fn row ->
        Enum.map(row, fn color ->
          cond do
            color in [:red, "red"] ->
              IO.ANSI.red() <> "R"

            color in [:blue, "blue"] ->
              IO.ANSI.blue() <> "R"

            color in [:yellow, "yellow"] ->
              IO.ANSI.yellow() <> "R"

            color in [:green, "green"] ->
              IO.ANSI.green() <> "R"

            color in [:white, "white"] ->
              IO.ANSI.white() <> "R"

            color in [:orange, "orange"] ->
              IO.ANSI.color(5, 3, 0) <> "R"
          end
        end)
      end)

    top_part =
      Enum.map(0..2, fn index ->
        "         " <> Enum.join(Enum.at(top_face, index), "  ")
      end)
      |> Enum.join("\n")

    middle_part =
      Enum.map(0..2, fn index ->
        Enum.join(Enum.at(left_face, index), "  ") <>
          "  " <>
          Enum.join(Enum.at(front_face, index), "  ") <>
          "  " <>
          Enum.join(Enum.at(right_face, index), "  ") <>
          "  " <> Enum.join(Enum.at(back_face, index), " ") <> "  "
      end)
      |> Enum.join("\n")

    bottom_part =
      Enum.map(0..2, fn index ->
        "         " <> Enum.join(Enum.at(bottom_face, index), " ")
      end)
      |> Enum.join("\n")

    show = top_part <> "\n" <> middle_part <> "\n" <> bottom_part <> "\n" <> IO.ANSI.reset()
    {:reply, show, state}
  end

  def handle_cast(:rotate_left_up, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_left_up(state)}
  end

  def handle_cast(:rotate_left_down, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_left_down(state)}
  end

  def handle_cast(:rotate_right_up, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_right_up(state)}
  end

  def handle_cast(:rotate_right_down, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_right_down(state)}
  end

  def handle_cast(:rotate_front_clockwise, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_front_clockwise(state)}
  end

  def handle_cast(:rotate_front_counter_clockwise, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_front_counter_clockwise(state)}
  end

  def handle_cast(:rotate_back_clockwise, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_back_clockwise(state)}
  end

  def handle_cast(:rotate_back_counter_clockwise, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_back_counter_clockwise(state)}
  end

  def handle_cast(:rotate_top_left, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_top_left(state)}
  end

  def handle_cast(:rotate_top_right, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_top_right(state)}
  end

  def handle_cast(:rotate_bottom_left, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_bottom_left(state)}
  end

  def handle_cast(:rotate_bottom_right, state) do
    {:noreply, RubixCube.HandsOfGod.rotate_bottom_right(state)}
  end
end
