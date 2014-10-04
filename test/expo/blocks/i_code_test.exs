defmodule Expo.Blocks.ICodeTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with a valid indented code block" do
      it "matches on four spaces" do
        line = "    code"

        assert Expo.Blocks.ICode.match(line) == %Expo.Blocks.ICode{attributes: [], content: "code", open: true, multi_line: true}
      end

      it "matches with more than four spaces" do
        line = "     code"

        assert Expo.Blocks.ICode.match(line) == %Expo.Blocks.ICode{attributes: [], content: " code", open: true, multi_line: true}
      end
    end

    context "with an invalid indented code block" do
      it "returns false if there aren't enough leading spaces" do
        line = "   code"

        refute Expo.Blocks.ICode.match(line)
      end
    end
  end

  describe "append_content/2" do
    it "adds the given content to the block record" do
      content = "  bob"
      i_code = %Expo.Blocks.ICode{content: "albert\n"}

      assert Expo.Blocks.ICode.append_content(i_code, content).content == "albert\n  bob"
    end
  end

  describe "close/1" do
    it "toggles the open flag" do
      i_code = %Expo.Blocks.ICode{content: "code"}

      refute Expo.Blocks.ICode.close(i_code).open
    end
  end
end
