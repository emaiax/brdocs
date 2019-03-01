defmodule BrDocs.CPF.Formatter do
  @moduledoc ~S"""
  CPF Formatter.
  """

  alias BrDocs.Doc

  @raw_size 11
  @regex_replacement "\\1.\\2.\\3-\\4"
  @doc_regex ~r/(\d{3})?(\d{3})?(\d{3})?(\d{2})/

  @doc """
  Formats a `BrDocs.Doc` CPF value into CPF format. Returns a formatted `BrDocs.Doc`.

  CPF value length should be 11 characters. Otherwise, returns a `BrDocs.Doc` with the raw and unformatted value.

  This function accepts either a string containing the CPF value or a `BrDocs.Doc`.

  ## Examples

        iex> BrDocs.CPF.Formatter.format("")
        %BrDocs.Doc{kind: :cpf, value: ""}

        iex> BrDocs.CPF.Formatter.format(nil)
        %BrDocs.Doc{kind: :cpf, value: nil}

        iex> BrDocs.CPF.Formatter.format("123")
        %BrDocs.Doc{kind: :cpf, value: "123"}

        iex> BrDocs.CPF.Formatter.format("11144477735")
        %BrDocs.Doc{kind: :cpf, value: "111.444.777-35"}

        iex> BrDocs.CPF.Formatter.format("111.444.777-35")
        %BrDocs.Doc{kind: :cpf, value: "111.444.777-35"}

        iex> BrDocs.CPF.Formatter.format(%BrDocs.Doc{kind: :cpf, value: ""})
        %BrDocs.Doc{kind: :cpf, value: ""}

        iex> BrDocs.CPF.Formatter.format(%BrDocs.Doc{kind: :cpf, value: nil})
        %BrDocs.Doc{kind: :cpf, value: ""}

        iex> BrDocs.CPF.Formatter.format(%BrDocs.Doc{kind: :cpf, value: "123"})
        %BrDocs.Doc{kind: :cpf, value: "123"}

        iex> BrDocs.CPF.Formatter.format(%BrDocs.Doc{kind: :cpf, value: "11144477735"})
        %BrDocs.Doc{kind: :cpf, value: "111.444.777-35"}

        iex> BrDocs.CPF.Formatter.format(%BrDocs.Doc{kind: :cpf, value: "111.444.777-35"})
        %BrDocs.Doc{kind: :cpf, value: "111.444.777-35"}

  """
  @spec format(BrDocs.Doc.t()) :: BrDocs.Doc.t()
  def format(%Doc{kind: :cpf, value: ""}), do: make_cpf("")
  def format(%Doc{kind: :cpf, value: nil}), do: make_cpf("")

  def format(%Doc{kind: :cpf, value: value}) do
    raw_value =
      value
      |> to_string()
      |> String.replace(~r/\D/, "", global: true)

    doc =
      if String.length(raw_value) == @raw_size,
        do: format_value(raw_value),
        else: to_string(value)

    make_cpf(doc)
  end

  @spec format(String.t()) :: BrDocs.Doc.t()
  def format(value) do
    value
    |> make_cpf()
    |> format()
  end

  defp format_value(value) do
    Regex.replace(@doc_regex, value, @regex_replacement)
  end

  defp make_cpf(value) do
    %Doc{kind: :cpf, value: value}
  end
end
