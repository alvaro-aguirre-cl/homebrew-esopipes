# typed: strict
# frozen_string_literal: true

# Muse
class EsopipeMuse < Formula
  desc "ESO Muse recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/muse/muse-kit-2.10.10.tar.gz"
  sha256 "d3d51e755a0fdffc21d5730e0041f4e3a4826ec9ffcb97c1f0f69860a7a693df"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url :homepage
    regex(/href=.*?muse-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esopipe-muse-2.10.10_4"
    sha256 cellar: :any,                 arm64_sonoma: "61b18544f201e4b9f89d23776af51f99b4ac794925e2ace84aac7115f226b150"
    sha256 cellar: :any,                 ventura:      "a425cb17e5aaa53e952befa931551de81c8e49bf9b28b319bed114d30548d32a"
    sha256 cellar: :any,                 monterey:     "26207e0ad39223c1f47c874d4e8bd37bebc08e9a77d79c3723138cb0b0a9a2ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "70d59d5db61c11413ccfa34060526315bae9a69124830d259a29523481af627f"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "muse-#{version_norevision}.tar.gz"
    cd "muse-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "muse_bias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page muse_bias")
  end
end
