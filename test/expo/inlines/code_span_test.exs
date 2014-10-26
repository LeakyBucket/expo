defmodule Expo.Inlines.CodeSpanTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with a line containing a code span" do
      it "matches multiple opening ` characters" do
        line = "the ``Expo.Inlines.CodeSpan`` handles code spans"

        assert "the <code>Expo.Inlines.CodeSpan</code> handles code spans" = Expo.Inlines.CodeSpan.match(line)
      end

      it "matches single opening ` characters" do
        line = "the `Expo.Inlines.CodeSpan` handles code spans"

        assert "the <code>Expo.Inlines.CodeSpan</code> handles code spans" = Expo.Inlines.CodeSpan.match(line)
      end

      it "matches when there are backtick characters in the span" do
        line = "the ``Expo.Inlines.CodeSpan ` Magic``"

        assert "the <code>Expo.Inlines.CodeSpan ` Magic</code>" = Expo.Inlines.CodeSpan.match(line)
      end
    end

    context "with a line not containing a code span" do
      it "doesn't match if there is no closing backtick" do
        line = "the `Expo.Inlines.CodeSpan is awesome"

        refute Expo.Inlines.CodeSpan.match(line)
      end

      it "doesn't match if there is no balanced backtick pair" do
        line = "the ``Expo.Inlines.CodeSpan` is awesome"

        refute Expo.Inlines.CodeSpan.match(line)
      end
    end
  end
end
