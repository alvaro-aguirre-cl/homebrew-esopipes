# typed: true
# frozen_string_literal: true

# Kmos
class EsopipeKmos < Formula
  desc "ESO Kmos recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/kmos/kmos-kit-4.4.4.tar.gz"
  # sha256 "0d80c8cd55a271f2cb31549483ee139ac2e8054c759825d56bb605c41779a10a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?kmos-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "pkg-config"
  depends_on "telluriccorr"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "kmos-#{version_norevision}.tar.gz"
    cd "kmos-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-telluriccorr=#{Formula["telluriccorr"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "kmos_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page kmos_dark")
  end
end
