defmodule Expo.Blocks.ICode do
  defstruct attributes: [], content: ""

  def match(line) do
    case ~r/^\s{4}(?<content>.*)?/ |> Regex.named_captures(line) do
      %{"content" => content} ->
        %__MODULE__{content: content}
      _ ->
        false
    end
  end
end
