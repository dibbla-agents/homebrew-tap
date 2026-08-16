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
  version "1.2.53"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.53/dibbla_1.2.53_darwin_amd64.tar.gz"
      sha256 "2930b2505f3ccfb3acc582824eeebb4ea6183bedea92f55879513b3a6f19d852"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.53/dibbla_1.2.53_darwin_arm64.tar.gz"
      sha256 "d8e57931b27ba5108398d61d7a6fddaaca0c0c9ca712b1da29d7dde7f49cafee"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.53/dibbla_1.2.53_linux_amd64.tar.gz"
      sha256 "3bb56a3531a7dd1c3b6679bd75bad79d8952d217c0a234756d1565eeb9373d72"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.53/dibbla_1.2.53_linux_arm64.tar.gz"
      sha256 "de926b20b6553dab794b0635ee1e513b7837976b2ccbe35903b27497dff1d304"
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
