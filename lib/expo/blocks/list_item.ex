defmodule Expo.Blocks.ListItem do
  defstruct content: "", marker: "", depth: nil, open: true, multi_line: true

  def match(line) do
    case ~r// |> Regex.named_captures(line) do
      %{"content" => content} ->
        %__MODULE__{content: content, marker: marker}
      _ ->
        false
    end
  end

  defp indent do
    "\s{0,3}"
  end

  defp marker do
    "(?<marker>\+|\*|-|(\d+\.|\)))"
  end

  defp content do
    "(?<content>)"
  end
end
