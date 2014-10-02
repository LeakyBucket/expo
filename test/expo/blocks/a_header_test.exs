defmodule Expo.Blocks.AHeaderTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with valid ATX header" do
      it "correctly sets level and content" do
        line = "### Level 3"

        assert Expo.Blocks.AHeader.match(line) == %Expo.Blocks.AHeader{level: 3, content: "Level 3"}
      end
    end

    context "with invalid ATX header" do
      it "returns false if there are more than 6 hashes" do
        line = "####### Level 7"

        refute Expo.Blocks.AHeader.match(line)
      end

      it "returns false if there are more than three spaces at the start of the line" do
        line = "    ### Level 3"

        refute Expo.Blocks.AHeader.match(line)
      end
    end
  end
end
