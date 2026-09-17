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
  version "1.2.71"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.71/dibbla_1.2.71_darwin_amd64.tar.gz"
      sha256 "222396292251fd6380629be50df085094441919a5fbc864d86527109a23a34ba"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.71/dibbla_1.2.71_darwin_arm64.tar.gz"
      sha256 "542feb1604049cec5085bc7032a82a44a50d07cec3c720154c9de3943305e2b8"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.71/dibbla_1.2.71_linux_amd64.tar.gz"
      sha256 "628f11e56338c3bac83e02d88f3df6c21fa5b72bf974b08ca74b38f809400bff"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.71/dibbla_1.2.71_linux_arm64.tar.gz"
      sha256 "de760f3e2d922dda98163fbc91fbd33f5e9a4f6713ea4cd0a7273055bda5b334"
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
