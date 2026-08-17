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
  version "1.2.54"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.54/dibbla_1.2.54_darwin_amd64.tar.gz"
      sha256 "c3fe7d4aa24785f813f5f7ce52d6f4235aee043a0a364a63cd2892a49b9bd2bf"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.54/dibbla_1.2.54_darwin_arm64.tar.gz"
      sha256 "4d0656593974901be0f6c5fa4b91b7fb7c8834aa568d02b8d2d6687cfeb1dfd8"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.54/dibbla_1.2.54_linux_amd64.tar.gz"
      sha256 "0e74041533a86c2c7fcbfef7c9e53b78d7efbf2f88f8b181e5d4731c31497a36"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.54/dibbla_1.2.54_linux_arm64.tar.gz"
      sha256 "99a5904e2caad26a26cb0fe6e869e8e96460aa893341a60c79b59fbcb0e7289c"
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
