# typed: strict
# frozen_string_literal: true

# Kmos
class EsopipeKmos < Formula
  desc "ESO Kmos recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/kmos/kmos-kit-4.4.4.tar.gz"
  sha256 "455b58e777335f59f31e7af56d77d64f54ea8a9f58dedae9851fbf75864de612"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url :homepage
    regex(/href=.*?kmos-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esopipe-kmos-4.4.4_4"
    sha256 cellar: :any,                 arm64_sonoma: "f88e225a1c6e9757b12dc8ebf494c2e197131182192b78006c0cad7c3e84c789"
    sha256 cellar: :any,                 ventura:      "924ff16849c318c22dbc48d352869c5519be977411c79a765fa0404a93587b59"
    sha256 cellar: :any,                 monterey:     "b3b01a969a60f28485376df1a4929853f756970efad3c33a90e9e86dd6d4aee9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dd58f8f03342dc554f134f77416b3ad5495070a5ddfc077da30d7c91901a7c06"
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

      rm bin/"kmos_calib.py"
      rm bin/"kmos_verify.py"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "kmos_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page kmos_dark")
  end
end
