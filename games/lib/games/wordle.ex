defmodule Games.Wordle do
  @moduledoc """
  Module to play the game Wordle
  """

  @spec play() :: :ok
  def play do
    answer = Enum.random(["toast", "tarts", "hello", "beats"])

    play(answer, 6)
  end

  @spec feedback(String.t(), String.t()) :: [atom()]
  def feedback(answer, guess) do
    answer_string_list = String.split(answer, "", trim: true)
    guess_string_list = String.split(guess, "", trim: true)

    {result, answer_word_frequency} = check_green(answer_string_list, guess_string_list)

    {result, _} = check_yellow(guess_string_list, result, answer_word_frequency)

    result
  end

  defp play(answer, 0) do
    IO.puts("You lose! The answer was #{answer}")
  end

  defp play(answer, attempt_count) do
    guess = String.trim(IO.gets("Enter a five letter word: "), "\n")

    if feedback(answer, guess) == [:green, :green, :green, :green, :green] do
      IO.puts("You won! The word was #{answer}")
      IO.puts("You have earned 25 points")
      Games.Score.add_points(25)
    else
      IO.puts(Enum.join(feedback(answer, guess), " "))
      play(answer, attempt_count - 1)
    end
  end

  defp check_green(answer, guess) do
    Enum.reduce(0..(length(answer) - 1), {[], %{}}, fn index, acc ->
      if Enum.at(answer, index) == Enum.at(guess, index) do
        {List.flatten(elem(acc, 0) ++ [:green]), elem(acc, 1)}
      else
        {List.flatten(elem(acc, 0) ++ [:grey]),
         Map.put(
           elem(acc, 1),
           Enum.at(answer, index),
           Map.get(elem(acc, 1), Enum.at(answer, index), 0) + 1
         )}
      end
    end)
  end

  defp check_yellow(guess, result, answer_word_frequency) do
    Enum.reduce(0..(length(guess) - 1), {result, answer_word_frequency}, fn index, acc ->
      result = elem(acc, 0)
      answer_word_frequency = elem(acc, 1)
      char = Enum.at(guess, index)

      if Enum.at(result, index) == :green do
        {result, answer_word_frequency}
      end

      if Enum.at(result, index) != :green and Map.get(answer_word_frequency, char, 0) != 0 do
        update_yellow(result, answer_word_frequency, index, char)
      else
        {result, answer_word_frequency}
      end
    end)
  end

  defp update_yellow(result, answer_word_frequency, index, char) do
    result = List.update_at(result, index, fn _ -> :yellow end)

    answer_word_frequency =
      Map.update!(answer_word_frequency, char, fn _ ->
        Map.get(answer_word_frequency, char, 0) - 1
      end)

    {result, answer_word_frequency}
  end
end
