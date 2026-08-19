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
  version "1.2.57"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.57/dibbla_1.2.57_darwin_amd64.tar.gz"
      sha256 "0d92e21433e91ce4886ef2319ec1a43556dd76eeaf57a62e3f6905e5d38bd49c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.57/dibbla_1.2.57_darwin_arm64.tar.gz"
      sha256 "c446d48aae694b83ba1531a5a4f8111b64bcb376a1fd677b1e2570c34deb33d4"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.57/dibbla_1.2.57_linux_amd64.tar.gz"
      sha256 "686b4dd3be69631cc50286c8146fe28b2b48685c1d177354a71be8d574aaca44"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.57/dibbla_1.2.57_linux_arm64.tar.gz"
      sha256 "f5667d115a43a69e0f63d3153fca93850bcc6a666d6e030035fdc9a1e92f2391"
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
