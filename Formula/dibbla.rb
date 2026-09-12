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
  version "1.2.70"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.70/dibbla_1.2.70_darwin_amd64.tar.gz"
      sha256 "d2b2be8decf92de418d53920b31805fb546799fc033dcb4d5168fa389d813775"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.70/dibbla_1.2.70_darwin_arm64.tar.gz"
      sha256 "a6a8a1e7e514d572c03af7dcaaa08cc4c1073c261ba838d1287e3e4266d490f3"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.70/dibbla_1.2.70_linux_amd64.tar.gz"
      sha256 "d497b027d309c50a31f1ac6a4832542e8618e8650a60780648e61d7686a835a0"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.70/dibbla_1.2.70_linux_arm64.tar.gz"
      sha256 "5ee6ecad6e33bf7b19ef15a103be46cfba5dbcaafb360a20aae7160214ba1ce6"
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
