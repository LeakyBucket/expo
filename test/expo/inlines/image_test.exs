defmodule Expo.Inlines.ImageTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with valid image" do
      it "finds a vanilla description" do
        line = "![this is alt](img.jpg)"

        assert "<img src=\"img.jpg\" alt=\"this is alt\" />" = Expo.Inlines.Image.match(line)
      end

      it "finds a description with non-word characters in it" do
        line = "![this [is] **alt**](img.jpg)"

        assert "<img src=\"img.jpg\" alt=\"this is alt\" />" = Expo.Inlines.Image.match(line)
      end

      it "only adds the description from a nested image to the alt" do
        line = "![this ![is alt](/url1)](/url2)"

        assert "<img src=\"/url2\" alt=\"this is alt\" />" = Expo.Inlines.Image.match(line)
      end

      it "only adds the description from a nested link to the alt" do
        line = "![this [is alt](/url1)](/url2)"

        assert "<img src=\"/url2\" alt=\"this is alt\" />" = Expo.Inlines.Image.match(line)
      end

      it "finds the title in single quotes" do
        line = "![this is alt](img.jpg 'bob')"

        assert "<img src=\"img.jpg\" title=\"bob\" alt=\"this is alt\" />" = Expo.Inlines.Image.match(line)
      end

      it "finds the title in double quotes" do
        line = "![this is alt](img.jpg \"bob\")"

        assert "<img src=\"img.jpg\" title=\"bob\" alt=\"this is alt\" />" = Expo.Inlines.Image.match(line)
      end

      it "finds the title in parens" do
        line = "![this is alt](img.jpg (bob))"

        assert "<img src=\"img.jpg\" title=\"bob\" alt=\"this is alt\" />" = Expo.Inlines.Image.match(line)
      end
    end
  end
end
