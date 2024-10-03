# typed: strict
# frozen_string_literal: true

# Crires
class EsopipeCrires < Formula
  desc "ESO Crires recipe plugin"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/crires/crire-kit-2.3.19.tar.gz"
  sha256 "bb61983ba2c57b45f2d1ebd78f321e12badff824351ace4d4227fa97ead2bbe6"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?crire-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esopipe-crires-2.3.18-1_4"
    sha256 cellar: :any,                 arm64_sonoma: "b915ab8e0fcef8732ea1928fab36919cca7638250f0bc82d6b635c0a1a17ef63"
    sha256 cellar: :any,                 ventura:      "9ac7beb127c9938f623a91695e7b207258d474e62651d7973b8463fd54a81353"
    sha256 cellar: :any,                 monterey:     "972d6993ca74c1f00881393b42a117977f30ec4abe94fe210becf4c4aeb9afd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a5ed2a5f87f5ef0285da618ba32c7512ae9be832c73538d62df8e0d3bdbdddff"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "libffi"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "crire-#{version_norevision}.tar.gz"
    cd "crire-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-libffi=#{Formula["libffi"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "crires_spec_jitter -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page crires_spec_jitter")
  end
end
