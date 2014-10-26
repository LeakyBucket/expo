defmodule Expo.Inlines.CodeSpan do
  defstruct fence: ""

  def match(line) do
    case ~r/(?<left>.*)(#{fence(line)})(?<content>.*?)\2(?<right>.*)/ |> Regex.named_captures(line) do
      %{"content" => content, "left" => left, "right" => right} ->
        "#{left}<code>#{content}</code>#{right}"
      _ ->
        false
    end
  end

  def fence(line) do
    (~r/(`++)/ |> Regex.run(line)) |> List.first
  end
end
