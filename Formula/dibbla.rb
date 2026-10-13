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
  version "1.2.84"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.84/dibbla_1.2.84_darwin_amd64.tar.gz"
      sha256 "f666b55287c307ab7447fd9760f21a3f0cce589305a315cbcea9193cc2b337b5"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.84/dibbla_1.2.84_darwin_arm64.tar.gz"
      sha256 "c0461c8f7caaf72fb283b87777132081a30d3a10de83d635aa8f2d4c166c21de"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.84/dibbla_1.2.84_linux_amd64.tar.gz"
      sha256 "5f7a5883a7aed76aca7d011351375c519b473edcf19d1c9a3a7f162054086ee8"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.84/dibbla_1.2.84_linux_arm64.tar.gz"
      sha256 "c7e83c33035fb03e5f7db96c2670277be19da3090d6849936b3c773c2c082fec"
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
