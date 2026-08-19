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
  version "1.2.56"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.56/dibbla_1.2.56_darwin_amd64.tar.gz"
      sha256 "4a09061acba1e23ba81b66e997181498bf1c069d275e2e879bf1576922100f45"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.56/dibbla_1.2.56_darwin_arm64.tar.gz"
      sha256 "e2cda9b90e18472d36199e6e731c91eb00f4ece8d8e19ba01b600c0e13f92ffe"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.56/dibbla_1.2.56_linux_amd64.tar.gz"
      sha256 "323838fd4d439375b1a4ea7ce6b4ef47a05961323815cb06e52cfba77d17745f"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.56/dibbla_1.2.56_linux_arm64.tar.gz"
      sha256 "68b9869581eecf71681431e3468f74ec6c59e549abd0f843a70ae20e62dae90b"
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
