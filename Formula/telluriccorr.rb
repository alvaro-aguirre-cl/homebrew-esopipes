# typed: strict
# frozen_string_literal: true

# Telluriccorr
class Telluriccorr < Formula
  desc "Telluric Correction"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/telluriccorr/telluriccorr-4.3.1.tar.gz"
  sha256 "a02dc7389588033efd22f71f0712f1b97d00cd732f701dee1b1e093dc062a64b"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/telluriccorr/"
    regex(/href=.*?telluriccorr[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/telluriccorr-4.3.1_4"
    sha256 arm64_sonoma: "ed9cd7785f24c07b748b02bca19d0d73141e1da2938d514e5e3374952bb3a4f0"
    sha256 ventura:      "96509dcfa1bed512468d5e719aaf8fec8c51b8af17e2e9f7b241d49d7b7ead06"
    sha256 monterey:     "2c1a9ef3d0f2543389e45de69d8eabb1a4e51480a738a6ce46921b58f6212c95"
    sha256 x86_64_linux: "92ae8eec61ae2bcaf8423ddff91fe4e3dad19f4f54cf2ad0d60b7f2d19e24019"
  end

  depends_on "cpl"

  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    system "./configure", "--prefix=#{prefix}",
           "--with-cpl=#{Formula["cpl"].prefix}"
    system "make", "install"
  end

  test do
    system "true"
  end
end
