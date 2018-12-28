defmodule BrDocs.BrDoc do
  @moduledoc """
  A struct containing value and kind of the doc.

  * `kind` - An atom to identify which Brazilian doc kind is being held.
  * `value` - A string containing the raw or formatted value of the doc.
  """

  defstruct value: "", kind: nil
end
