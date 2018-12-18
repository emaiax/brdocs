defmodule BrDocs.CPF.Formatter do
  @raw_size 11
  @regex_replacement "\\1.\\2.\\3-\\4"
  @doc_regex ~r/(\d{3})?(\d{3})?(\d{3})?(\d{2})/

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
