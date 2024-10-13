# typed: strict
# frozen_string_literal: true

# Detmon
class Detmon < Formula
  desc "ESO DETMON instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/detmon/detmon-1.3.14.tar.gz"
  sha256 "4d7ea0eb8e082d741ebd074c53165d2b7b1868582bde57ab715833efd17f69f3"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/detmon/"
    regex(/href=.*?detmon[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  depends_on "cpl@7.3.2"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl@2.6"

  def install
    system "./configure", "--prefix=#{prefix}",
           "--with-cpl=#{Formula["cpl"].prefix}",
           "--with-curl=#{Formula["curl"].prefix}",
           "--with-erfa=#{Formula["erfa"].prefix}",
           "--with-esorex=#{Formula["esorex"].prefix}",
           "--with-gsl=#{Formula["gsl"].prefix}"
    system "make", "install"
  end

  test do
    system "true"
  end
end
