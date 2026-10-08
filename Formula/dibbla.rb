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
  version "1.2.83"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.83/dibbla_1.2.83_darwin_amd64.tar.gz"
      sha256 "0b36f6d96e58b862aa18fc67ec1945b831b1212b053d1852b8bef18de67789eb"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.83/dibbla_1.2.83_darwin_arm64.tar.gz"
      sha256 "e08ba938b515bf648f4f648793459a7ab1086172c66a3bc9c9d9a6d6aac6a10b"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.83/dibbla_1.2.83_linux_amd64.tar.gz"
      sha256 "0a41e41737bfc8164ab31baa7d3406405cb35336601e8a0a993bf332d03f9163"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.83/dibbla_1.2.83_linux_arm64.tar.gz"
      sha256 "9e03fb152b9e124ebf5cc7a2215cfa8a8e040979a105589c1868253984ff26b6"
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
