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
  version "1.2.88"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.88/dibbla_1.2.88_darwin_amd64.tar.gz"
      sha256 "123f3423dda499358d45e3166a35a7c06ba58963723289241ab3ff322cc62d64"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.88/dibbla_1.2.88_darwin_arm64.tar.gz"
      sha256 "988c5893788a3cd6a335f9c55374797b960327cfe4168ba302e875b2b0ff871c"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.88/dibbla_1.2.88_linux_amd64.tar.gz"
      sha256 "e49938c9f8e70d8546b6fbe21368aade40567f9ad226d079c179457337a4d7a1"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.88/dibbla_1.2.88_linux_arm64.tar.gz"
      sha256 "cdcb990e160feab619c6cb922995731c40d4828650fabe35d82d67136ac2de79"
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
