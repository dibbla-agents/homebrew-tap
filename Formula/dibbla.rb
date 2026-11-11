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
  version "1.2.89"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.89/dibbla_1.2.89_darwin_amd64.tar.gz"
      sha256 "24837bdc86115f5e76aa5462f053f3d818fdc65f8786a3e5529e647df872dcfd"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.89/dibbla_1.2.89_darwin_arm64.tar.gz"
      sha256 "0ddfc7993318d822b201652df4048ab9cf6b9f9e95840e2b91e9927ffb2b1fd7"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.89/dibbla_1.2.89_linux_amd64.tar.gz"
      sha256 "e50cf34b3351143c11410f8320a811cd5c1808bde8383d198922e5462fa77099"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.89/dibbla_1.2.89_linux_arm64.tar.gz"
      sha256 "389b7c2fff3a2e4de340f090ba4ed4dc170604300824dae143515b64354152e0"
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
