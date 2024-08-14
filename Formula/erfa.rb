# typed: strict
# frozen_string_literal: true

# Erfa
class Erfa < Formula
  desc "Essential Routines for Fundamental Astronomy"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/erfa-2.0.1.tar.gz"
  sha256 "3aae5f93abcd1e9519a4a0a5d6c5c1b70f0b36ca2a15ae4589c5e594f3d8f1c0"
  license "GPL-2.0-or-later"
  revision 3

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/"
    regex(/href=.*?erfa[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/erfa-2.0.1_2"
    sha256 cellar: :any, arm64_sonoma: "dc8dba11c68c628bb342f2edd3922d6a655ddae67de7f9795ce048a23ff75253"
  end

  def install
    system "./configure", "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    system "true"
  end
end
