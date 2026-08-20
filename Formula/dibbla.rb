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
  version "1.2.59"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.59/dibbla_1.2.59_darwin_amd64.tar.gz"
      sha256 "d6d6aa7bdc237cd77b0c4b19f8ac2976423dff98ccb1055a298a70d50d2168b6"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.59/dibbla_1.2.59_darwin_arm64.tar.gz"
      sha256 "b6ddf91c6c3cc08c440d5bd313614f41baa9793aa21773ba6e7a5092a45b55b8"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.59/dibbla_1.2.59_linux_amd64.tar.gz"
      sha256 "3b1352bfa97e63e51b8fe0ed7182bf0e5bf33670fee21a0340956393ed6f42dc"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.59/dibbla_1.2.59_linux_arm64.tar.gz"
      sha256 "a3b284f2468e1914b099c01b34af167e58a9613d4be7f44bd4645ef954064e42"
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
