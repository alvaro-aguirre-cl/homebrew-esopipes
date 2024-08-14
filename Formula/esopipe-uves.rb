# typed: strict
# frozen_string_literal: true

# Uves
class EsopipeUves < Formula
  desc "ESO Uves recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/uves/uves-kit-6.4.6.tar.gz"
  sha256 "0d80c8cd55a271f2cb31549483ee139ac2e8054c759825d56bb605c41779a10a"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url :homepage
    regex(/href=.*?uves-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esopipe-uves-6.4.6_4"
    sha256 cellar: :any,                 arm64_sonoma: "8e1334e8fcb566d20df1195e378bf8e3d730d07d2138f290c23ce6e9b37bd6d8"
    sha256 cellar: :any,                 ventura:      "629deffb6c6159dba724bd5dc9290e630f82ae284b6f754b28b2c1e209bca342"
    sha256 cellar: :any,                 monterey:     "5e4b0c479ed2f5a78a561baf747005047e03dc3d061058d6509630e0820f9e92"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "24c4f8f917bc0f055225b7a5547739a2725c0b982c213894581b6811e60e3e0a"
  end

  depends_on "cfitsio"
  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "uves-#{version_norevision}.tar.gz"
    cd "uves-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-cfitsio=#{Formula["cfitsio"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "uves_cal_mbias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page uves_cal_mbias")
  end
end
