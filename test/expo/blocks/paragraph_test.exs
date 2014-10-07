defmodule Expo.Blocks.ParagraphTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with a valid paragraph" do
      it "matches when there are at most three leading spaces" do
        line = "   paragraph"

        assert Expo.Blocks.Paragraph.match(line) == %Expo.Blocks.Paragraph{content: "paragraph"}
      end

      it "matches when there are no leading spaces" do
        line = "paragraph"

        assert Expo.Blocks.Paragraph.match(line) == %Expo.Blocks.Paragraph{content: "paragraph"}
      end
    end

    context "with an invalid paragraph" do
      it "doesn't match when there are more than three leading spaces" do
        line = "    paragraph"

        refute Expo.Blocks.Paragraph.match(line)
      end
    end
  end
end
