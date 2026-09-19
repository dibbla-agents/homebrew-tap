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
  version "1.2.75"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.75/dibbla_1.2.75_darwin_amd64.tar.gz"
      sha256 "c77def025f3adfe2746de4f835eb2ac49722b9fd8620f7038b11d6b4954e1ec2"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.75/dibbla_1.2.75_darwin_arm64.tar.gz"
      sha256 "e6642f1af63e3b9382b6ac82961f943c96951e8dcadf9a9b0f0847e0b71ad811"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.75/dibbla_1.2.75_linux_amd64.tar.gz"
      sha256 "6d02a2a3dd73b8dca100f851b0a52dec69ed9ef49bc6a03747f932d62ea63a62"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.75/dibbla_1.2.75_linux_arm64.tar.gz"
      sha256 "f63655a65a46562264386248915a89f694883ba8902a8bd56bf97d9e73ca299c"
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
