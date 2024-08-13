# typed: strict
# frozen_string_literal: true

## Datastatic
class EsopipeCriresDatastatic < Formula
  desc "ESO Crires recipe plugin (Calibration Data)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/crires/crire-kit-2.3.18-1.tar.gz"
  sha256 "8ef83d1e51a7836280c35aa71a909cce74035688461f0c47540e5514c716f2af"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?crire-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "crire-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/crire-#{version_norevision}").install Dir["crire-calib-#{version_norevision}/cal/*"]
  end

  test do
    system "true"
  end
end
