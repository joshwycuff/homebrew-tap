class JwTap < Formula
  desc "A helper CLI for the joshwycuff/homebrew-tap repository"
  homepage "https://github.com/joshwycuff/homebrew-tap"
  version "v0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/joshwycuff/homebrew-tap/releases/assets/218282035"
      sha256 "ab1cf1a4b3d97c42451667686767d7840258fd9437f95e57fe3e2ddd0d775e2b"
    end
  end

  def install
    bin.install "jw-tap"
  end

  test do
    assert_match "v0.1.3", shell_output("#{bin}/jw-tap version")
  end
end
