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
  version "1.2.68"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.68/dibbla_1.2.68_darwin_amd64.tar.gz"
      sha256 "b88fe21715e906e513d3ec2f3cf5bfba929c27072d131d284751d9b2793e403a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.68/dibbla_1.2.68_darwin_arm64.tar.gz"
      sha256 "c9c54d58b8d9b77a278395d8b0d8401bf3ea0aa9dd95aaddf258722428ee14f8"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.68/dibbla_1.2.68_linux_amd64.tar.gz"
      sha256 "27f8ca70edf31c208f42e7af494a13970ce1cc389a3214f39f0e17ea94548314"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.68/dibbla_1.2.68_linux_arm64.tar.gz"
      sha256 "500b15f8c46bb2b1048443fa7038d4694b5c62ba18bb91a54651273f4f97ea64"
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
