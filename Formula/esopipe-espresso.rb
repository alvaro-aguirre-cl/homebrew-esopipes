# typed: strict
# frozen_string_literal: true

# Espresso
class EsopipeEspresso < Formula
  desc "ESO ESPRESSO recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/espresso/espdr-kit-3.2.0.tar.gz"
  sha256 "8d7d04a8434684a5e941e4d33a77eba5ce26e9c195e0d357c1ebc94944cf5a7a"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url :homepage
    regex(/href=.*?espdr-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esopipe-espresso-3.2.0_4"
    sha256 arm64_sonoma: "70113bf74c6367d0088090d624b8c5b27b8a7e302e4fb65c1626c0c895c9d166"
    sha256 ventura:      "624752fe6718454ca8ce1dd2651a28c61c3b4985539a265c475e31537c6a5ecd"
    sha256 monterey:     "084c64bad8116e39be0f6328a478a021dd6ee2ffcfac183b1c78a4b058490dcb"
    sha256 x86_64_linux: "a60a44b48b81595a882af1b7eea5efc6fe96946b7599c725f1700a0e1148a1d9"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "libffi"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "espdr-#{version_norevision}.tar.gz"
    cd "espdr-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}",
             "--with-libffi=#{Formula["libffi"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "espdr_mbias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page espdr_mbias")
  end
end
