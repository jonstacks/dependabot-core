# typed: false
# frozen_string_literal: true

require "spec_helper"
require "dependabot/bazel/package_manager"

RSpec.describe Dependabot::Bazel::PackageManager do
  subject(:package_manager) { described_class.new(detected_version: detected_version, raw_version: raw_version) }

  let(:raw_version) { detected_version }

  describe "#unsupported?" do
    context "when detected version is 6.x" do
      let(:detected_version) { "6.x" }

      it "returns false" do
        expect(package_manager.unsupported?).to be(false)
      end
    end

    context "when detected version is 7.x" do
      let(:detected_version) { "7.x" }

      it "returns false" do
        expect(package_manager.unsupported?).to be(false)
      end
    end

    context "when detected version is 5.x" do
      let(:detected_version) { "5.x" }

      it "returns true" do
        expect(package_manager.unsupported?).to be(true)
      end
    end
  end

  describe "#raise_if_unsupported!" do
    context "when detected version is 6.x" do
      let(:detected_version) { "6.x" }

      it "does not raise" do
        expect { package_manager.raise_if_unsupported! }.not_to raise_error
      end
    end

    context "when detected version is 7.x" do
      let(:detected_version) { "7.x" }

      it "does not raise" do
        expect { package_manager.raise_if_unsupported! }.not_to raise_error
      end
    end

    context "when detected version is 5.x" do
      let(:detected_version) { "5.x" }

      it "raises a ToolVersionNotSupported error" do
        expect { package_manager.raise_if_unsupported! }.to raise_error(Dependabot::ToolVersionNotSupported)
      end
    end
  end
end
