# typed: strict
# frozen_string_literal: true

# Esorex library
class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.8.tar.gz"
  sha256 "5c024203d94331a08720bee9ea63e2ffb12bb6cf76005e4c69df782ea1b3d890"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/"
    regex(/href=.*?esorex[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esorex-3.13.8_4"
    sha256 arm64_sonoma: "77dbc3d490055ae79d8ae0347de851a79e4d9960aac84814f4337bbe9fc0cd14"
    sha256 ventura:      "a145a9cfef67cf4d48e36eefa6152afb8c21aea7c0135ee854d99549b075874f"
    sha256 monterey:     "a1f3773c9a987a97b05836d42d7bff46847462da50ce39f5f22b315978f20261"
    sha256 x86_64_linux: "0f9b0a806f9ebe9bbbd50bc716b3a1efd8991067c482161656646260ff81105a"
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
