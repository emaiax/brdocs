defmodule BrDocs.CNPJ.Formatter do
  @moduledoc ~S"""
  CNPJ Formatter.
  """

  alias BrDocs.BrDoc

  @raw_size 14
  @regex_replacement "\\1.\\2.\\3/\\4-\\5"
  @doc_regex ~r/(\d{2})?(\d{3})?(\d{3})?(\d{4})?(\d{2})/

  @doc """
  Formats a `BrDocs.BrDoc` CNPJ value into CNPJ format. Returns a formatted `BrDocs.BrDoc`.

  CNPJ value length should be 14 characters. Otherwise, returns a `BrDocs.BrDoc` with the raw and unformatted value.

  This function accepts either a string containing the CNPJ value or a `BrDocs.BrDoc`.

  ## Examples

        iex> BrDocs.CNPJ.Formatter.format("")
        %BrDocs.BrDoc{kind: :cnpj, value: ""}

        iex> BrDocs.CNPJ.Formatter.format(nil)
        %BrDocs.BrDoc{kind: :cnpj, value: nil}

        iex> BrDocs.CNPJ.Formatter.format("123")
        %BrDocs.BrDoc{kind: :cnpj, value: "123"}

        iex> BrDocs.CNPJ.Formatter.format("11444777000161")
        %BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}

        iex> BrDocs.CNPJ.Formatter.format("11.444.777/0001-61")
        %BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.BrDoc{kind: :cnpj, value: ""})
        %BrDocs.BrDoc{kind: :cnpj, value: ""}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.BrDoc{kind: :cnpj, value: nil})
        %BrDocs.BrDoc{kind: :cnpj, value: ""}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.BrDoc{kind: :cnpj, value: "123"})
        %BrDocs.BrDoc{kind: :cnpj, value: "123"}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.BrDoc{kind: :cnpj, value: "11444777000161"})
        %BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"})
        %BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  def format(%BrDoc{kind: :cnpj, value: ""}), do: make_cnpj("")
  def format(%BrDoc{kind: :cnpj, value: nil}), do: make_cnpj("")

  def format(%BrDoc{kind: :cnpj, value: value}) do
    raw_value = value |> to_string() |> String.replace(~r/\D/, "", global: true)

    doc =
      if String.length(raw_value) == @raw_size,
        do: format_value(raw_value),
        else: to_string(value)

    make_cnpj(doc)
  end

  def format(value) do
    value
    |> make_cnpj()
    |> format()
  end

  defp format_value(value) do
    Regex.replace(@doc_regex, value, @regex_replacement)
  end

  defp make_cnpj(value) do
    %BrDoc{kind: :cnpj, value: value}
  end
end
