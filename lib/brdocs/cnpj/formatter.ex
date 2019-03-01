defmodule BrDocs.CNPJ.Formatter do
  @moduledoc ~S"""
  CNPJ Formatter.
  """

  alias BrDocs.Doc

  @raw_size 14
  @regex_replacement "\\1.\\2.\\3/\\4-\\5"
  @doc_regex ~r/(\d{2})?(\d{3})?(\d{3})?(\d{4})?(\d{2})/

  @doc """
  Formats a `BrDocs.Doc` CNPJ value into CNPJ format. Returns a formatted `BrDocs.Doc`.

  CNPJ value length should be 14 characters. Otherwise, returns a `BrDocs.Doc` with the raw and unformatted value.

  This function accepts either a string containing the CNPJ value or a `BrDocs.Doc`.

  ## Examples

        iex> BrDocs.CNPJ.Formatter.format("")
        %BrDocs.Doc{kind: :cnpj, value: ""}

        iex> BrDocs.CNPJ.Formatter.format(nil)
        %BrDocs.Doc{kind: :cnpj, value: nil}

        iex> BrDocs.CNPJ.Formatter.format("123")
        %BrDocs.Doc{kind: :cnpj, value: "123"}

        iex> BrDocs.CNPJ.Formatter.format("11444777000161")
        %BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"}

        iex> BrDocs.CNPJ.Formatter.format("11.444.777/0001-61")
        %BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.Doc{kind: :cnpj, value: ""})
        %BrDocs.Doc{kind: :cnpj, value: ""}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.Doc{kind: :cnpj, value: nil})
        %BrDocs.Doc{kind: :cnpj, value: ""}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.Doc{kind: :cnpj, value: "123"})
        %BrDocs.Doc{kind: :cnpj, value: "123"}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.Doc{kind: :cnpj, value: "11444777000161"})
        %BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"}

        iex> BrDocs.CNPJ.Formatter.format(%BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"})
        %BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  @spec format(BrDocs.Doc.t()) :: BrDocs.Doc.t()
  def format(%Doc{kind: :cnpj, value: ""}), do: make_cnpj("")
  def format(%Doc{kind: :cnpj, value: nil}), do: make_cnpj("")

  def format(%Doc{kind: :cnpj, value: value}) do
    raw_value = value |> to_string() |> String.replace(~r/\D/, "", global: true)

    doc =
      if String.length(raw_value) == @raw_size,
        do: format_value(raw_value),
        else: to_string(value)

    make_cnpj(doc)
  end

  @spec format(String.t()) :: BrDocs.Doc.t()
  def format(value) do
    value
    |> make_cnpj()
    |> format()
  end

  defp format_value(value) do
    Regex.replace(@doc_regex, value, @regex_replacement)
  end

  defp make_cnpj(value) do
    %Doc{kind: :cnpj, value: value}
  end
end
