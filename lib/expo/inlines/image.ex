defmodule Expo.Inlines.Image do
  def match(line) do
    case ~r/^(?<left>.*?)\!\[(?<description>.*)\]\((?<attributes>.*)\)(?<right>.*)$/ |> Regex.named_captures(line) do
      %{"left" => left, "description" => description, "attributes" => attributes, "right" => right} ->
        "#{left}#{compose(description, attributes)}#{right}"
      _ ->
        line
    end
  end

  defp compose(description, attributes) do
    [src: src, title: title] = parse_attrs(attributes)

    case {src, title} do
      {nil, _} ->
        "![#{description}](#{attributes})"
      {src, nil} ->
        "<img src=\"#{src}\" alt=\"#{parse_description(description)}\" />"
      {src, title} ->
        "<img src=\"#{src}\" title=\"#{title}\" alt=\"#{parse_description(description)}\" />"
    end
  end

  defp parse_attrs(attrs) do
    title = attrs |> find_title
    src = attrs |> find_source

    [src: src, title: title]
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

  defp find_source(attrs) do
    case ~r/(?<dest>\<(.+)\>|([^'\"\(][\w#\.\:\/]+[^'\"\)]))/ |> Regex.named_captures(attrs) do
      %{"dest" => dest} ->
        dest |> String.replace(~r/[\<\>]/, "") |> String.strip
      _ ->
        nil
    end
  end

  defp parse_description(description) do
    alt_text = replace_nested_links_or_images description

    ~r/[^\*\[\]]/ |> Regex.scan(alt_text) |> List.flatten |> List.to_string
  end

  defp link_or_image_match do
    ~r/\!?\[(?<descriptor>.*)\]\(.*\)/
  end

  defp replace_nested_links_or_images(description) do
    case link_or_image_match |> Regex.match?(description) do
      true ->
        updated_description = replace_nested_link_or_image description
        replace_nested_links_or_images updated_description
      _ ->
        description
    end
  end

  defp replace_nested_link_or_image(description) do
    %{"descriptor" => descriptor} = link_or_image_match |> Regex.named_captures(description)

    Regex.replace(link_or_image_match, description, descriptor)
  end
end
