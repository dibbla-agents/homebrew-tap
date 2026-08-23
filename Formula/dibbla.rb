# typed: false
# frozen_string_literal: true

# Rendered by .github/workflows/release.yml from
# .github/homebrew/dibbla.rb.tmpl. DO NOT EDIT IN THE TAP.
#
# Checksums here are taken from the release's final checksums.txt, i.e.
# *after* macOS notarization and Windows signing have replaced the
# artifacts. Edit the template in dibbla-cli, not the generated formula.
class Dibbla < Formula
  desc "Dibbla CLI for managing Dibbla applications"
  homepage "https://dibbla.com"
  version "1.2.60"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.60/dibbla_1.2.60_darwin_amd64.tar.gz"
      sha256 "230b67f97706bfbef7d1bfb972c3144a72bb39708d06bafb5ce2e57b314abb35"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.60/dibbla_1.2.60_darwin_arm64.tar.gz"
      sha256 "306aad808de5e5bbea6b16b9e2d5f89c9b8798ee68880b6331e5db47fe075ace"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.60/dibbla_1.2.60_linux_amd64.tar.gz"
      sha256 "c1b0c8fe45c7b4bc360b4ec3b1449fa380a233e8dd4d18b076cd18de844ab9eb"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.60/dibbla_1.2.60_linux_arm64.tar.gz"
      sha256 "144e501b0ae5093446e744961c99f164739522446184d50e429589f92186d57f"
    end
  end

  # Declared once at class level. GoReleaser used to duplicate this block
  # into all four CPU branches; it is identical in every one of them.
  def install
    bin.install "dibbla"
    # Runs `dibbla completion <shell>` for bash, zsh and fish and installs
    # the output into the right prefix for each.
    generate_completions_from_executable(bin/"dibbla", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dibbla --version")
  end
end
