defmodule Expo.Blocks.FCode do
  defstruct info_string: "", content: "", open: true, multi_line: true, fence: ""

  def match(line) do
    case ~r/^\s{0,3}(?<fence>`{3,}|-{3,})(?<info>\w*)?/ |> Regex.named_captures(line) do
      %{"fence" => fence, "info" => info} ->
        %__MODULE__{info_string: info, fence: fence}
      _ ->
        false
    end
  end
end
