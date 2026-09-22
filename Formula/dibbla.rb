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
  version "1.2.77"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.77/dibbla_1.2.77_darwin_amd64.tar.gz"
      sha256 "914b20191a78d47969b887c9f2604a279b6f04cbbbcb0f6f1421c17236dae32a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.77/dibbla_1.2.77_darwin_arm64.tar.gz"
      sha256 "22ba1a7a66aa8d473ca3a2ac2636ec538582cce95fe663d775d74305ecc79865"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.77/dibbla_1.2.77_linux_amd64.tar.gz"
      sha256 "597ae440f83baeadc1449224c0b9aa2d53ea404cd44c6566037c37517e202530"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.77/dibbla_1.2.77_linux_arm64.tar.gz"
      sha256 "69c6c7ce95f91215ca4ec2b02c24e9475aec45e9e8f10347ac24973d26ef6ad1"
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
