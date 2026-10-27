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
  version "1.2.86"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.86/dibbla_1.2.86_darwin_amd64.tar.gz"
      sha256 "0127d899a60dd70c66f2da0667d900f5ac28a41b0ac870ecc346ebb0468a3ab2"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.86/dibbla_1.2.86_darwin_arm64.tar.gz"
      sha256 "310ff67a89c57360470affcf6fd18893f709b094af2fc93a4838782f3912e110"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.86/dibbla_1.2.86_linux_amd64.tar.gz"
      sha256 "4b110370b6f6dfeaf6a7c2e0c983a929c8fc5b28787257c2dfc75212a4ec012d"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.86/dibbla_1.2.86_linux_arm64.tar.gz"
      sha256 "4be29026a83d7852a3ce71a65bbd45b43b60ef42e4e9a814637d7ad79ba066d3"
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
