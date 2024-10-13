class CplAT732 < Formula
    desc "ISO-C libraries for developing astronomical data-reduction tasks"
    homepage "https://www.eso.org/sci/software/cpl/"
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cpl/cpl-7.3.2.tar.gz"
    sha256 "a50c265a8630e61606567d153d3c70025aa958a28473a2411585b96894be7720"
    license "GPL-2.0-or-later"
    revision 1
  
    livecheck do
      url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cpl/"
      regex(/href=.*?cpl[._-]v?(\d+(?:\.\d+)+)\.t/i)
    end
  
  
    depends_on "cfitsio@4.2.0"
    depends_on "fftw@3.3.9"
    depends_on "wcslib@8.2.2"
  
    conflicts_with "gdal", because: "both install cpl_error.h"
  
    def install
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{prefix}",
                            "--with-cfitsio=#{Formula["cfitsio"].prefix}",
                            "--with-fftw=#{Formula["fftw"].prefix}",
                            "--with-wcslib=#{Formula["wcslib"].prefix}"
      system "make", "install"
    end
  
    test do
      (testpath/"test.c").write <<~EOF
        #include <cpl.h>
        int main(){
          cpl_init(CPL_INIT_DEFAULT);
          cpl_msg_info("hello()", "Hello, world!");
          cpl_end();
          return 0;
        }
      EOF
      system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lcplcore", "-lcext", "-o", "test"
      system "./test"
    end
  end