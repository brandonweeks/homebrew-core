class Opencbm < Formula
  desc "Provides access to various floppy drive formats"
  homepage "http://www.trikaliotis.net/opencbm-alpha"
  url "http://www.trikaliotis.net/Download/opencbm-0.4.99.97/opencbm-0.4.99.97.tar.bz2"
  sha256 "f67c47470181bec2faea45ad2ac82ae237f30ad54c406b0e7dd1a4ad97b16d87"
  head "https://git.code.sf.net/p/opencbm/code.git"

  bottle do
    sha256 "b259c17a32d88330c3c68c1808556332c085fd4556780a3399a63d1e196b6047" => :sierra
    sha256 "37ba85e14c150298282184e951463d6f144e254552b02989d37fda2b73048bab" => :el_capitan
    sha256 "ebae0f7ec2738011329779d8bb419838ad11bb6397e687f0ea43ae12ad6df259" => :yosemite
    sha256 "a717325f45b16e0565167221054589fe37ed9d8c90e5cff63a41ebb2ced343d3" => :mavericks
  end

  # cc65 is only used to build binary blobs included with the programs; it's
  # not necessary in its own right.
  depends_on "cc65" => :build
  depends_on "libusb-compat"

  def install
    # This one definitely breaks with parallel build.
    ENV.deparallelize

    args = %W[
      -fLINUX/Makefile
      LIBUSB_CONFIG=#{Formula["libusb-compat"].bin}/libusb-config
      PREFIX=#{prefix}
      MANDIR=#{man1}
    ]

    # The build is buried one directory down.
    cd "opencbm" do
      system "make", *args
      system "make", "install-all", *args
    end
  end

  test do
    system "#{bin}/cbmctrl", "--help"
  end
end
