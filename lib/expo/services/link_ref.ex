defmodule Expo.Services.LinkRef do
  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add(name, uri) when is_atom(name) do
    Agent.update(__MODULE__, fn list ->
      list ++ [{name, uri}]
    end)
  end

  def add(name, uri) when is_binary(name) do
    name |> String.to_atom |> add(uri)
  end

  def uri_for(name) when is_atom(name) do
    Agent.get(__MODULE__, fn list -> list[name] end)
  end

  def uri_for(name) when is_binary(name) do
    name |> String.to_atom |> uri_for
  end
end
