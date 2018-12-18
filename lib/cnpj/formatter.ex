defmodule BrDocs.CNPJ.Formatter do
  @raw_size 14
  @regex_replacement "\\1.\\2.\\3/\\4-\\5"
  @doc_regex ~r/(\d{2})?(\d{3})?(\d{3})?(\d{4})?(\d{2})/

  def format(%BrDoc{kind: :cnpj, value: ""}), do: make_cnpj("")
  def format(%BrDoc{kind: :cnpj, value: nil}), do: make_cnpj("")

  def format(%BrDoc{kind: :cnpj, value: value}) do
    value = value |> to_string()

    raw_value = value |> String.replace(~r/\D/, "", global: true)

    doc = if String.length(raw_value) == @raw_size, do: format_value(raw_value), else: value

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
