defmodule Expo.Blocks.ICode do
  defstruct attributes: [], content: "", open: true, multi_line: true

  def match(line) do
    case ~r/^\s{4}(?<content>.*)?/ |> Regex.named_captures(line) do
      %{"content" => content} ->
        %__MODULE__{content: content}
      _ ->
        false
    end
  end

  def append_content(struct, content) do
    %__MODULE__{struct | content: struct.content <> content}
  end

  def close(struct) do
    %__MODULE__{struct | open: false}
  end
end
