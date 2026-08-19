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
  version "1.2.55"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.55/dibbla_1.2.55_darwin_amd64.tar.gz"
      sha256 "2a2ccff2b7bd6472b7beb008aa210f3eaed33c054c908648c3917cb50475d277"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.55/dibbla_1.2.55_darwin_arm64.tar.gz"
      sha256 "229f67503dd779f0c26968b553dfc875e88fa46f2b60be74bcd91b3d0500ba85"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.55/dibbla_1.2.55_linux_amd64.tar.gz"
      sha256 "0e6e50bad75360c78d4ff04d53b6dca03c9f826368cbd559af1438f889446824"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.55/dibbla_1.2.55_linux_arm64.tar.gz"
      sha256 "d74ca8be16bda9dccda2d937b41b2ee663369cdccb1345a86af0589ed48adffa"
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
