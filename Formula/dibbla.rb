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
  version "1.2.62"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.62/dibbla_1.2.62_darwin_amd64.tar.gz"
      sha256 "8ac5c7fee91259d98a1e6a1753bb621874c95aeea819ab390d09106b8413494b"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.62/dibbla_1.2.62_darwin_arm64.tar.gz"
      sha256 "f857f77d5d859b604109dd09b8a9d9088921eac58231fc50f4edff09f61ac12a"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.62/dibbla_1.2.62_linux_amd64.tar.gz"
      sha256 "55cafd296292e9e2d3012775d45b50a9e52c08ca8df81f1ee35b3f966c0739ce"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.62/dibbla_1.2.62_linux_arm64.tar.gz"
      sha256 "07709e2a432471ee73cccc76e41a5ed0cabc6da0a6f483e557b232143f422bf8"
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
