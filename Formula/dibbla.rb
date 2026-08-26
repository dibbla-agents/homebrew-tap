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
  version "1.2.67"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.67/dibbla_1.2.67_darwin_amd64.tar.gz"
      sha256 "7a9596077a0b2134402e91ad258fe249f7343f645db62bf3d42c7b9af245d7c4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.67/dibbla_1.2.67_darwin_arm64.tar.gz"
      sha256 "78e1a9ad3944beb8e0377115e6c88b88496ac41df5953dc4be1e7d94f1db77e6"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.67/dibbla_1.2.67_linux_amd64.tar.gz"
      sha256 "aafae2289254d700453464916f11c911d5caf833d5022a7656b1484935a3fa48"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.67/dibbla_1.2.67_linux_arm64.tar.gz"
      sha256 "15e8dd39461b77640b23a812e877f51cf58afd112cffc4d36b5573917c9ebe47"
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
