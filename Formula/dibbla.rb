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
  version "1.2.58"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.58/dibbla_1.2.58_darwin_amd64.tar.gz"
      sha256 "cd69bfdfabea6edbf512f724ad3af7dcb28ded7c5e5f190d98277a75cb68b8f3"
    end
    if Hardware::CPU.arm?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.58/dibbla_1.2.58_darwin_arm64.tar.gz"
      sha256 "e632329ee74090fff64528726565e2db51c6bece4f05e874a6f0da587abd31f0"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.58/dibbla_1.2.58_linux_amd64.tar.gz"
      sha256 "e902317a3f3afdc34f2ea07ee3d025524ec68c71e11cd7820d2751450619977a"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dibbla-agents/dibbla-cli/releases/download/v1.2.58/dibbla_1.2.58_linux_arm64.tar.gz"
      sha256 "95f4019828384467058e6ea318ce82d9d25cf5d9d66ddfdce5b0ed24d356a631"
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
