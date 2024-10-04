# typed: true
# frozen_string_literal: true

# Efosc
class EsopipeEfosc < Formula
  desc "ESO EFOSC recipe plugin"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/efosc/efosc-kit-2.3.9.tar.gz"
  sha256 "efc7ecce753a8a77946d2ed279ee399ac4a4d7170e8a1e76fe9cbb6eda7a5e6f"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?efosc-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "cfitsio"
  depends_on "cpl"
  depends_on "erfa"
  depends_on "gsl"
  depends_on "esorex"
  depends_on "pkg-config"
  depends_on "telluriccorr"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "efosc-#{version_norevision}.tar.gz"
    cd "efosc-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio"].prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}",
             "--with-telluriccorr=#{Formula["telluriccorr"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "efosc_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page efosc_dark")
  end
end
