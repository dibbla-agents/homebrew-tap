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
  version "1.2.74"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.74/dibbla_1.2.74_darwin_amd64.tar.gz"
      sha256 "54f512d6f28e51e8d1e87f20ab75f58c52db5652fedc5117517407e69e08a08d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.74/dibbla_1.2.74_darwin_arm64.tar.gz"
      sha256 "c0f3a7cb2d73c35d15989a6dc9747b2ba11228832fcc42c4a0348e97bc4b77d9"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.74/dibbla_1.2.74_linux_amd64.tar.gz"
      sha256 "ca7dc5c7fc04fe0ab2c7c1d17a3a8f332cb6353cb02ae44752c3baa6e2893c8c"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.74/dibbla_1.2.74_linux_arm64.tar.gz"
      sha256 "3f4e70db04eaa024740ef0abdb25cb228c0f8f26433f3391572097b867a410e3"
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
