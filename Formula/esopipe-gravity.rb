# typed: true
# frozen_string_literal: true

# Gravity
class EsopipeGravity < Formula
  desc "ESO Gravity recipe plugin"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/gravity/gravity-kit-1.6.7-2.tar.gz"
  # sha256 "0d80c8cd55a271f2cb31549483ee139ac2e8054c759825d56bb605c41779a10a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?gravity-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "gravity-#{version_norevision}.tar.gz"
    cd "gravity-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "gravity_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page gravity_dark")
  end
end
