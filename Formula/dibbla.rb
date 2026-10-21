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
  version "1.2.85"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.85/dibbla_1.2.85_darwin_amd64.tar.gz"
      sha256 "4a811f9daad85161718df1172188609ba48ce91a40fffdc4ac13a9b2d68a5119"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.85/dibbla_1.2.85_darwin_arm64.tar.gz"
      sha256 "1442db76fbd89d25daaf19b497e8b25bb5b27b4e0cff7fdf2ab371873165d0fd"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.85/dibbla_1.2.85_linux_amd64.tar.gz"
      sha256 "72055a3de1e4cb3f17c4a4046d0d9fd8be7cbfba80c6612ba64c1651d9995fd7"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.85/dibbla_1.2.85_linux_arm64.tar.gz"
      sha256 "3dd5a380611823e273ceed2938ea2d8d5543187fc44d974dd5dca103584feb84"
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
