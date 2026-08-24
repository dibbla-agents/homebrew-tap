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
  version "1.2.63"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.63/dibbla_1.2.63_darwin_amd64.tar.gz"
      sha256 "3e9fb2bdc25d7f12e63d7e2e01dc8dd2a81f3a589849ea08fbbfc62f4bc60ccb"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.63/dibbla_1.2.63_darwin_arm64.tar.gz"
      sha256 "cebbd5e81339a205b845f8da82877e65c22ec7dab3a807891a0c73d7297f1254"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.63/dibbla_1.2.63_linux_amd64.tar.gz"
      sha256 "174f00c2bd75fccd23ef57777f4f95b171191747c60f2e3c2feb52cf53fabc1c"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.63/dibbla_1.2.63_linux_arm64.tar.gz"
      sha256 "abe9753d9981b58c23ce7c5790dfc93e7b6e299b7901babcea0043ad8da7db22"
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
