defmodule Expo.Blocks.BlockQuoteTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with valid blockquote" do
      it "matches without leading spaces" do
        line = "> content"

        assert Expo.Blocks.BlockQuote.match(line) == %Expo.Blocks.BlockQuote{content: "content"}
      end

      it "matches with up to 3 leading spaces" do
        line = "   > content"

        assert Expo.Blocks.BlockQuote.match(line) == %Expo.Blocks.BlockQuote{content: "content"}
      end

      it "matches with a space after the >" do
        line = "  > content"

        assert Expo.Blocks.BlockQuote.match(line) == %Expo.Blocks.BlockQuote{content: "content"}
      end

      it "matches without a space after the >" do
        line = ">content"

        assert Expo.Blocks.BlockQuote.match(line) == %Expo.Blocks.BlockQuote{content: "content"}
      end

      it "puts extra spaces following the > in the content" do
        line = ">   content"

        assert Expo.Blocks.BlockQuote.match(line) == %Expo.Blocks.BlockQuote{content: "  content"}
      end
    end

    context "with an invalid blockquote" do
      it "doesn't match with four or more spaces at the beginning of the line" do
        line = "    > content"

        refute Expo.Blocks.BlockQuote.match(line)
      end
    end
  end
end
