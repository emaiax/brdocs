defmodule BrDocs.Utils do
  @docs_digits_ranges %{
    cpf: %{
      9 => [10, 9, 8, 7, 6, 5, 4, 3, 2],            # first digit
      10 => [11, 10, 9, 8, 7, 6, 5, 4, 3, 2]        # second digit
    },
    cnpj: %{
      12 => [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2],   # first digit
      13 => [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2] # second digit
    }
  }

  def mod11(value, range) do
    numbers = value
              |> String.split("", trim: true)
              |> Enum.map(&String.to_integer(&1))

    remainder = Enum.zip(numbers, range)
                |> Enum.map(fn {num, r} -> num * r end)
                |> Enum.sum
                |> rem(11)

    if remainder < 2, do: 0, else: 11 - remainder
  end

  def generate_random_numbers(size) do
    Enum.reduce((1..size), "", fn(_, acc) -> acc <> to_string(Enum.random(0..9)) end)
  end

  def make_digit(value) do
    range = case String.length(value) do
      size when size in [9, 10] -> @docs_digits_ranges[:cpf][size]
      size when size in [12, 13] -> @docs_digits_ranges[:cnpj][size]
      _ -> []
    end

    mod11(value, range) |> to_string()
  end
end
