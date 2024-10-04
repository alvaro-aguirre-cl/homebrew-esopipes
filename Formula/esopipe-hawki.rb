# typed: strict
# frozen_string_literal: true

# Hawki
class EsopipeHawki < Formula
  desc "ESO Hawki recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/hawki/hawki-kit-2.5.8.tar.gz"
  sha256 "8c5640b1ea05d790ab708169c303fa43a143002b295a3b870c4300d49cd6ff5c"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esopipe-hawki-2.5.7_4"
    sha256 cellar: :any,                 arm64_sonoma: "fec46ab3fee045ddb3cffbcb88143a632132d700ae6289c5990f57e9b4f82b2d"
    sha256 cellar: :any,                 ventura:      "5c9ebe3d8723638fe1a49ea147e1573ea6ee32856ced32aff899346d1c796815"
    sha256 cellar: :any,                 monterey:     "a902116d7fb75aa0d834aeb497707c5cca8a703253a79c5f9f5da89fc7943b17"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bfa57f0e62d688db4305e0b05ecd981705673ad38d69e5396b4d3be6d4bf0ed3"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "hawki-#{version_norevision}.tar.gz"
    cd "hawki-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "hawki_cal_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page hawki_cal_dark")
  end
end
