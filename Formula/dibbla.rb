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
  version "1.2.81"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.81/dibbla_1.2.81_darwin_amd64.tar.gz"
      sha256 "fd3d0eef5fe29637d76e9c9ab20f626f13e32564aa959a9bd2c5506b34fad76d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.81/dibbla_1.2.81_darwin_arm64.tar.gz"
      sha256 "40189235295df404da058f86340fa6dafb17a39ff6355526012edda44f06588f"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.81/dibbla_1.2.81_linux_amd64.tar.gz"
      sha256 "6d0a84243f2db7732c5644f0e518ad9f263e23156c0175e53706d8c2063c39bc"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.81/dibbla_1.2.81_linux_arm64.tar.gz"
      sha256 "3b2e36490beff4f744b3ff097d387bf06316f3da6ec78a712fd531d00648a3ab"
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
