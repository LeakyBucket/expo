defmodule Expo.Services.LinkRefTest do
  use ExUnit.Case
  use ExSpec

  describe "add/2" do
    context "with binary name" do
      it "adds the link ref" do
        Expo.Services.LinkRef.start_link

        assert Expo.Services.LinkRef.add "homepage", "www.com"
      end
    end

    context "with atom name" do
      it "adds the link ref" do
        Expo.Services.LinkRef.start_link

        assert Expo.Services.LinkRef.add :homepage, "www.com"
      end
    end
  end

  describe "uri_for/1" do
    context "with binary name" do
      it "returns the uri" do
        Expo.Services.LinkRef.start_link
        Expo.Services.LinkRef.add :homepage, "www.com"

        assert Expo.Services.LinkRef.uri_for("homepage") == "www.com"
      end
    end

    context "with atom name" do
      it "returns the uri" do
        Expo.Services.LinkRef.start_link
        Expo.Services.LinkRef.add "homepage", "www.com"

        assert Expo.Services.LinkRef.uri_for(:homepage) == "www.com"
      end
    end
  end
end
