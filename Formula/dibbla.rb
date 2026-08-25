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
  version "1.2.64"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.64/dibbla_1.2.64_darwin_amd64.tar.gz"
      sha256 "d073f7034d119cdeba06c6ca5c4299e4c9069dcf6ba946f3493e1a6764583517"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.64/dibbla_1.2.64_darwin_arm64.tar.gz"
      sha256 "8e7bb09a407010497e4f13f9200aeb3bfa3c97ce02793823dee9b24c31c6b4b9"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.64/dibbla_1.2.64_linux_amd64.tar.gz"
      sha256 "88d16c3fd88267fa5875f19276c95ed1ebfb9ace0edc59bc2713066d60b0dcb4"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.64/dibbla_1.2.64_linux_arm64.tar.gz"
      sha256 "b292299b1e67c1f98455b793080bfda4100dc6b25576f7b3641ac7e1c767236e"
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
