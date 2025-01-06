class JwTap < Formula
  desc "A helper CLI for the joshwycuff/homebrew-tap repository"
  homepage "https://github.com/joshwycuff/homebrew-tap"
  version "v0.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/joshwycuff/homebrew-tap/releases/assets/218284139"
      sha256 "cafae420fac6fb02438799e31b7c4f2280d285f7af8dd08f997af42e12f920ac"
    end
  end

  def install
    bin.install "jw-tap"
  end

  test do
    assert_match "v0.1.4", shell_output("#{bin}/jw-tap version")
  end
end
