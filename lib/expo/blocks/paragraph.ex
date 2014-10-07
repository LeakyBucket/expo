defmodule Expo.Blocks.Paragraph do
  defstruct content: "", open: true, multi_line: true

  def match(line) do
    case ~r/^\s{0,3}(?<content>\S.+)/ |> Regex.named_captures(line) do
      %{"content" => content} ->
        %__MODULE__{content: content}
      _ ->
        false
    end
  end
end
