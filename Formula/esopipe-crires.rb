# typed: strict
# frozen_string_literal: true

# Crires
class EsopipeCrires < Formula
  desc "ESO Crires recipe plugin"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/crires/crire-kit-2.3.19.tar.gz"
  sha256 "bb61983ba2c57b45f2d1ebd78f321e12badff824351ace4d4227fa97ead2bbe6"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?crire-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esopipe-crires-2.3.19"
    sha256 cellar: :any, arm64_sonoma: "06f9d8aec18bcabb10c042a6d7442f7a3016190db937f14d65f1a82ad10d6e43"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "libffi"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "crire-#{version_norevision}.tar.gz"
    cd "crire-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-libffi=#{Formula["libffi"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "crires_spec_jitter -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page crires_spec_jitter")
  end
end
