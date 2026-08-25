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
  version "1.2.65"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.65/dibbla_1.2.65_darwin_amd64.tar.gz"
      sha256 "cef2cebfa21374ec95ae39d3511769e47421bf91df7758e7dd0ebd5ec3c6d295"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.65/dibbla_1.2.65_darwin_arm64.tar.gz"
      sha256 "b1b4cdb1c6b597c1b0d67b34bffc6e6b8abd8b02164c64011a646532ba7fed87"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.65/dibbla_1.2.65_linux_amd64.tar.gz"
      sha256 "9b62c9dea81cfc00e7f19a9b851fee0af06e0632b0294ba68d5f87e87d42f36f"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.65/dibbla_1.2.65_linux_arm64.tar.gz"
      sha256 "958cc96d23692f2f409edc21822785ac9678eae5d652353c0516faf3b5830238"
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
