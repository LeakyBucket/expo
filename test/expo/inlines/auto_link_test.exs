defmodule Expo.Inlines.AutoLinkTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "valid link" do
      it "matches if given a valid scheme" do
        line = "<https://valid.com>"

        assert "<a href=\"https://valid.com\">https://valid.com</a>" = Expo.Inlines.AutoLink.match(line)
      end

      it "matches with surrounding content" do
        line = "go to <https://valid.com> now"

        assert "go to <a href=\"https://valid.com\">https://valid.com</a> now" = Expo.Inlines.AutoLink.match(line)
      end
    end

    context "invalid link" do
      it "doesn't match if the scheme is missing" do
        line = "<uri.com/endpoint>"

        assert ^line = Expo.Inlines.AutoLink.match(line)
      end

      it "doesn't match if the scheme is invalid" do
        line = "<bullshit://uri.com>"

        assert ^line = Expo.Inlines.AutoLink.match(line)
      end
    end
  end
end
