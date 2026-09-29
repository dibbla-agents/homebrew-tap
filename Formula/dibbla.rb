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
  version "1.2.82"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.82/dibbla_1.2.82_darwin_amd64.tar.gz"
      sha256 "4d8b04e5afb1ff8b92acbabb4c826286a7d834854699db7544b062987740f508"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.82/dibbla_1.2.82_darwin_arm64.tar.gz"
      sha256 "6ab987e6e4238177e7c77c7c7f28d171590a6b2758af16dfd638a0e4e40d2c40"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.82/dibbla_1.2.82_linux_amd64.tar.gz"
      sha256 "9b89a0cbf84d83ffd2c1992074b1c333405331b50273748e81defb0cceaa6d0d"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.82/dibbla_1.2.82_linux_arm64.tar.gz"
      sha256 "e7d07dd3a6eaadd6906b7cf270973c019381b6e74c9e3a81b1e6c8c0c5d0b20a"
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
