defmodule Expo.Blocks.Html do
  defstruct content: "", open: true, multi_line: true

  def match(line) do
    case ~r/^\s{0,3}<(\/)?#{tag_match}(?<content>.*)?/i |> Regex.named_captures(line) do
      %{"content" => content} ->
        %__MODULE__{content: content}
      _ ->
        false
    end
  end

  def tag_match do
    "(" <> (elements |> Enum.join("|")) <> "|#{comment})?"
  end

  def comment do
    "!--.*"
  end

  def elements do
    [
      "article",
      "header",
      "aside",
      "hgroup",
      "blockquote",
      "hr",
      "iframe",
      "body",
      "li",
      "map",
      "button",
      "object",
      "canvas",
      "ol",
      "caption",
      "output",
      "col",
      "p",
      "colgroup",
      "pre",
      "dd",
      "progress",
      "div",
      "section",
      "dl",
      "table",
      "td",
      "dt",
      "tbody",
      "embed",
      "textarea",
      "fieldset",
      "tfoot",
      "figcaption",
      "th",
      "figure",
      "thead",
      "footer",
      "tr",
      "form",
      "ul",
      "h1",
      "h2",
      "h3",
      "h4",
      "h5",
      "h6",
      "video",
      "script",
      "style"
    ]
  end
end
