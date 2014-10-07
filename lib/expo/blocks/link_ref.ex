defmodule Expo.Blocks.LinkRef do
  defstruct uri: "", title: "", open: true, multi_line: true

  def match(line) do
    case ~r/^\s{0,3}\[.+\]\:\s?(?<uri>\S*)\s?(?<title>.*)?/ |> Regex.named_captures(line) do
      %{"uri" => uri, "title" => title} ->
        %__MODULE__{uri: uri, title: title}
      _ ->
        false
    end
  end
end
