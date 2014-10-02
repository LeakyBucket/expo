defmodule Expo.Blocks.HRuleTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with valid horizontal rule" do
      it "matches a hr composed of - characters" do
        line = "---"

        assert Expo.Blocks.HRule.match(line) == %Expo.Blocks.HRule{attributes: []}
      end

      it "matches a hr composed of _ characters" do
        line = "___"

        assert Expo.Blocks.HRule.match(line) == %Expo.Blocks.HRule{attributes: []}
      end

      it "matches a hr composed of * characters" do
        line = "***"

        assert Expo.Blocks.HRule.match(line) == %Expo.Blocks.HRule{attributes: []}
      end

      it "matches a hr with spaces at the front" do
        line = "   ---"

        assert Expo.Blocks.HRule.match(line) == %Expo.Blocks.HRule{attributes: []}
      end

      it "matches a hr with spaces mixed in" do
        line = "- -  -"

        assert Expo.Blocks.HRule.match(line) == %Expo.Blocks.HRule{attributes: []}
      end

      it "matches a hr with spaces at the front and mixed in" do
        line = "   - - -"

        assert Expo.Blocks.HRule.match(line) == %Expo.Blocks.HRule{attributes: []}
      end
    end

    context "with invalid horizontal rule" do
      it "doesn't match a hr with mixed characters" do
        line = "-*-"

        refute Expo.Blocks.HRule.match(line)
      end

      it "doesn't match a hr with too many spaces at the beginning" do
        line = "    ---"

        refute Expo.Blocks.HRule.match(line)
      end
    end
  end
end
