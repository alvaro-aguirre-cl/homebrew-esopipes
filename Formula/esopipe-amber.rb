# typed: strict
# frozen_string_literal: true

## Datastatic
class EsopipeAmber < Formula
  desc "ESO Amber recipe plugin (Calibration Data)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/amber/amber-kit-4.4.5-1.tar.gz"
  sha256 "ab1321479850c42c2eb0f24966dbe91b994cb48e1ccc99f8722206edcc5cca3b"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?amber-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "esopipe-amber-recipes"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "amber-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/amber-#{version_norevision}").install Dir["amber-calib-#{version_norevision}/cal/*"]
  end

  test do
    system "true"
  end
end
