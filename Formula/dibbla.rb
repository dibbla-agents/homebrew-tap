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
  version "1.2.91"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.91/dibbla_1.2.91_darwin_amd64.tar.gz"
      sha256 "acd5fb82e6d71b5ee8e27fca5bb3a3e7652d0b3b1954eca12a89d1b69318589b"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.91/dibbla_1.2.91_darwin_arm64.tar.gz"
      sha256 "741446a71f07c52ef552eeb400fe826c332dba6e26ddc83f24cf70feb39ca14d"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.91/dibbla_1.2.91_linux_amd64.tar.gz"
      sha256 "7dc1449bc9fbfb8c7552894273aa7fe1d959e43837ccb66c54db554faac91a34"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.91/dibbla_1.2.91_linux_arm64.tar.gz"
      sha256 "ab0ccd2c1db47e484886f79af017836341553e10b7312d7acc42c5376b2f3f53"
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
