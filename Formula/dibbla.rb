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
  version "1.2.92"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.92/dibbla_1.2.92_darwin_amd64.tar.gz"
      sha256 "cbd057af3171d3480d84e784d05b1598c10529a7e0f8e12a17b8dbe58cb74a3d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.92/dibbla_1.2.92_darwin_arm64.tar.gz"
      sha256 "ff38bd118a47186e006ab07506ca64d540700bf7049868ef7bf9f52016d81b1d"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.92/dibbla_1.2.92_linux_amd64.tar.gz"
      sha256 "ee25fa0c2a04b4d1b8e377cb98f98f77e9f7b27629229dcd77cda1909dd35dad"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.92/dibbla_1.2.92_linux_arm64.tar.gz"
      sha256 "87b429a1fe30551b07141493fa4613e4331624a69735a138ffdf5dbcca9b7b50"
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
