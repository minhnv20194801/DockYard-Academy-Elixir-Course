defmodule RubixCube.HandsOfGod do
  alias Utils.Matrix

  def rotate_left_up(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :left, Matrix.rotate_counter_clockwise(rubix.left))

    front_face = rubix.front
    top_face = rubix.top
    bottom_face = rubix.bottom
    back_face = rubix.back

    front_col = front_face |> Matrix.transpose() |> Enum.at(0)
    top_col = top_face |> Matrix.transpose() |> Enum.at(0)
    bottom_col = bottom_face |> Matrix.transpose() |> Enum.at(0)
    back_col = back_face |> Matrix.transpose() |> Enum.at(2)

    new_front_face =
      front_face
      |> Matrix.transpose()
      |> List.replace_at(0, bottom_col)
      |> Matrix.transpose()

    new_top_face =
      top_face
      |> Matrix.transpose()
      |> List.replace_at(0, front_col)
      |> Matrix.transpose()

    new_bottom_face =
      bottom_face
      |> Matrix.transpose()
      |> List.replace_at(0, back_col)
      |> Matrix.transpose()

    new_back_face =
      back_face
      |> Matrix.transpose()
      |> List.replace_at(2, top_col)
      |> Matrix.transpose()

    rubix
    |> Map.put(:front, new_front_face)
    |> Map.put(:top, new_top_face)
    |> Map.put(:bottom, new_bottom_face)
    |> Map.put(:back, new_back_face)
  end

  def rotate_left_down(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :left, Matrix.rotate_clockwise(rubix.left))

    front_face = rubix.front
    top_face = rubix.top
    bottom_face = rubix.bottom
    back_face = rubix.back

    front_col = front_face |> Matrix.transpose() |> Enum.at(0)
    top_col = top_face |> Matrix.transpose() |> Enum.at(0)
    bottom_col = bottom_face |> Matrix.transpose() |> Enum.at(0)
    back_col = back_face |> Matrix.transpose() |> Enum.at(2)

    new_front_face =
      front_face
      |> Matrix.transpose()
      |> List.replace_at(0, top_col)
      |> Matrix.transpose()

    new_top_face =
      top_face
      |> Matrix.transpose()
      |> List.replace_at(0, back_col)
      |> Matrix.transpose()

    new_bottom_face =
      bottom_face
      |> Matrix.transpose()
      |> List.replace_at(0, front_col)
      |> Matrix.transpose()

    new_back_face =
      back_face
      |> Matrix.transpose()
      |> List.replace_at(2, bottom_col)
      |> Matrix.transpose()

    rubix
    |> Map.put(:front, new_front_face)
    |> Map.put(:top, new_top_face)
    |> Map.put(:bottom, new_bottom_face)
    |> Map.put(:back, new_back_face)
  end

  def rotate_right_up(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :right, Matrix.rotate_clockwise(rubix.right))

    front_face = rubix.front
    top_face = rubix.top
    bottom_face = rubix.bottom
    back_face = rubix.back

    front_col = front_face |> Matrix.transpose() |> Enum.at(2)
    top_col = top_face |> Matrix.transpose() |> Enum.at(2)
    bottom_col = bottom_face |> Matrix.transpose() |> Enum.at(2)
    back_col = back_face |> Matrix.transpose() |> Enum.at(0)

    new_front_face =
      front_face
      |> Matrix.transpose()
      |> List.replace_at(2, bottom_col)
      |> Matrix.transpose()

    new_top_face =
      top_face
      |> Matrix.transpose()
      |> List.replace_at(2, front_col)
      |> Matrix.transpose()

    new_bottom_face =
      bottom_face
      |> Matrix.transpose()
      |> List.replace_at(2, back_col)
      |> Matrix.transpose()

    new_back_face =
      back_face
      |> Matrix.transpose()
      |> List.replace_at(0, top_col)
      |> Matrix.transpose()

    rubix
    |> Map.put(:front, new_front_face)
    |> Map.put(:top, new_top_face)
    |> Map.put(:bottom, new_bottom_face)
    |> Map.put(:back, new_back_face)
  end

  def rotate_right_down(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :right, Matrix.rotate_counter_clockwise(rubix.right))

    front_face = rubix.front
    top_face = rubix.top
    bottom_face = rubix.bottom
    back_face = rubix.back

    front_col = front_face |> Matrix.transpose() |> Enum.at(2)
    top_col = top_face |> Matrix.transpose() |> Enum.at(2)
    bottom_col = bottom_face |> Matrix.transpose() |> Enum.at(2)
    back_col = back_face |> Matrix.transpose() |> Enum.at(0)

    new_front_face =
      front_face
      |> Matrix.transpose()
      |> List.replace_at(2, top_col)
      |> Matrix.transpose()

    new_top_face =
      top_face
      |> Matrix.transpose()
      |> List.replace_at(2, back_col)
      |> Matrix.transpose()

    new_bottom_face =
      bottom_face
      |> Matrix.transpose()
      |> List.replace_at(2, front_col)
      |> Matrix.transpose()

    new_back_face =
      back_face
      |> Matrix.transpose()
      |> List.replace_at(2, bottom_col)
      |> Matrix.transpose()

    rubix
    |> Map.put(:front, new_front_face)
    |> Map.put(:top, new_top_face)
    |> Map.put(:bottom, new_bottom_face)
    |> Map.put(:back, new_back_face)
  end

  def rotate_front_clockwise(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :front, Matrix.rotate_clockwise(rubix.front))

    top_face = rubix.top
    right_face = rubix.right
    bottom_face = rubix.bottom
    left_face = rubix.left

    new_right_face =
      right_face
      |> Matrix.transpose()
      |> List.replace_at(0, Enum.at(top_face, 2))
      |> Matrix.transpose()

    new_left_face =
      left_face
      |> Matrix.transpose()
      |> List.replace_at(2, Enum.at(bottom_face, 0))
      |> Matrix.transpose()

    rubix
    |> Map.put(:top, List.replace_at(top_face, 2, Enum.at(Matrix.transpose(left_face), 2)))
    |> Map.put(:right, new_right_face)
    |> Map.put(:bottom, List.replace_at(bottom_face, 0, Enum.at(Matrix.transpose(right_face), 0)))
    |> Map.put(:left, new_left_face)
  end

  def rotate_front_counter_clockwise(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :front, Matrix.rotate_counter_clockwise(rubix.front))

    top_face = rubix.top
    right_face = rubix.right
    bottom_face = rubix.bottom
    left_face = rubix.left

    new_right_face =
      right_face
      |> Matrix.transpose()
      |> List.replace_at(0, Enum.at(bottom_face, 0))
      |> Matrix.transpose()

    new_left_face =
      left_face
      |> Matrix.transpose()
      |> List.replace_at(2, Enum.at(top_face, 2))
      |> Matrix.transpose()

    rubix
    |> Map.put(:top, List.replace_at(top_face, 2, Enum.at(Matrix.transpose(right_face), 0)))
    |> Map.put(:right, new_right_face)
    |> Map.put(:bottom, List.replace_at(bottom_face, 0, Enum.at(Matrix.transpose(left_face), 2)))
    |> Map.put(:left, new_left_face)
  end

  def rotate_back_clockwise(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :back, Matrix.rotate_counter_clockwise(rubix.back))

    top_face = rubix.top
    right_face = rubix.right
    bottom_face = rubix.bottom
    left_face = rubix.left

    new_right_face =
      right_face
      |> Matrix.transpose()
      |> List.replace_at(2, Enum.at(top_face, 0))
      |> Matrix.transpose()

    new_left_face =
      left_face
      |> Matrix.transpose()
      |> List.replace_at(0, Enum.at(bottom_face, 2))
      |> Matrix.transpose()

    rubix
    |> Map.put(:top, List.replace_at(top_face, 0, Enum.at(Matrix.transpose(left_face), 0)))
    |> Map.put(:right, new_right_face)
    |> Map.put(:bottom, List.replace_at(bottom_face, 2, Enum.at(Matrix.transpose(right_face), 2)))
    |> Map.put(:left, new_left_face)
  end

  def rotate_back_counter_clockwise(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :back, Matrix.rotate_clockwise(rubix.back))

    top_face = rubix.top
    right_face = rubix.right
    bottom_face = rubix.bottom
    left_face = rubix.left

    new_right_face =
      right_face
      |> Matrix.transpose()
      |> List.replace_at(2, Enum.at(bottom_face, 2))
      |> Matrix.transpose()

    new_left_face =
      left_face
      |> Matrix.transpose()
      |> List.replace_at(0, Enum.at(top_face, 0))
      |> Matrix.transpose()

    rubix
    |> Map.put(:top, List.replace_at(top_face, 0, Enum.at(Matrix.transpose(right_face), 2)))
    |> Map.put(:right, new_right_face)
    |> Map.put(:bottom, List.replace_at(bottom_face, 2, Enum.at(Matrix.transpose(left_face), 0)))
    |> Map.put(:left, new_left_face)
  end

  def rotate_top_left(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :top, Matrix.rotate_clockwise(rubix.top))

    front_face = rubix.front
    left_face = rubix.left
    right_face = rubix.right
    back_face = rubix.back

    rubix
    |> Map.put(:front, List.replace_at(front_face, 0, Enum.at(right_face, 0)))
    |> Map.put(:left, List.replace_at(left_face, 0, Enum.at(front_face, 0)))
    |> Map.put(:right, List.replace_at(right_face, 0, Enum.at(back_face, 0)))
    |> Map.put(:back, List.replace_at(back_face, 0, Enum.at(left_face, 0)))
  end

  def rotate_top_right(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :top, Matrix.rotate_counter_clockwise(rubix.top))

    front_face = rubix.front
    left_face = rubix.left
    right_face = rubix.right
    back_face = rubix.back

    rubix
    |> Map.put(:front, List.replace_at(front_face, 0, Enum.at(left_face, 0)))
    |> Map.put(:left, List.replace_at(left_face, 0, Enum.at(back_face, 0)))
    |> Map.put(:right, List.replace_at(right_face, 0, Enum.at(front_face, 0)))
    |> Map.put(:back, List.replace_at(back_face, 0, Enum.at(right_face, 0)))
  end

  def rotate_bottom_left(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :bottom, Matrix.rotate_counter_clockwise(rubix.bottom))

    front_face = rubix.front
    left_face = rubix.left
    right_face = rubix.right
    back_face = rubix.back

    rubix
    |> Map.put(:front, List.replace_at(front_face, 0, Enum.at(right_face, 0)))
    |> Map.put(:left, List.replace_at(left_face, 0, Enum.at(front_face, 0)))
    |> Map.put(:right, List.replace_at(right_face, 0, Enum.at(back_face, 0)))
    |> Map.put(:back, List.replace_at(back_face, 0, Enum.at(left_face, 0)))
  end

  def rotate_bottom_right(%RubixCube.RubixCube{} = rubix) do
    rubix =
      Map.put(rubix, :bottom, Matrix.rotate_clockwise(rubix.bottom))

    front_face = rubix.front
    left_face = rubix.left
    right_face = rubix.right
    back_face = rubix.back

    rubix
    |> Map.put(:front, List.replace_at(front_face, 0, Enum.at(left_face, 0)))
    |> Map.put(:left, List.replace_at(left_face, 0, Enum.at(back_face, 0)))
    |> Map.put(:right, List.replace_at(right_face, 0, Enum.at(front_face, 0)))
    |> Map.put(:back, List.replace_at(back_face, 0, Enum.at(right_face, 0)))
  end
end
