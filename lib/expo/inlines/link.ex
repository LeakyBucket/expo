defmodule Expo.Inlines.Link do
  def match(line) do
    case ~r/^(?<left>.*?)\[(?<label>.*)\]\((?<attrs>.*)\)(?<right>.*)$/ |> Regex.named_captures(line) do
      %{"left" => left, "label" => label, "attrs" => attrs, "right" => right} ->
        "#{left}#{compose(attrs, label)}#{right}"
      _ ->
        line
    end
  end

  defp compose(attrs, label) do
    [href: href, title: title] = parse_attrs(attrs, label)

    case {href, title} do
      {nil, _} ->
        "[#{label}](#{attrs})"
      {href, nil} ->
        "<a href=\"#{href}\">#{label}</a>"
      {href, title} ->
        "<a href=\"#{href}\" title=\"#{title}\">#{label}</a>"
    end
  end

  defp parse_attrs(attrs, label) do
    title = attrs |> find_title
    href = attrs |> find_destination

    case href do
      nil ->
        [href: check_refs(label), title: title]
      _ ->
        [href: href, title: title]
    end
  end

  defp find_title(attrs) do
    case ~r/(?<title>\"(.+)\"|\((.+)\)|'(.+)')/ |> Regex.named_captures(attrs) do
      %{"title" => title} ->
        title_length = byte_size(title) - 2
        <<_ :: binary-size(1), title :: binary-size(title_length), _ :: binary-size(1)>> = title
        title
      _ ->
        nil
    end
  end

  defp find_destination(attrs) do
    case ~r/(?<dest>\<(.+)\>|([^'\"\(][\w#\.\:\/]+[^'\"\)]))/ |> Regex.named_captures(attrs) do
      %{"dest" => dest} ->
        dest |> String.replace(~r/[\<\>]/, "") |> String.strip
      _ ->
        nil
    end
  end

  defp check_refs(label, uri_dictionary \\ Expo.Services.LinkRef) do
    uri_dictionary.uri_for label
  end
end
