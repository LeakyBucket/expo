defmodule Expo.Blocks.ListItemTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with a valid list item" do
      it "matches with up to three leading spaces" do
        line = "   - first"

        assert Expo.Blocks.ListItem.match(line) == %Expo.Blocks.ListItem{content: "first", marker: "-", depth: 5}
      end

      it "matches an un-ordered list item" do
        line = "  * first"

        assert Expo.Blocks.ListItem.match(line) == %Expo.Blocks.ListItem{marker: "*", depth: 4, content: "first"}
      end

      it "matches an ordered list item" do
        line = "  1) first"

        assert Expo.Blocks.ListItem.match(line) == %Expo.Blocks.ListItem{marker: "1)", depth: 5, content: "first"}
      end

      it "sets the depth for the item" do
        line = "  *  first"

        assert Expo.Blocks.ListItem.match(line).depth == 5
      end
    end

    context "with an invalid list item" do
      it "doesn't match with four or more leading spaces" do
        line = "    - first"

        refute Expo.Blocks.ListItem.match(line)
      end

      it "doesn't match with more than four spaces between the marker and content" do
        line = "   *     first"

        refute Expo.Blocks.ListItem.match(line)
      end

      it "doesn't match invalid ordered list markers" do
        line = "  1.) bob"

        refute Expo.Blocks.ListItem.match(line)
      end
    end
  end
end
