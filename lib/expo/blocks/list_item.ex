defmodule Expo.Blocks.ListItem do
  defstruct content: "", marker: "", depth: nil, open: true, multi_line: true

  def match(line) do
    case ~r/^(?<depth>#{indent_match}#{marker_match}\s{1,4})#{content_match}/ |> Regex.named_captures(line) do
      %{"content" => content, "marker" => marker, "depth" => depth} ->
        %__MODULE__{content: content, marker: marker, depth: depth |> String.length}
      _ ->
        false
    end
  end

  defp indent_match do
    "\\s{0,3}"
  end

  defp marker_match do
    "(?<marker>\\+|\\*|-|(\\d+[\\.\\)]))"
  end

  defp content_match do
    "(?<content>\\S.*)"
  end
end
