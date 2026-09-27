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
  version "1.2.80"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.80/dibbla_1.2.80_darwin_amd64.tar.gz"
      sha256 "954b5bd7e377aada0eb67e80d78219d1e3d779d56164d9d4db186c5269ca1a9b"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.80/dibbla_1.2.80_darwin_arm64.tar.gz"
      sha256 "192f165e216b53b725bf62095466ce435dcfd68cb4e9bef2005d2fd8d2b36a1e"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.80/dibbla_1.2.80_linux_amd64.tar.gz"
      sha256 "05c9eeee30f3db4acb9392eecbdbc9d71f1952c0bc4bb26217a5098f55d3da5c"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.80/dibbla_1.2.80_linux_arm64.tar.gz"
      sha256 "3ac2decabc7bb42863dcb3a3970716cd12aaadabeeab5ab3de3351d98e7c6005"
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
