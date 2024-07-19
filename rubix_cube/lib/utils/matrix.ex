defmodule Utils.Matrix do
  def rotate_clockwise(matrix) do
    matrix
    |> transpose()
    |> Enum.map(fn row ->
      Enum.reverse(row)
    end)
  end

  def rotate_counter_clockwise(matrix) do
    matrix
    |> Enum.map(fn row ->
      Enum.reverse(row)
    end)
    |> transpose()
  end

  def transpose(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
