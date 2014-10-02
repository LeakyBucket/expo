defmodule Expo.Blocks.AHeader do
  defstruct level: nil, content: ""

  def match(line) do
    case ~r/^\s{0,3}(?<level>\#{1,6})\s(?<content>.*)?/ |> Regex.named_captures(line) do
      %{"level" => level, "content" => content} ->
        level = level |> String.length
        %__MODULE__{level: level, content: content}
      _ ->
        false
    end
  end
end
