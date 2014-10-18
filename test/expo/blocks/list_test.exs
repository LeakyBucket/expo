defmodule Expo.Blocks.ListTest do
  use ExUnit.Case
  use ExSpec

  describe "new/2" do
    it "returns an un-ordered list when type is ul" do
      assert Expo.Blocks.List.new(:ul) == %Expo.Blocks.List{type: :ul}
    end

    it "returns an ordered list when type is ol" do
      assert Expo.Blocks.List.new(:ol) == %Expo.Blocks.List{type: :ol}
    end

    it "sets the start if specified with an ordered list" do
      assert Expo.Blocks.List.new(:ol, 4) == %Expo.Blocks.List{type: :ol, start: 4}
    end

    it "returns an error if given an unknown type" do
      assert {:error, message} = Expo.Blocks.List.new(:ll)
    end
  end

  describe "make_loose/1" do
    it "sets loose to true" do
      list = %Expo.Blocks.List{}

      assert Expo.Blocks.List.make_loose(list).loose
    end
  end

  describe "add/2" do
    context "when content is a list" do
      it "appends content to the elements list" do
        content = ["bob", "sue"]

        assert Expo.Blocks.List.add(%Expo.Blocks.List{}, content) == %Expo.Blocks.List{elements: ["bob", "sue"]}
      end
    end

    context "when content is not a list" do
      it "adds the piece of content to the elements list" do
        content = "bob"

        assert Expo.Blocks.List.add(%Expo.Blocks.List{}, content) == %Expo.Blocks.List{elements: ["bob"]}
      end
    end
  end
end
