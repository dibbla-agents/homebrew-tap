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
  version "1.2.72"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.72/dibbla_1.2.72_darwin_amd64.tar.gz"
      sha256 "b5637fed7cea59965da6c4b188fe2cb790520fd8aa7200d0c6b0461dc2fede71"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.72/dibbla_1.2.72_darwin_arm64.tar.gz"
      sha256 "ba85807cc18839e3139088ded720876e235d9a898033231c67cabd73e2c13244"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.72/dibbla_1.2.72_linux_amd64.tar.gz"
      sha256 "7bcbc4bd4a225ee18e747d00a0708c5a60605b53049b26ac9618965be0c14387"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.72/dibbla_1.2.72_linux_arm64.tar.gz"
      sha256 "b64d6a73f45b5305e110a0b70ff4c2fa1cca0d3fffa2784689c92dfe1a7d9db4"
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
