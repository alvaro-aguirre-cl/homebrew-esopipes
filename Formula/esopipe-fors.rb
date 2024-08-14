# typed: strict
# frozen_string_literal: true

# Fors
class EsopipeFors < Formula
  desc "ESO FORS recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/fors/fors-kit-5.6.5-7.tar.gz"
  sha256 "e492be42ae3b96e48a2a3b2981feff8712fb2d616fd1f3f3f42ba243add2a15b"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url :homepage
    regex(/href=.*?fors-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esopipe-fors-5.6.5-7_4"
    sha256 arm64_sonoma: "72d2708ec99ca645fd982d393a490624d93962504df5887a6104e91815da60fd"
    sha256 ventura:      "887b87b25548a49bd2df26986dff99c6ee26493c9b8ed214aed905f372c3e391"
    sha256 monterey:     "cec11cb9dfb89de90e56202e6cdf6f3b743661a08fd50f534fbe8536b93f2f4c"
    sha256 x86_64_linux: "478982d181b0999ca70e89a0f04a44e48cde6d9edd6965ee12f7fc1c6024fcaa"
  end

  depends_on "cfitsio"
  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"
  depends_on "telluriccorr"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "fors-#{version_norevision}.tar.gz"
    cd "fors-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio"].prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-telluriccorr=#{Formula["telluriccorr"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "fors_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page fors_dark")
  end
end
