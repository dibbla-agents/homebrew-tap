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
  version "1.2.79"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.79/dibbla_1.2.79_darwin_amd64.tar.gz"
      sha256 "0998d97306f3e8f50b8e7eb2ed3b26e6a4ac5b4f1dadf637bd27b62f09546a58"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.79/dibbla_1.2.79_darwin_arm64.tar.gz"
      sha256 "74079ece5b470628d2ca4b399a17835f226e663aa06e7b9a62359f906e8ffaec"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.79/dibbla_1.2.79_linux_amd64.tar.gz"
      sha256 "3a1fea81ae127fa8b9b90b71a5dafcaf9a859b67631195e2fd54068f73747ff8"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.79/dibbla_1.2.79_linux_arm64.tar.gz"
      sha256 "7d7cf3dde3c21c0e2cd9be6e17e97337923010bc245a58f0965164c244b3fb88"
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
