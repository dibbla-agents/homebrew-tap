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
  version "1.2.90"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.90/dibbla_1.2.90_darwin_amd64.tar.gz"
      sha256 "9622829e3f1300273dd00ea0b548afb298c091930cff0f7e2f8f5f1a36a299ad"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.90/dibbla_1.2.90_darwin_arm64.tar.gz"
      sha256 "28be387203678f608be4c47a5b6971c2d69a0be6972c20b5d98291a57aa54f2a"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.90/dibbla_1.2.90_linux_amd64.tar.gz"
      sha256 "eadbd1571e7323edf53809a789adafc440f5ae45ff3c35df4864aeb51c9a36e2"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.90/dibbla_1.2.90_linux_arm64.tar.gz"
      sha256 "d29e4fb8d23a1fb85a67f4e91bbbf3fc07f298c06ad853a15c1a7892142ddb25"
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
