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
  version "1.2.87"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.87/dibbla_1.2.87_darwin_amd64.tar.gz"
      sha256 "828d7bec8bfe0b0ddee4276032cb0728df29d32ae0bc3107fcf8c12e4da69e4f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.87/dibbla_1.2.87_darwin_arm64.tar.gz"
      sha256 "1c3d3bf2c55987dcce16f1da0aaf9db4342fc512e5a7db1dc2f9c2c18322a401"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.87/dibbla_1.2.87_linux_amd64.tar.gz"
      sha256 "e7571f2eb67483f96b863fadd69240341d1803b9e5f492508e66d3781df038ac"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.87/dibbla_1.2.87_linux_arm64.tar.gz"
      sha256 "a6542bf1357c022f41e2b2176c87e8ebdb49ff0e22f8176606a44290d906a409"
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
