defmodule BrDocs.CPF.Validator do
  alias BrDocs.Utils

  @moduledoc """
    Um CPF declarado como válido por essa ferramenta não significa que ele exista no
    Cadastro Nacional de Pessoas Físicas, nem que seja um número ativo ou com situação
    cadastral regular. Para conferir tais dados, consulte o site oficial da Secretaria
    da Receita Federal do Brasil.

    O número CPF guarda o estado de onde foi emitido, esse número corresponde ao
    último algarismo anterior aos dois dígitos verificadores.

    Um exemplo de CPF nº 000.000.008-00, o número 8 corresponde ao estado de São Paulo.

    Veja abaixo os códigos correspondentes aos estados brasileiros:

    1. Distrito Federal, Goiás, Mato Grosso do Sul e Tocantins;
    2. Pará, Amazonas, Acre, Amapá, Rondônia e Roraima;
    3. Ceará, Maranhão e Piauí;
    4. Pernambuco, Rio Grande do Norte, Paraíba e Alagoas;
    5. Bahia e Sergipe;
    6. Minas Gerais;
    7. Rio de Janeiro e Espírito Santo;
    8. São Paulo;
    9. Paraná e Santa Catarina;
    0. Rio Grande do Sul.
  """

  def validate(%BrDoc{kind: :cpf, value: ""}), do: false
  def validate(%BrDoc{kind: :cpf, value: nil}), do: false

  def validate(%BrDoc{kind: :cpf, value: value}) do
    value = value |> to_string()

    first_digit = value
                  |> String.slice(0, 9)
                  |> Utils.mod11()
                  |> to_string()

    last_digit = value
                 |> String.slice(0, 10)
                 |> Utils.mod11()
                 |> to_string()

    value == (String.slice(value, 0, 9) <> first_digit <> last_digit)
  end

  def validate(value) do
    value
    |> to_string()
    |> make_cpf()
    |> validate()
  end

  defp make_cpf(value) do
    %BrDoc{kind: :cpf, value: value}
  end
end
