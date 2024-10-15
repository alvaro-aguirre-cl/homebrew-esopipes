# typed: strict
# frozen_string_literal: true

# Hawki
class EsopipeHawkiRecipes < Formula
  desc "ESO Hawki recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/hawki/hawki-kit-2.5.8.tar.gz"
  sha256 "8c5640b1ea05d790ab708169c303fa43a143002b295a3b870c4300d49cd6ff5c"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "cpl@7.3.2"
  depends_on "esorex"
  depends_on "gsl@2.6"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "hawki-#{version_norevision}.tar.gz"
    cd "hawki-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl@7.3.2"].prefix}",
             "--with-gsl=#{Formula["gsl@2.6"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "hawki_cal_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page hawki_cal_dark")
  end
end
