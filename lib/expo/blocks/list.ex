defmodule Expo.Blocks.List do
  defstruct loose: false, elements: [], type: nil, start: nil

  def new(type, start \\ nil) do
    case type do
      :ul ->
        %__MODULE__{type: type}
      :ol ->
        %__MODULE__{type: type, start: start}
      _ ->
        {:error, "unknown type, valid types are :ul and :ol"}
    end
  end

  def make_loose(list), do: %{list | loose: true}

  def add(list, content) when is_list(content), do: %{list | elements: list.elements ++ content}
  def add(list, content), do: %{list | elements: list.elements ++ [content]}
end
