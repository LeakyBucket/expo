defmodule Expo.Inlines.Emphasis do

  def match(line) do
    case ~r/(?<left>.*?)((?<double>#{strong})|(?<single>#{reg}))(?<content>.*)\2(?<right>.*)/ |> Regex.named_captures(line) do
      %{"content" => content, "double" => double, "single" => "", "left" => left, "right" => right} ->
        "#{left}<strong>#{match(content)}</strong>#{right}"
      %{"content" => content, "double" => "", "single" => single, "left" => left, "right" => right} ->
        "#{left}<em>#{match(content)}</em>#{right}"
      _ ->
        line
    end
  end

  def strong do
    "\\*\\*|__"
  end

  def reg do
    "\\*|_"
  end
end
