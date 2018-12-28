defmodule BrDocs.CPF.Formatter do
  @moduledoc ~S"""
  CPF Formatter.
  """

  alias BrDocs.BrDoc

  @raw_size 11
  @regex_replacement "\\1.\\2.\\3-\\4"
  @doc_regex ~r/(\d{3})?(\d{3})?(\d{3})?(\d{2})/

  @doc """
  Formats a `BrDocs.BrDoc` CPF value into CPF format. Returns a formatted `BrDocs.BrDoc`.

  CPF value length should be 11 characters. Otherwise, returns a `BrDocs.BrDoc` with the raw and unformatted value.

  This function accepts either a string containing the CPF value or a `BrDocs.BrDoc`.

  ## Examples

        iex> BrDocs.CPF.Formatter.format("")
        %BrDocs.BrDoc{kind: :cpf, value: ""}

        iex> BrDocs.CPF.Formatter.format(nil)
        %BrDocs.BrDoc{kind: :cpf, value: nil}

        iex> BrDocs.CPF.Formatter.format("123")
        %BrDocs.BrDoc{kind: :cpf, value: "123"}

        iex> BrDocs.CPF.Formatter.format("11144477735")
        %BrDocs.BrDoc{kind: :cpf, value: "111.444.777-35"}

        iex> BrDocs.CPF.Formatter.format("111.444.777-35")
        %BrDocs.BrDoc{kind: :cpf, value: "111.444.777-35"}


        iex> BrDocs.CPF.Formatter.format(%BrDocs.BrDoc{kind: :cpf, value: ""})
        %BrDocs.BrDoc{kind: :cpf, value: ""}

        iex> BrDocs.CPF.Formatter.format(%BrDocs.BrDoc{kind: :cpf, value: nil})
        %BrDocs.BrDoc{kind: :cpf, value: ""}

        iex> BrDocs.CPF.Formatter.format(%BrDocs.BrDoc{kind: :cpf, value: "123"})
        %BrDocs.BrDoc{kind: :cpf, value: "123"}

        iex> BrDocs.CPF.Formatter.format(%BrDocs.BrDoc{kind: :cpf, value: "11144477735"})
        %BrDocs.BrDoc{kind: :cpf, value: "111.444.777-35"}

        iex> BrDocs.CPF.Formatter.format(%BrDocs.BrDoc{kind: :cpf, value: "111.444.777-35"})
        %BrDocs.BrDoc{kind: :cpf, value: "111.444.777-35"}
  """
  def format(%BrDoc{kind: :cpf, value: ""}), do: make_cpf("")
  def format(%BrDoc{kind: :cpf, value: nil}), do: make_cpf("")

  def format(%BrDoc{kind: :cpf, value: value}) do
    value = value |> to_string()

    raw_value = value |> String.replace(~r/\D/, "", global: true)

    doc = if String.length(raw_value) == @raw_size, do: format_value(raw_value), else: value

    make_cpf(doc)
  end

  def format(value) do
    value
    |> make_cpf()
    |> format()
  end

  defp format_value(value) do
    Regex.replace(@doc_regex, value, @regex_replacement)
  end

  defp make_cpf(value) do
    %BrDoc{kind: :cpf, value: value}
  end
end
