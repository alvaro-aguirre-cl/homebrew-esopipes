# typed: strict
# frozen_string_literal: true

# Erfa
class Erfa < Formula
  desc "Essential Routines for Fundamental Astronomy"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/erfa-2.0.1.tar.gz"
  sha256 "3aae5f93abcd1e9519a4a0a5d6c5c1b70f0b36ca2a15ae4589c5e594f3d8f1c0"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/"
    regex(/href=.*?erfa[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/erfa-2.0.1_4"
    sha256 cellar: :any,                 arm64_sonoma: "7dee46d836566b0a631db8eab219ef24aecaa3ffc8e4bfdcacb0c59207f70c83"
    sha256 cellar: :any,                 ventura:      "ea08079d72b4db147179572ba93c1919c23b08ed5a15f8dca32767790ea7d070"
    sha256 cellar: :any,                 monterey:     "5081784fa286875f17cb5ca76f973a0deda95f0197989eeec8d94102b3fecce3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f1e5c62da26e38b0b57e80112e2cc57975441c36c03f3920c8cd7e2da1fc8737"
  end

  def install
    system "./configure", "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    system "true"
  end
end
