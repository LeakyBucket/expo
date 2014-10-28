defmodule Expo.Inlines.EmphasisTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with strong emphasis" do
      it "matches when using **" do
        line = "hello **bob**"

        assert "hello <strong>bob</strong>" = Expo.Inlines.Emphasis.match(line)
      end

      it "matches when using __" do
        line = "hello __bob__"

        assert "hello <strong>bob</strong>" = Expo.Inlines.Emphasis.match(line)
      end
    end

    context "with regular emphasis" do
      it "matches when using *" do
        line = "hello *bob*"

        assert "hello <em>bob</em>" = Expo.Inlines.Emphasis.match(line)
      end

      it "matches when using _" do
        line = "hello _bob_"

        assert "hello <em>bob</em>" = Expo.Inlines.Emphasis.match(line)
      end
    end

    context "treats unbalanced doubles as regular emphasis" do
      it "returns an <em> tag when given ** *" do
        line = "hello **bob*"

        assert "hello <em>*bob</em>" = Expo.Inlines.Emphasis.match(line)
      end

      it "returns an <em> tag when given __ _" do
        line = "hello __bob_"

        assert "hello <em>_bob</em>" = Expo.Inlines.Emphasis.match(line)
      end

      it "returns an <em> tag when given _ __" do
        line = "hello _bob__"

        assert "hello <em>bob_</em>" = Expo.Inlines.Emphasis.match(line)
      end

      it "returns an <em> tag when given * **" do
        line = "hello *bob**"

        assert "hello <em>bob*</em>" = Expo.Inlines.Emphasis.match(line)
      end
    end

    context "nested emphasis" do
      it "matches strong with regular inside when using only *" do
        line = "hello ***bob***"

        assert "hello <strong><em>bob</em></strong>" = Expo.Inlines.Emphasis.match(line)
      end

      it "matches strong with regular inside when using only _" do
        line = "hello ___bob___"

        assert "hello <strong><em>bob</em></strong>" = Expo.Inlines.Emphasis.match(line)
      end

      it "matches mixed when strong is *" do
        line = "hello **_bob_**"

        assert "hello <strong><em>bob</em></strong>" = Expo.Inlines.Emphasis.match(line)
      end

      it "matches mixed when strong is _" do
        line = "hello __*bob*__"

        assert "hello <strong><em>bob</em></strong>" = Expo.Inlines.Emphasis.match(line)
      end

      it "matches mixed when regular is outside of strong" do
        line = "hello _**bob**_"

        assert "hello <em><strong>bob</strong></em>" = Expo.Inlines.Emphasis.match(line)
      end
    end
  end
end
