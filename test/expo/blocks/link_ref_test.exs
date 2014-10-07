defmodule Expo.Blocks.LinkRefTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with a valid link reference" do
      it "matches when given no uri or title" do
        line = "[bob]:"

        assert Expo.Blocks.LinkRef.match(line) == %Expo.Blocks.LinkRef{uri: "", title: ""}
      end

      it "matches when given uri but no title" do
        line = "[bob]: /fish"

        assert Expo.Blocks.LinkRef.match(line) == %Expo.Blocks.LinkRef{uri: "/fish", title: ""}
      end

      it "matches when given uri and title" do
        line = "[bob]: /fish The fish stuff"

        assert Expo.Blocks.LinkRef.match(line) == %Expo.Blocks.LinkRef{uri: "/fish", title: "The fish stuff"}
      end

      it "matches when there are leading spaces" do
        line = "  [bob]: /fish"

        assert Expo.Blocks.LinkRef.match(line) == %Expo.Blocks.LinkRef{uri: "/fish", title: ""}
      end
    end

    context "with an invalid link reference" do
      it "doesn't match when there are at least four leading spaces" do
        line = "    [bob]: /fish"

        refute Expo.Blocks.LinkRef.match(line)
      end
    end
  end
end
