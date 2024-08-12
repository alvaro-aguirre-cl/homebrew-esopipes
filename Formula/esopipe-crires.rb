# typed: true
# frozen_string_literal: true

# Crires
class EsopipeCrires < Formula
  desc "ESO Crires recipe plugin"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/crires/crire-kit-2.3.18.tar.gz"
  # sha256 "0d80c8cd55a271f2cb31549483ee139ac2e8054c759825d56bb605c41779a10a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?crire-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "crire-#{version_norevision}.tar.gz"
    cd "crire-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}"

      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "crires_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page crires_dark")
  end
end
