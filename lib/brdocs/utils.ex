defmodule BrDocs.Utils do
  @moduledoc ~S"""
  Utility module to hold all the calculations functions used to generate and validate data.
  """

  @docs_digits_ranges %{
    cpf: %{
      # first digit
      9 => [10, 9, 8, 7, 6, 5, 4, 3, 2],
      # second digit
      10 => [11, 10, 9, 8, 7, 6, 5, 4, 3, 2]
    },
    cnpj: %{
      # first digit
      12 => [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2],
      # second digit
      13 => [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    }
  }

  @doc ~S"""
  Calculates the MOD11 verification digit of a value.

  Range length must be the equals to the value length.

  ## Examples

        iex> BrDocs.Utils.mod11("123", [1, 2, 3])
        8

        iex> BrDocs.Utils.mod11("111444777", [10, 9, 8, 7, 6, 5, 4, 3, 2])
        3

        iex> BrDocs.Utils.mod11("1114447773", [11, 10, 9, 8, 7, 6, 5, 4, 3, 2])
        5

  """
  @spec mod11(String.t(), list(integer())) :: integer()
  def mod11(value, range) do
    numbers =
      value
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer(&1))

    remainder =
      numbers
      |> Enum.zip(range)
      |> Enum.map(fn {num, r} -> num * r end)
      |> Enum.sum()
      |> rem(11)

    if remainder < 2, do: 0, else: 11 - remainder
  end

  @doc ~S"""
  Generates a string with random numbers.

  ## Examples

      iex> BrDocs.Utils.generate_random_numbers(3)
      "599"

      iex> BrDocs.Utils.generate_random_numbers(8)
      "79052943"

      iex> BrDocs.Utils.generate_random_numbers(12)
      "064766405673"

  """
  @spec generate_random_numbers(integer()) :: String.t()
  def generate_random_numbers(size) do
    Enum.reduce(1..size, "", fn _, acc -> acc <> to_string(Enum.random(0..9)) end)
  end

  @doc ~S"""
  Generates a verification digit based on the value's length of the doc.

  ## Value's length

    * `9` - 1st verification digit for a `BrDocs.CPF` value
    * `10` - 2nd verification digit for a `BrDocs.CPF` value
    * `12` - 1st verification digit for a `BrDocs.CNPJ` value
    * `13` - 2nd verification digit for a `BrDocs.CNPJ` value

  ## Examples

      iex> BrDocs.Utils.make_digit("123456789")
      "0"

      iex> BrDocs.Utils.make_digit("1234567890")
      "9"

      iex> BrDocs.Utils.make_digit("114447770001")
      "6"

      iex> BrDocs.Utils.make_digit("1144477700016")
      "1"

  """
  @spec make_digit(String.t()) :: String.t()
  def make_digit(value) do
    range =
      case String.length(value) do
        size when size in [9, 10] -> @docs_digits_ranges[:cpf][size]
        size when size in [12, 13] -> @docs_digits_ranges[:cnpj][size]
        _ -> []
      end

    value
    |> mod11(range)
    |> to_string()
  end
end
