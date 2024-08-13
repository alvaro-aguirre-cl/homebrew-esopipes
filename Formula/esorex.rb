# typed: strict
# frozen_string_literal: true

# Esorex library
class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.8.tar.gz"
  sha256 "5c024203d94331a08720bee9ea63e2ffb12bb6cf76005e4c69df782ea1b3d890"
  license "GPL-2.0-or-later"
  revision 2

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/"
    regex(/href=.*?esorex[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esorex-3.13.8_2"
    sha256 arm64_sonoma: "8775ea244ca69e5ed1a5ab0d02dda58f47c2c3a7cc935fc5360c72f8f55f56d4"
  end

  depends_on "cpl"
  depends_on "gsl"
  depends_on "libffi"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--with-cpl=#{Formula["cpl"].prefix}",
           "--with-gsl=#{Formula["gsl"].prefix}",
           "--with-libffi=#{Formula["libffi"].prefix}",
           "--with-included-ltdl"
    system "make", "install"
    inreplace prefix/"etc/esorex.rc", prefix/"lib/esopipes-plugins", HOMEBREW_PREFIX/"lib/esopipes-plugins"
  end

  test do
    assert_match "ESO Recipe Execution Tool, version #{version}", shell_output("#{bin}/esorex --version")
  end
end
