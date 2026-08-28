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
  version "1.2.69"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.69/dibbla_1.2.69_darwin_amd64.tar.gz"
      sha256 "eb1da6e79a4f6451935be4161da88e390841424b5bfd0774491615a2045cdc3e"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.69/dibbla_1.2.69_darwin_arm64.tar.gz"
      sha256 "043a33957bd50714ea25ee57a472c214fc8714f00b9de77ef32b75e148f64d7c"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.69/dibbla_1.2.69_linux_amd64.tar.gz"
      sha256 "53f1fa3f06862ef52bccf2baa1ed885594e55a1ae0b8f4ea8a79bd0660cc990c"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.69/dibbla_1.2.69_linux_arm64.tar.gz"
      sha256 "4ef8cacd5afd3d2b7a034c20776dcb95c74798f29e338389e41f3857f9f067fc"
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
