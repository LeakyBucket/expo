defmodule Expo.Blocks.FCodeTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with valid code fence" do
      it "builds a struct with the opening fence" do
        line = "---"

        assert Expo.Blocks.FCode.match(line) == %Expo.Blocks.FCode{info_string: "", content: "", open: true, multi_line: true, fence: "---"}
      end

      it "builds a struct with the info_string if present" do
        line = "```elixir"

        assert Expo.Blocks.FCode.match(line) == %Expo.Blocks.FCode{info_string: "elixir", content: "", open: true, multi_line: true, fence: "```"}
      end
    end
  end
end
