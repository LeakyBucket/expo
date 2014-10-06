defmodule Expo.Blocks.HtmlTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with html tag" do
      it "returns an Html Struct" do
        line = "<div>"

        assert Expo.Blocks.Html.match(line) == %Expo.Blocks.Html{content: ">", open: true, multi_line: true}
      end

      it "matches with leading spaces" do
        line = "   <div>"

        assert Expo.Blocks.Html.match(line) == %Expo.Blocks.Html{content: ">", open: true, multi_line: true}
      end

      it "matches an incomplete tag" do
        line = "  <div"

        assert Expo.Blocks.Html.match(line) == %Expo.Blocks.Html{content: "", open: true, multi_line: true}
      end

      it "doesn't match with too many spaces" do
        line = "    <div>"

        refute Expo.Blocks.Html.match(line)
      end
    end

    context "with html comment" do
      it "returns an Html Struct" do
        line = "<!-- bob -->"

        assert Expo.Blocks.Html.match(line) == %Expo.Blocks.Html{content: "", open: true, multi_line: true}
      end

      it "matches with leading spaces" do
        line = "  <!-- bob -->"

        assert Expo.Blocks.Html.match(line) == %Expo.Blocks.Html{content: "", open: true, multi_line: true}
      end

      it "doesn't match with too many spaces" do
        line = "    <!-- bob -->"

        refute Expo.Blocks.Html.match(line)
      end
    end
  end
end
