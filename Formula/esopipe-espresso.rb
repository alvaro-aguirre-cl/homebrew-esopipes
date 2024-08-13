# typed: strict
# frozen_string_literal: true

# Espresso
class EsopipeEspresso < Formula
  desc "ESO ESPRESSO recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/espresso/espdr-kit-3.2.0.tar.gz"
  sha256 "8d7d04a8434684a5e941e4d33a77eba5ce26e9c195e0d357c1ebc94944cf5a7a"
  license "GPL-2.0-or-later"
  revision 1


  livecheck do
    url :homepage
    regex(/href=.*?espdr-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "cpl"
  depends_on "erfa"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "espdr-#{version_norevision}.tar.gz"
    cd "espdr-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "espdr_mbias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page espdr_mbias")

  end
end
