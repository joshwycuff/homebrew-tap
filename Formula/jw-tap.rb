class JwTap < Formula
  desc "jw-tap: A helper CLI for the joshwycuff/homebrew-tap repository"
  homepage "https://github.com/joshwycuff/homebrew-tap"
  version "v0.1.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshwycuff/homebrew-tap/releases/download/jw-tap-v0.1.5/jw-tap-v0.1.5-darwin-arm64.tar.gz"
      sha256 "952d407d3bd57b7a958269f0882c9cc0a753cdd8bce873fb5322d98e97050abd"
    end
  end

  def install
    bin.install "jw-tap"
  end

  test do
    assert_match "v0.1.5", shell_output("#{bin}/jw-tap version")
  end
end
