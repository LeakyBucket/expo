defmodule Expo.Inlines.LinkTest do
  use ExUnit.Case
  use ExSpec

  describe "match/1" do
    context "with valid link" do
      it "finds the label" do
        line = "[a link](http://www.bob.com)"

        assert "<a href=\"http://www.bob.com\">a link</a>" = Expo.Inlines.Link.match(line)
      end

      it "finds a destination wrapped in angle brackets" do
        line = "[a link](<the target>)"

        assert "<a href=\"the target\">a link</a>" = Expo.Inlines.Link.match(line)
      end

      it "finds a destination without angle brackets" do
        line = "[a link](http://www.bob.com)"

        assert "<a href=\"http://www.bob.com\">a link</a>" = Expo.Inlines.Link.match(line)
      end

      it "finds the title when wrapped in double quotes" do
        line = "[a link](http://www.bob.com \"link title\")"

        assert "<a href=\"http://www.bob.com\" title=\"link title\">a link</a>" = Expo.Inlines.Link.match(line)
      end

      it "finds the title when wrapped in single quotes" do
        line = "[a link](http://www.bob.com 'link title')"

        assert "<a href=\"http://www.bob.com\" title=\"link title\">a link</a>"
      end

      it "finds the title when wrapped in parens" do
        line = "[a link](http://www.bob.com (link title))"

        assert "<a href=\"http://www.bob.com\" title=\"link title\">a link</a>" = Expo.Inlines.Link.match(line)
      end
    end

    context "with invalid link" do
      it "returns the original string" do
        line = "[my friend]("

        assert "[my friend](" = Expo.Inlines.Link.match(line)
      end
    end
  end
end
