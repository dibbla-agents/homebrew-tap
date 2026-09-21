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
  version "1.2.76"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.76/dibbla_1.2.76_darwin_amd64.tar.gz"
      sha256 "c156856600f84f5e4290f307d066255ceb679ba863ceb02aefb0bc24b85e493f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.76/dibbla_1.2.76_darwin_arm64.tar.gz"
      sha256 "32d9e27d4da4773db6d916364bd56ead75250c99dbc0421f6c0e6c61632e7713"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.76/dibbla_1.2.76_linux_amd64.tar.gz"
      sha256 "4d2e77e1b61b10cbac8b0bb0f9e7d67b86e63da81a84a6b1b1000a8dbad959dc"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.76/dibbla_1.2.76_linux_arm64.tar.gz"
      sha256 "621c1a92a49048addf6938fdf5c5f25fa213688b70010300327aecbe7d97710e"
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
