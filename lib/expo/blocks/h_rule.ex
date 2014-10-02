defmodule Expo.Blocks.HRule do
  defstruct attributes: []

  def match(line) do
    case ~r/^\s{0,3}(?<break>(-\s*-\s*-\s*)|(\*\s*\*\s*\*\s*)|(_\s*_\s*_\s*))/ |> Regex.named_captures(line) do
      %{"break" => _} ->
        %__MODULE__{attributes: []}
      _ ->
        false
    end
  end
end
