# typed: true
# frozen_string_literal: true

# Cr2Res
class EsopipeCr2Res < Formula
  desc "ESO CR2RES recipe plugin"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/cr2res/cr2res-kit-1.4.4.tar.gz"
  # sha256 "0d80c8cd55a271f2cb31549483ee139ac2e8054c759825d56bb605c41779a10a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?cr2res-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "cpl"
  depends_on "erfa"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "cr2res-#{version_norevision}.tar.gz"
    cd "cr2res-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "cr2res_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page cr2res_dark")
  end
end
