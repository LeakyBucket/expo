defmodule Expo.Blocks.ICodeTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with a valid indented code block" do
      it "matches on four spaces" do
        line = "    code"

        assert Expo.Blocks.ICode.match(line) == %Expo.Blocks.ICode{attributes: [], content: "code"}
      end

      it "matches with more than four spaces" do
        line = "     code"

        assert Expo.Blocks.ICode.match(line) == %Expo.Blocks.ICode{attributes: [], content: " code"}
      end
    end

    context "with an invalid indented code block" do
      it "returns false if there aren't enough leading spaces" do
        line = "   code"

        refute Expo.Blocks.ICode.match(line)
      end
    end
  end
end
