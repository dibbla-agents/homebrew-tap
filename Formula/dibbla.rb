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
  version "1.2.78"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.78/dibbla_1.2.78_darwin_amd64.tar.gz"
      sha256 "fcf79a54d9e3800d83167b3ec419608d721b9c840041d33160d6609c4ec7bcd8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.78/dibbla_1.2.78_darwin_arm64.tar.gz"
      sha256 "95b7fd7096a3e119112e589af40f1ee0b827f3e58280f22b605d16408437277c"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.78/dibbla_1.2.78_linux_amd64.tar.gz"
      sha256 "f9fddef0ddc3d46876ec5824c20f5d07de0e38f5a93f7ba7fedb69cfb56c8ea7"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.78/dibbla_1.2.78_linux_arm64.tar.gz"
      sha256 "c323f1df58ac6d24e53e73a68c44eca1026b8b2d804405ceef9a595bba01cbee"
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
