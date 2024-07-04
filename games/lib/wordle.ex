defmodule Games.Wordle do
  def play do
    answer = Enum.random(["toast", "tarts", "hello", "beats"])

    play(answer, 6)
  end

  def feedback(answer, guess) do
    answer_string_list = String.split(answer, "", trim: true)
    guess_string_list = String.split(guess, "", trim: true)

    {result, answer_word_frequency} =
      Enum.reduce(0..(String.length(answer) - 1), {[], %{}}, fn index, acc ->
        if Enum.at(answer_string_list, index) == Enum.at(guess_string_list, index) do
          {List.flatten(elem(acc, 0) ++ [:green]), elem(acc, 1)}
        else
          {List.flatten(elem(acc, 0) ++ [:grey]),
           Map.put(
             elem(acc, 1),
             Enum.at(answer_string_list, index),
             Map.get(elem(acc, 1), Enum.at(answer_string_list, index), 0) + 1
           )}
        end
      end)

    {result, _} =
      Enum.reduce(0..(String.length(answer) - 1), {result, answer_word_frequency}, fn index,
                                                                                      acc ->
        result = elem(acc, 0)
        answer_word_frequency = elem(acc, 1)

        cond do
          Enum.at(result, index) == :green ->
            {result, answer_word_frequency}

          true ->
            char = Enum.at(guess_string_list, index)

            cond do
              Map.get(answer_word_frequency, char, 0) != 0 ->
                result = List.update_at(result, index, fn _ -> :yellow end)

                answer_word_frequency =
                  Map.update!(answer_word_frequency, char, fn _ ->
                    Map.get(answer_word_frequency, char, 0) - 1
                  end)

                {result, answer_word_frequency}

              true ->
                {result, answer_word_frequency}
            end
        end
      end)

    result
  end

  defp play(answer, 0) do
    IO.puts("You lose! The answer was #{answer}")
  end

  defp play(answer, attempt_count) do
    guess = String.trim(IO.gets("Enter a five letter word: "), "\n")

    if feedback(answer, guess) == [:green, :green, :green, :green, :green] do
      IO.puts("You won! The word was #{answer}")
    else
      IO.puts(Enum.join(feedback(answer, guess), " "))
      play(answer, attempt_count - 1)
    end
  end
end
