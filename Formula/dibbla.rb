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
  version "1.2.73"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.73/dibbla_1.2.73_darwin_amd64.tar.gz"
      sha256 "b1bc7b392217fb00a5be3a7a0be8f8ff2a8b4b5d45a7afa5c18e64d42e9d1205"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.73/dibbla_1.2.73_darwin_arm64.tar.gz"
      sha256 "71c63a6401f94089f7c210475181b1ad5b3c9869d7de8bd2b51ec4cc8af9d3d7"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.73/dibbla_1.2.73_linux_amd64.tar.gz"
      sha256 "3825478fa6bcb7ed907fedf0a40aba13346ff36f5cf6c95c64b42711e5be2497"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.73/dibbla_1.2.73_linux_arm64.tar.gz"
      sha256 "a6d486c301d3e74345b7d5233a36e1010fc68cf6541a576b3dec4e9d19dc23bf"
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
