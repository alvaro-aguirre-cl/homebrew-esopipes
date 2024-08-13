# typed: true
# frozen_string_literal: true

# Amber
class EsopipeAmber < Formula
  desc "ESO Amber recipe plugin"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/amber/amber-kit-4.4.5.tar.gz"
  sha256 "02cc06606c220ae8d5284b33c49be6b97c473b740aa331631c189f3b6d45a58b"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?amber-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "erfa"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "amber-#{version_norevision}.tar.gz"
    cd "amber-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "amber_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page amber_dark")
  end
end