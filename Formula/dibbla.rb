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
  version "1.2.61"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.61/dibbla_1.2.61_darwin_amd64.tar.gz"
      sha256 "90513869c14c8d0f0ec049b17f4290ec7d33e5fc550da7794d366e52c13135ee"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.61/dibbla_1.2.61_darwin_arm64.tar.gz"
      sha256 "39415eeecc18dc0e42095b039cbc0ee552eb9770ba613d7926a4a0a60aeb8ace"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.61/dibbla_1.2.61_linux_amd64.tar.gz"
      sha256 "79cc835363e330cfa06406b141e0ac5ca57819ffca13695f8edaddbee9817b6c"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.61/dibbla_1.2.61_linux_arm64.tar.gz"
      sha256 "cf3b0eddeeac2a9b2fa7d7b997ee56005c68398b7c462f631b77beafc036081f"
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
