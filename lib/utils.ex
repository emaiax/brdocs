defmodule BrDocs.Utils do
  def mod11(value) do
    range = (2..String.length(value) + 1)

    numbers = value
              |> String.reverse
              |> String.split("", trim: true)
              |> Enum.map(&String.to_integer(&1))

    remainder = Enum.reduce(range, [], fn i, acc -> [Enum.at(numbers, i - 2) * i | acc] end)
                |> Enum.sum
                |> rem(11)

    if remainder < 2, do: 0, else: 11 - remainder
  end
end
